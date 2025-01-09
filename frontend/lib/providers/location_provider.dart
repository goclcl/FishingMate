import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/location.dart';

part 'location_provider.g.dart';

/// 사용자의 현재 위치(위도, 경도)를 가져오는 Provider
@riverpod
Future<Map<String, double>> location(Ref ref) async {
  //위치 정보 가져옴
  final position = await determinePosition();

  //위도, 경도를 Map으로 반환
  return {
    'latitude': position.latitude,
    'longitude': position.longitude,
  };
}
