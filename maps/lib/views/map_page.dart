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
      body: Map(),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LocationButton(),
          SizedBox(height: 10),
          ToggleTrackButton(),
          SizedBox(height: 10),
          RouteButton(),
        ],
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (!state.locationAvailable) return Center(child: Text('No location available'));
        final mapBloc = context.read<MapBloc>();
        mapBloc.add(MapLocationUpdateEvent(state.location!));

        final CameraPosition cameraPosition = CameraPosition(target: state.location!, zoom: 15);
        return SafeArea(
          child: GoogleMap(
            initialCameraPosition: cameraPosition,
            onMapCreated: mapBloc.initMap,
            zoomControlsEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            polylines: mapBloc.state.polylines.values.toSet(),
            onCameraMove: (CameraPosition position) => mapBloc.add(MapCameraMoveEvent(position.target)),
          ),
        );
      },
    );
  }
}
