// lib/bloc/location_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitial()) {
    on<GetLocation>(_onGetLocation);
  }

  Future<void> _onGetLocation(
      GetLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    try {
      // 위치 서비스 활성화 확인
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(LocationError(error: '위치 서비스가 비활성화되어 있습니다. 설정에서 활성화해주세요.'));
        return;
      }

      // 위치 권한 확인 및 요청
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(LocationError(error: '위치 권한이 거부되었습니다.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(LocationError(
            error: '위치 권한이 영구적으로 거부되었습니다. 앱 설정에서 수동으로 권한을 허용해주세요.'));
        return;
      }

      // 위치 정보 가져오기
      Position position = await Geolocator.getCurrentPosition();
      emit(LocationLoaded(
          latitude: position.latitude, longitude: position.longitude));
    } catch (e) {
      emit(LocationError(error: '위치를 가져오는 중 오류가 발생했습니다: $e'));
    }
  }
}
