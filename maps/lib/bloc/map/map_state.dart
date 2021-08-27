part of 'map_bloc.dart';

@immutable
class MapState {
  MapState({this.mapLoaded = false});
  final bool mapLoaded;

  MapState copyWith({bool? mapLoaded}) {
    return MapState(mapLoaded: mapLoaded ?? this.mapLoaded);
  }
}
