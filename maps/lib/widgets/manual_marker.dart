part of 'widgets.dart';

class ManualMarker extends StatelessWidget {
  const ManualMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.manualSelection) return _Marker();
        return Container();
      },
    );
  }
}

class _Marker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: FadeInLeft(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 2)],
                shape: BoxShape.circle,
              ),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    context.read<SearchBloc>().add(HideManualMarkerEvent());
                  },
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Transform.translate(
            offset: Offset(0, -10),
            child: BounceInDown(
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 50,
          left: 40,
          child: FadeInUp(
            child: MaterialButton(
              child: Text('Select destination', style: TextStyle(color: Colors.white)),
              onPressed: () async => await selectPlace(context),
              minWidth: MediaQuery.of(context).size.width - 150,
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectPlace(BuildContext context) async {
    computatingAlert(context);

    final trafficService = TrafficService();
    final mapBloc = context.read<MapBloc>();

    final start = context.read<LocationBloc>().state.location;
    final finish = mapBloc.state.mapCenter;

    if (start != null && finish != null) {
      final searchResponse = await trafficService.getPlaceInfo(finish);
      final drivingResponse = await trafficService.getCoordinates(start, finish);

      final geometry = drivingResponse.routes.first.geometry;
      final duration = drivingResponse.routes.first.duration;
      final distance = drivingResponse.routes.first.distance;
      final placeName = searchResponse.features?.first.text ?? '';

      final points = Poly.decode(encodedString: geometry, precision: 6).decodedCoords;
      if (points == null) return;
      final coordinates = points.map((point) => LatLng(point[0].toDouble(), point[1].toDouble())).toList();

      mapBloc.add(MapCreateRouteEvent(coordinates, distance, duration, placeName: placeName));

      Navigator.pop(context);
      context.read<SearchBloc>().add(HideManualMarkerEvent());
    }
  }
}
