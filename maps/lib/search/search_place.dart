import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maps/bloc/bloc.dart';
import 'package:maps/models/search_response.dart';
import 'package:maps/models/search_result.dart';
import 'package:maps/services/traffic_service.dart';

class SearchPlace extends SearchDelegate<SearchResult?> {
  final trafficService = TrafficService();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => this.query = '',
        icon: Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => this.close(context, SearchResult(cancelled: true)),
      icon: Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final history = context.read<SearchBloc>().state.history;
    if (query.isEmpty)
      return ListView(
        children: [
          ListTile(
            leading: Icon(Icons.location_on),
            title: Text('Select location manually'),
            onTap: () => this.close(context, SearchResult(manual: true)),
          ),
          if (history.isNotEmpty)
            ...history.map(
              (place) => ListTile(
                leading: Icon(Icons.history),
                title: Text(place.placeName ?? ''),
                subtitle: Text(place.description ?? ''),
                onTap: () => this.close(context, place),
              ),
            ),
        ],
      );

    return _buildSuggestions(context);
  }

  Widget _buildSuggestions(BuildContext context) {
    trafficService.getSearchSuggestions(query.trim(), context.read<LocationBloc>().state.location!);

    return StreamBuilder<SearchResponse>(
      stream: trafficService.suggestionsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

        final places = snapshot.data!.features;
        if (places == null) return Center(child: Text('No se han encontrado resultados'));

        return ListView.separated(
          padding: EdgeInsets.only(top: 10),
          itemCount: places.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Icon(Icons.place),
              title: Text(places[index].text ?? ''),
              subtitle: Text(places[index].placeName ?? ''),
              onTap: () => this.close(
                  context,
                  SearchResult(
                    location: LatLng(places[index].center![1], places[index].center![0]),
                    placeName: places[index].placeName,
                    description: places[index].text,
                  )),
            );
          },
        );
      },
    );
  }
}
