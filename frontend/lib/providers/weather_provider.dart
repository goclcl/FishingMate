import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'location_provider.dart';
import 'dio_provider.dart';

part 'weather_provider.g.dart';

final dio = Dio();

/// 사용자의 위치를 기반으로 날씨 데이터를 가져오는 Provider
@riverpod
Future<Map<String, dynamic>> weather(Ref ref) async {
  //Dio 객체 가져옴
  final dio = ref.read(dioProvider);
  // 위치 데이터를 가져옴
  final Map<String, double> location = await ref.read(locationProvider.future);

  final double? latitude = location['latitude'];
  final double? longitude = location['longitude'];

  if (latitude == null || longitude == null) {
    throw Exception('Invalid location data: latitude or longitude is null');
  }

  // 날씨 데이터를 가져옴
  final response = await dio.get('/api/weather',
      queryParameters: {'latitude': latitude, 'longitude': longitude});

  // 응답 데이터를 Map으로 반환
  return response.data as Map<String, dynamic>;
}
