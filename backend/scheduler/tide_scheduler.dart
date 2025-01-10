// ignore_for_file: cascade_invocations

import 'package:cron/cron.dart';
import 'package:mongo_dart/mongo_dart.dart';

import '../main.dart';

class TideScheduler {
  void start() {
    final cron = Cron();

    // 하루에 한 번 자정에 실행
    cron.schedule(Schedule.parse('0 0 * * *'), () async {
      final today = DateTime.now();

      try {
        await mongoDb.open();

        // 관측소 목록 가져오기
        final observatoriesCollection = mongoDb.collection('observatory');
        final tideCollection = mongoDb.collection('tide');
        final observatories = await observatoriesCollection.find().toList();

        for (final observatory in observatories) {
          final observatoryId = observatory['id'];

          for (var i = 0; i < 30; i++) {
            final date = today.add(Duration(days: i));
            final dateString =
                '${date.year}-${date.month.toString().padLeft(2, '0')}'
                '-${date.day.toString().padLeft(2, '0')}';

            // 데이터베이스에서 데이터 확인
            final exists = await tideCollection.findOne({
              'observatoryId': observatoryId,
              'date': dateString,
            });

            if (exists == null) {
              // API 호출 및 데이터 삽입
              final tideData = await fetchTideData(dateString, observatoryId);

              await tideCollection.insert({
                'observatoryId': observatoryId,
                'date': dateString,
                'tideData': tideData,
                'createdAt': DateTime.now().toUtc(),
              });
            }
          }
        }
      } catch (e) {
      } finally {
        await mongoDb.close();
      }
    });
  }

  Future<Map<String, dynamic>> fetchTideData(
      String date, ObjectId observatoryId) async {
    // TODO: API 호출 로직 작성
    // 아래는 예시 데이터
    return {
      'highTide': '3.2m',
      'lowTide': '0.5m',
      'info': 'Example tide data',
    };
  }
}
