import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase {
  final String uri = 'mongodb://localhost:27017';
  final String dbName = 'fishing_mate';
  late final Db db;

  Future<void> connect() async {
    db = Db('$uri/$dbName');
    await db.open();
  }

  Future<void> close() async {
    await db.close();
  }

  DbCollection getCollection(String name) {
    return db.collection(name);
  }
}
