import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/location_bloc.dart';
import '../bloc/location_event.dart';
import '../bloc/location_state.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationBloc()..add(GetLocation()), // 앱 시작 시 위치 요청
      child: Scaffold(
        appBar: AppBar(title: Text('사용자 위치')),
        body: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              // 위치 로딩 중
              return Center(child: CircularProgressIndicator());
            } else if (state is LocationLoaded) {
              // 위치 로드 완료
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '위도: ${state.latitude}, 경도: ${state.longitude}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Icon(Icons.check_circle, color: Colors.green, size: 48),
                    SizedBox(height: 8),
                    Text(
                      '위치 정보가 성공적으로 로드되었습니다.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              );
            } else if (state is LocationError) {
              // 위치 로드 실패
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: Colors.red, size: 48),
                    SizedBox(height: 8),
                    Text(
                      state.error,
                      style: TextStyle(fontSize: 16, color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            // 초기 상태
            return Center(child: Text('위치 정보를 가져오는 중입니다.'));
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => context.read<LocationBloc>().add(GetLocation()),
          child: Icon(Icons.location_on),
        ),
      ),
    );
  }
}
