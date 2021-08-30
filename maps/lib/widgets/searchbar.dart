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
              child: Row(
                children: [
                  Text('Where to?', style: TextStyle(color: Colors.black87)),
                  Spacer(),
                  Icon(Icons.search, color: Colors.black87, size: 20),
                ],
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
    computatingAlert(context);
    if (result.cancelled) return;
    if (result.manual) context.read<SearchBloc>().add(ShowManualMarkerEvent());

    final trafficService = TrafficService();
    final mapBloc = context.read<MapBloc>();

    final start = context.read<LocationBloc>().state.location;
    final finish = result.location;

    if (start != null && finish != null) {
      final drivingResponse = await trafficService.getCoordinates(start, finish);

      final geometry = drivingResponse.routes[0].geometry;
      final duration = drivingResponse.routes[0].duration;
      final distance = drivingResponse.routes[0].distance;

      final points = Poly.decode(encodedString: geometry, precision: 6).decodedCoords;
      if (points == null) return;
      final coordinates = points.map((point) => LatLng(point[0].toDouble(), point[1].toDouble())).toList();

      mapBloc.add(MapCreateRouteEvent(coordinates, distance, duration));

      context.read<SearchBloc>().add(HideManualMarkerEvent());
      context.read<SearchBloc>().add(AddToHistoryEvent(result));
    }
    Navigator.pop(context);
  }
}
