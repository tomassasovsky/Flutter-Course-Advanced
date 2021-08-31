part of 'views.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().startTracking();
  }

  @override
  void dispose() {
    context.read<LocationBloc>().endTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Map(),
          ManualMarker(),
          Positioned(child: SearchBar(), top: 20),
        ],
      ),
      floatingActionButton: FadeInRight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LocationButton(),
            SizedBox(height: 10),
            ToggleTrackButton(),
            SizedBox(height: 10),
            RouteButton(),
          ],
        ),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, locationState) {
        if (!locationState.locationAvailable) return Center(child: Text('No location available'));
        context.read<MapBloc>().add(MapLocationUpdateEvent(locationState.location!));
        return BlocBuilder<MapBloc, MapState>(
          builder: (context, mapState) {
            return GoogleMap(
              initialCameraPosition: CameraPosition(target: context.read<LocationBloc>().state.location!, zoom: 15),
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: false,
              compassEnabled: false,
              mapToolbarEnabled: false,
              onMapCreated: context.read<MapBloc>().initMap,
              polylines: mapState.polylines.values.toSet(),
              markers: mapState.markers.values.toSet(),
              onCameraMove: (CameraPosition position) {
                context.read<MapBloc>().add(MapCameraMoveEvent(position.target));
              },
            );
          },
        );
      },
    );
  }
}
