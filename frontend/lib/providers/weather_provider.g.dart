// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherHash() => r'4c9f3cdf3f31a96aa78233b71e1fa0f19ac01262';

/// 사용자의 위치를 기반으로 날씨 데이터를 가져오는 Provider
///
/// Copied from [weather].
@ProviderFor(weather)
final weatherProvider =
    AutoDisposeFutureProvider<Map<String, dynamic>>.internal(
  weather,
  name: r'weatherProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$weatherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef WeatherRef = AutoDisposeFutureProviderRef<Map<String, dynamic>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
