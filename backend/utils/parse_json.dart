import 'dart:convert';
import 'package:compute/compute.dart';

// JSON 디코딩을 별도의 Isolate에서 처리
Future<Map<String, dynamic>> parseJson(String jsonString) async {
  return compute<String, Map<String, dynamic>>(_decodeJson, jsonString);
}

Map<String, dynamic> _decodeJson(String jsonString) {
  final decoded = jsonDecode(jsonString);

  if (decoded is Map<String, dynamic>) {
    return decoded; // Map 형태일 경우 반환
  } else {
    throw FormatException(
        'Expected a Map<String, dynamic>, but got: ${decoded.runtimeType}');
  }
}
