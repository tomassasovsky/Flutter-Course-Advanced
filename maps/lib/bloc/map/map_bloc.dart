import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/themes/map_theme.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  late final GoogleMapController _mapController;

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
    if (event is MapLoadedEvent) {
      yield state.copyWith(mapLoaded: true);
    }
  }
}
