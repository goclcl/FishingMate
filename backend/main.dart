import 'dart:io';
import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';

late final Db mongoDb;

Future<void> init(InternetAddress ip, int port) async {
  // MongoDB 연결 설정
  mongoDb = Db('mongodb://localhost:27017/fishing_mate');
  await mongoDb.open();
}

Future<HttpServer> run(Handler handler, InternetAddress ip, int port) async {
  // 서버 실행
  final server = await serve(handler, ip, port);

  // 서버 종료 시 MongoDB 연결 닫기
  ProcessSignal.sigint.watch().listen((_) async {
    await mongoDb.close();
    exit(0);
  });

  return server;
}
