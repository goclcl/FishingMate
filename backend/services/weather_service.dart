import 'package:dio/dio.dart';
import '../utils/environment.dart';

final dio = Dio();

class WeatherService {
  static Future<dynamic> getWeather(double latitude, double longitude) async {
    const apiKey = Environment.apiKey; // OpenWeather API 키
    final url = 'https://api.openweathermap.org/data/2.5/weather'
        '?lat=$latitude&lon=$longitude&appid=$apiKey';

    final response = await dio.get(url);

    // 응답 데이터를 Map 형식으로 반환
    if (response.statusCode == 200) {
      return response.data! as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch weather data: ${response.statusCode}');
    }
  }
}
