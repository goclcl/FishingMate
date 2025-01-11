import 'package:dart_frog/dart_frog.dart';
import 'package:mongo_dart/mongo_dart.dart';
import '../../../main.dart';

Future<Response> onRequest(RequestContext context) async {
  // Access the incoming request.
  final request = context.request;

  // Access the request method
  final method = request.method.value;

  // Method not allowed
  if (method != 'GET') {
    return Response(statusCode: 405, body: 'Method Not Allowed');
  }

  try {
    // MongoDB에서 tide 컬렉션 가져오기
    final tideCollection = mongoDb.collection('tide');

    // 컬렉션 전체 데이터 조회
    final allTideData = await tideCollection.find().toList();

    // 데이터가 없을 경우 처리
    if (allTideData.isEmpty) {
      return Response(
        statusCode: 404,
        body: 'No data found in the tide collection',
      );
    }

    // 응답 반환
    return Response.json(body: allTideData);
  } catch (e) {
    // 오류 처리
    return Response(
      statusCode: 500,
      body: 'An error occurred: $e',
    );
  }
}
