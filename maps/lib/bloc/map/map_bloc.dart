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
    color: Colors.black87,
  );

  Polyline _destinationRoute = Polyline(
    polylineId: PolylineId('destination_route'),
    width: 4,
    color: Colors.black87,
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
        yield* toggleDrawHistoryEvent(event as MapToggleDrawHistoryEvent);
        break;
      case MapToggleTrackLocationEvent:
        yield* toggleTrackLocationEvent(event as MapToggleTrackLocationEvent);
        break;
      case MapCameraMoveEvent:
        yield state.copyWith(mapCenter: (event as MapCameraMoveEvent).location);
        break;
      case MapCreateRouteEvent:
        yield* createRouteEvent(event as MapCreateRouteEvent);
        break;
      case MapDeleteRouteEvent:
        yield* deleteRouteEvent(event as MapDeleteRouteEvent);
        break;
    }
  }

  Stream<MapState> locationUpdateEvent(MapLocationUpdateEvent event) async* {
    if (state.trackLocation) cameraTo(event.location);

    List<LatLng> points = [...this._route.points, event.location];
    this._route = this._route.copyWith(pointsParam: points);

    final polylines = state.polylines;
    polylines['route'] = this._route;
    yield state.copyWith(polylines: polylines);
  }

  Stream<MapState> toggleDrawHistoryEvent(MapToggleDrawHistoryEvent event) async* {
    this._route = this._route.copyWith(colorParam: state.drawHistory ? Colors.transparent : Colors.black87);

    final polylines = state.polylines;
    polylines['route'] = this._route;
    yield state.copyWith(drawHistory: !state.drawHistory, polylines: polylines);
  }

  Stream<MapState> toggleTrackLocationEvent(MapToggleTrackLocationEvent event) async* {
    if (!state.trackLocation) cameraTo(_route.points.last);
    yield state.copyWith(trackLocation: !state.trackLocation);
  }

  Stream<MapState> createRouteEvent(MapCreateRouteEvent event) async* {
    _destinationRoute = _destinationRoute.copyWith(pointsParam: event.coordinates);

    final polylines = state.polylines;
    polylines['destination_route'] = this._destinationRoute;

    final markerStart = Marker(
      markerId: MarkerId('start'),
      position: event.coordinates.first,
      infoWindow: InfoWindow(
        title: 'Start',
        snippet: 'Duration: ${(event.duration / 60).floor()} min',
      ),
    );

    final markerFinish = Marker(
      markerId: MarkerId('finish'),
      position: event.coordinates.last,
      infoWindow: InfoWindow(
        title: event.placeName ?? 'Finish',
        snippet: 'Distance: ${(event.distance / 1000).toStringAsPrecision(3)} Km',
      ),
    );

    final markers = {
      ...state.markers,
      'start': markerStart,
      'finish': markerFinish,
    };

    Future.delayed(Duration(milliseconds: 300), () {
      _mapController.hideMarkerInfoWindow(MarkerId('start'));
      _mapController.hideMarkerInfoWindow(MarkerId('start'));
      _mapController.showMarkerInfoWindow(MarkerId('finish'));
    });

    yield state.copyWith(polylines: polylines, markers: markers);
  }

  Stream<MapState> deleteRouteEvent(MapDeleteRouteEvent event) async* {
    _destinationRoute = _destinationRoute.copyWith(pointsParam: []);

    final polylines = state.polylines;
    polylines['destination_route'] = this._destinationRoute;

    final Map<String, Marker> markers = {};

    yield state.copyWith(polylines: polylines, markers: markers);
  }
}
