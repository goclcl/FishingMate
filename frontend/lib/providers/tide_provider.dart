import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'dio_provider.dart';

part 'tide_provider.g.dart';

final dio = Dio();

/// 조석 데이터를 가져오는 Provider
@riverpod
Future<List> tide(Ref ref) async {
  //Dio 객체 가져옴
  final dio = ref.read(dioProvider);

  // 조석석 데이터를 가져옴
  final response = await dio.get('/api/tide');

  // 응답 데이터를 Map으로 반환
  return response.data as List;
}
