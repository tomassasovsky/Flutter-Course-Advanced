import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart' show Colors;

import 'package:maps/themes/map_theme.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  late final GoogleMapController _mapController;
  Polyline _route = Polyline(
    polylineId: PolylineId('route'),
    width: 4,
  );

  void initMap(GoogleMapController mapController) {
    if (state.mapLoaded) return;
    this._mapController = mapController;
    this._mapController.setMapStyle(json.encode(mapTheme));
    add(MapLoadedEvent());
  }

  void cameraTo(LatLng to) {
    final cameraUpdate = CameraUpdate.newLatLng(to);
    this._mapController.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    switch (event.runtimeType) {
      case MapLoadedEvent:
        yield state.copyWith(mapLoaded: true);
        break;
      case MapLocationUpdateEvent:
        yield* locationUpdateEvent(event as MapLocationUpdateEvent);
        break;
      case MapToggleDrawHistoryEvent:
        yield* toggleTrackEvent(event as MapToggleDrawHistoryEvent);
        break;
      case MapToggleTrackLocationEvent:
        toggleTrackLocationEvent(event as MapToggleTrackLocationEvent);
        break;
      case MapCameraMoveEvent:
        yield state.copyWith(mapCenter: (event as MapCameraMoveEvent).location);
        break;
    }
  }

  Stream<MapState> locationUpdateEvent(MapLocationUpdateEvent event) async* {
    if (state.trackLocation) cameraTo(event.location);

    List<LatLng> points = [...this._route.points, event.location];
    this._route = this._route.copyWith(pointsParam: points);

    Map<String, Polyline> polylines = state.polylines;
    polylines['route'] = this._route;
    yield state.copyWith(polylines: polylines);
  }

  Stream<MapState> toggleTrackEvent(MapToggleDrawHistoryEvent event) async* {
    final draw = state.drawHistory;
    this._route = this._route.copyWith(colorParam: draw ? Colors.transparent : Colors.black);

    Map<String, Polyline> polylines = state.polylines;
    polylines['route'] = this._route;
    yield state.copyWith(drawHistory: !draw, polylines: polylines);
  }

  Stream<MapState> toggleTrackLocationEvent(MapToggleTrackLocationEvent event) async* {
    if (!state.trackLocation) cameraTo(_route.points.last);
    yield state.copyWith(trackLocation: !state.trackLocation);
  }
}
