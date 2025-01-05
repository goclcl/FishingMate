abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final double latitude;
  final double longitude;

  LocationLoaded({required this.latitude, required this.longitude});
}

class LocationError extends LocationState {
  final String error;

  LocationError({required this.error});
}
