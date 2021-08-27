part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class LocationChangedEvent extends LocationEvent {
  LocationChangedEvent(this.location);
  final LatLng location;
}
