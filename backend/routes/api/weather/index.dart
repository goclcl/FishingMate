import 'package:dart_frog/dart_frog.dart';
import '../../../services/weather_service.dart';

Future<Response> onRequest(RequestContext context) async {
  //Access the incoming request.
  final request = context.request;

  //Access the request method
  final method = request.method.value;

  //Method not allowed
  if (method != 'GET') {
    return Response(statusCode: 405);
  }

  //쿼리 파라미터에서 위도, 경도 가져오기
  final params = request.uri.queryParameters;
  final latitude = double.parse(params['latitude'] ?? '0.0');
  final longitude = double.parse(params['longitude'] ?? '0.0');

  //날씨 데이터 가져오기
  final weatherData = await WeatherService.getWeather(latitude, longitude);

  return Response.json(body: weatherData);
}
