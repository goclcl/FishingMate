import 'dart:convert';
import 'package:dio/dio.dart';
import '../utils/environment.dart';

final dio = Dio();

class TideService {
  // 날짜, 관측소 번호 입력받아서 조석 데이터 반환
  static Future<Map<String, dynamic>> getTide(
      String date, dynamic obsCode) async {
    const apiKey = Environment.khoaApiKey;
    final url = 'http://www.khoa.go.kr/api/oceangrid/tideObsPreTab/search.do'
        '?ServiceKey=$apiKey&ObsCode=$obsCode&Date=$date&ResultType=json';
    print('$url');
    final response = await dio.get(url);

    // 응답 데이터를 Map으로 반환
    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.data) as Map<String, dynamic>;
        print(data.runtimeType); // 확인용
        return data;
      } catch (e) {
        throw Exception('Failed to parse JSON: $e');
      }
    } else {
      throw Exception('Failed to fetch tide data: ${response.statusCode}');
    }
  }
}
