part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class MapLoadedEvent extends MapEvent {}

class MapLocationUpdateEvent extends MapEvent {
  MapLocationUpdateEvent(this.location);
  final LatLng location;
}

class MapToggleDrawHistoryEvent extends MapEvent {}

class MapToggleTrackLocationEvent extends MapEvent {}

class MapCameraMoveEvent extends MapEvent {
  MapCameraMoveEvent(this.location);
  final LatLng location;
}

class MapCreateRouteEvent extends MapEvent {
  final List<LatLng> coordinates;
  final double distance;
  final double duration;
  final String? placeName;

  MapCreateRouteEvent(
    this.coordinates,
    this.distance,
    this.duration, {
    this.placeName,
  });
}

class MapDeleteRouteEvent extends MapEvent {}
