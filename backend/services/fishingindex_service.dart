import 'package:dio/dio.dart';
import '../utils/environment.dart';
import '../utils/parse_json.dart';

final dio = Dio();

class FishingIndexService {
  // 낚시 지수 데이터 반환
  static Future<List<Map<String, dynamic>>> getFishingIndex() async {
    const apiKey = Environment.khoaApiKey;
    final url = 'http://www.khoa.go.kr/api/oceangrid/fcIndexOfType/search.do'
        '?ServiceKey=$apiKey&Type=SF&ResultType=json';
    final response = await dio.get(url);

    final jsonData = await parseJson(response.data as String);
    final listData = jsonData['result']['data'] as List;

    final extectedData = await _extractFishingIndexData(listData);

    return extectedData;
  }

  // response data에서 필요한 key:value 값들만 추출하는 함수
  static Future<List<Map<String, dynamic>>> _extractFishingIndexData(
    List<dynamic> listData,
  ) async {
    final extractedData = listData.map((item) {
      return {
        'time_type': item['time_type'], // 오전/오후/일
        'fish_name': item['fish_name'], // 물고기 이름
        'lon': item['lon'], // 경도
        'lat': item['lat'], // 위도
        'water_temp': item['water_temp'], // 수온
        'total_score': item['total_score'], // 총 평점
        'name': item['name'], // 위치 이름
        'wind_speed': item['wind_speed'], // 풍속
        'date': item['date'], // 날짜
        'wave_height': item['wave_height'], // 파고
      };
    }).toList();

    return extractedData;
  }
}
