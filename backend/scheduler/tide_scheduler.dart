// ignore_for_file: cascade_invocations

import 'package:cron/cron.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../main.dart';
import '../services/tide_service.dart';

class TideScheduler {
  void start() {
    final cron = Cron();

    // 등록 시 첫 실행
    _executeTask();

    // 매일 자정에 실행
    cron.schedule(Schedule.parse('0 0 * * *'), () async {
      await _executeTask();
    });
  }

  Future<void> _executeTask() async {
    final today = DateTime.now();

    print('123');
    try {
      // 관측소 목록 가져오기
      final observatoriesCollection = mongoDb.collection('observatory');
      final tideCollection = mongoDb.collection('tide');
      final observatories = await observatoriesCollection.find().toList();

      for (final observatory in observatories) {
        final obsCode = observatory['id'];

        for (var i = 0; i < 30; i++) {
          final date = today.add(Duration(days: i));
          final dateString =
              '${date.year}${date.month.toString().padLeft(2, '0')}'
              '${date.day.toString().padLeft(2, '0')}';

          // 데이터베이스에서 데이터 확인
          final exists = await tideCollection.findOne({
            'obsId': obsCode,
            'meta.date': dateString,
          });

          if (exists == null) {
            // API 호출 및 데이터 삽입
            print('111');
            final tideData = await TideService.getTide(dateString, obsCode);
            print('$tideData');

            // JSON 파싱 및 유효성 검사
            final tideResult = tideData['result'];
            if (tideResult == null ||
                tideResult['data'] == null ||
                tideResult['meta'] == null) {
              continue;
            }

            final tideEntries = tideResult['data'] as List;
            final tideMeta = tideResult['meta'];

            // 데이터 정제 및 삽입
            final tideDocuments = tideEntries.map((entry) {
              return {
                'tph_level': entry['tph_level'],
                'tph_time': entry['tph_time'],
                'hl_code': entry['hl_code'],
              };
            }).toList();

            final document = {
              "obsId": tideMeta['obs_post_id'], // 관측소 ID
              "data": tideDocuments, // 변환된 데이터 배열
              "meta": {
                "obsLat": tideMeta['obs_lat'],
                "obsLon": tideMeta['obs_lon'],
                "obsPostName": tideMeta['obs_post_name'],
                "date": dateString,
              },
            };

            // MongoDB에 삽입
            await tideCollection.insert(document);
          }
        }
      }
    } catch (e) {
      print('여기임');
      print('Error occurred during tide data processing: $e');
    }
  }
}
