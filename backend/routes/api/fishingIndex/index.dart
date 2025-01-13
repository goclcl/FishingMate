import 'package:dart_frog/dart_frog.dart';
import '../../../main.dart';

Future<Response> onRequest(RequestContext context) async {
  print('FishingIndex route hit!');

  // Access the incoming request.
  final request = context.request;

  // Access the request method
  final method = request.method.value;

  // Method not allowed
  if (method != 'GET') {
    return Response(statusCode: 405, body: 'Method Not Allowed');
  }

  try {
    // MongoDB에서 fishingindex 컬렉션 가져오기
    final collection = mongoDb.collection('fishingindex');

    // 컬렉션 전체 데이터 조회
    final allData = await collection.find().toList();

    // 데이터가 없을 경우 처리
    if (allData.isEmpty) {
      return Response(
        statusCode: 404,
        body: 'No data found in the tide collection',
      );
    }

    // 응답 반환
    return Response.json(body: allData);
  } catch (e) {
    // 오류 처리
    return Response(
      statusCode: 500,
      body: 'An error occurred: $e',
    );
  }
}
