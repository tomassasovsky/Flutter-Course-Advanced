import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:geolocator/geolocator.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationState());

  late StreamSubscription<Position> _positionSubscription;
  final _positionStream = Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.high, distanceFilter: 2);

  void startTracking() {
    _positionSubscription = _positionStream.listen((Position position) {
      final location = LatLng(position.latitude, position.longitude);
      add(LocationChangedEvent(location));
    });
  }

  void endTracking() {
    _positionSubscription.cancel();
  }

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if (event is LocationChangedEvent) {
      yield state.copyWith(
        locationAvailable: true,
        location: event.location,
      );
    }
  }
}
