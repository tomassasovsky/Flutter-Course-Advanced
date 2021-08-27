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
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) => Map(state: state),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          LocationButton(),
        ],
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({Key? key, required this.state}) : super(key: key);
  final LocationState state;

  @override
  Widget build(BuildContext context) {
    if (!state.locationAvailable) {
      return Center(child: Text('No location available'));
    }

    final CameraPosition cameraPosition = CameraPosition(target: state.location!, zoom: 15);
    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: cameraPosition,
        onMapCreated: context.read<MapBloc>().initMap,
        zoomControlsEnabled: false,
        markers: {
          Marker(markerId: MarkerId('initial'), position: cameraPosition.target),
        },
      ),
    );
  }
}
