part of 'location_bloc.dart';

@immutable
class LocationState {
  final bool track;
  final bool locationAvailable;
  final LatLng? location;

  LocationState({
    this.track = true,
    this.locationAvailable = false,
    this.location,
  });

  LocationState copyWith({
    bool? track,
    bool? locationAvailable,
    LatLng? location,
  }) {
    return LocationState(
      track: track ?? this.track,
      locationAvailable: locationAvailable ?? this.locationAvailable,
      location: location ?? this.location,
    );
  }
}
