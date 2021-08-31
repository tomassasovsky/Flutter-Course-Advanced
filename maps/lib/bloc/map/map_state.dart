part of 'map_bloc.dart';

@immutable
class MapState {
  MapState({
    this.drawHistory = true,
    this.mapLoaded = false,
    this.trackLocation = false,
    this.mapCenter,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  })  : this.polylines = polylines ?? Map(),
        this.markers = markers ?? Map();

  final bool mapLoaded;
  final bool drawHistory;
  final bool trackLocation;
  final LatLng? mapCenter;
  late final Map<String, Polyline> polylines;
  late final Map<String, Marker> markers;

  MapState copyWith({
    bool? drawHistory,
    bool? mapLoaded,
    bool? trackLocation,
    LatLng? mapCenter,
    Map<String, Polyline>? polylines,
    Map<String, Marker>? markers,
  }) {
    return MapState(
      mapLoaded: mapLoaded ?? this.mapLoaded,
      drawHistory: drawHistory ?? this.drawHistory,
      trackLocation: trackLocation ?? this.trackLocation,
      mapCenter: mapCenter ?? this.mapCenter,
      polylines: polylines ?? this.polylines,
      markers: markers ?? this.markers,
    );
  }
}
