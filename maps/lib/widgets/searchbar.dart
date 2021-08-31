part of 'widgets.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (!state.manualSelection) return _SearchBar();
        return Container();
      },
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BounceInDown(
      child: SafeArea(
        child: GestureDetector(
          onTap: () async {
            final SearchResult? searchResult = await showSearch<SearchResult?>(context: context, delegate: SearchPlace());
            if (searchResult != null) handleResult(context, searchResult);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: BlocBuilder<MapBloc, MapState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      Text(state.markers['finish']?.infoWindow.title ?? 'Where to?', style: TextStyle(color: Colors.black)),
                      Spacer(),
                      if (state.markers['finish']?.infoWindow.title == null) Icon(Icons.search, color: Colors.black87, size: 20),
                      if (state.markers['finish']?.infoWindow.title != null)
                        GestureDetector(
                          child: Icon(Icons.close, color: Colors.black87, size: 20),
                          onTap: () => context.read<MapBloc>().add(MapDeleteRouteEvent()),
                        ),
                    ],
                  );
                },
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0, 5)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  handleResult(BuildContext context, SearchResult result) async {
    if (result.manual) return context.read<SearchBloc>().add(ShowManualMarkerEvent());

    final trafficService = TrafficService();
    final mapBloc = context.read<MapBloc>();

    final start = context.read<LocationBloc>().state.location;
    final finish = result.location;

    if (start != null && finish != null) {
      computatingAlert(context);
      final drivingResponse = await trafficService.getCoordinates(start, finish);
      Navigator.pop(context);
      
      final geometry = drivingResponse.routes[0].geometry;
      final duration = drivingResponse.routes[0].duration;
      final distance = drivingResponse.routes[0].distance;
      final placeName = result.placeName;

      final points = Poly.decode(encodedString: geometry, precision: 6).decodedCoords;
      if (points == null) return;
      final coordinates = points.map((point) => LatLng(point[0].toDouble(), point[1].toDouble())).toList();

      mapBloc.add(MapCreateRouteEvent(coordinates, distance, duration, placeName: placeName));

      context.read<SearchBloc>().add(HideManualMarkerEvent());
      context.read<SearchBloc>().add(AddToHistoryEvent(result));
    }
  }
}
