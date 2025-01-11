import 'package:mongo_dart/mongo_dart.dart';

class Database {
  final Db db;

  Database(this.db);

  // 관측소 목록 가져오기
  Future<List<Map<String, dynamic>>> getObservatories() async {
    final collection = db.collection('observatory');
    return await collection.find().toList();
  }

  // 특정 날짜의 조석 데이터 존재 여부 확인
  Future<bool> checkTideDataExists(String observatoryId, String date) async {
    final collection = db.collection('tide_data');
    final data = await collection.findOne({
      'observatoryId': observatoryId,
      'date': date,
    });
    return data != null;
  }

  // 조석 데이터 삽입
  Future<void> insertTideData(
      String observatoryId, String date, Map<String, dynamic> tideData) async {
    final collection = db.collection('tide_data');
    await collection.insert({
      'observatoryId': observatoryId,
      'date': date,
      'data': tideData,
    });
  }
}
