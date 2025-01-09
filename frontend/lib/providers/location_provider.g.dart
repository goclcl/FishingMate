// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationHash() => r'120f862b51e03f3e6ee7e04ecee8fc045db8fa0a';

/// 사용자의 현재 위치(위도, 경도)를 가져오는 Provider
///
/// Copied from [location].
@ProviderFor(location)
final locationProvider =
    AutoDisposeFutureProvider<Map<String, double>>.internal(
  location,
  name: r'locationProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$locationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef LocationRef = AutoDisposeFutureProviderRef<Map<String, double>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
