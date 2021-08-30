import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/helpers/helpers.dart';
import 'package:maps/models/driving_response.dart';
import 'package:maps/models/search_response.dart';

class TrafficService {
  // SINGLETON:
  TrafficService._();
  static final TrafficService _instance = TrafficService._();
  factory TrafficService() => _instance;

  final _dio = Dio();
  final debouncer = Debouncer(duration: Duration(milliseconds: 200));

  final StreamController<SearchResponse> _searchResponseSuggestions = StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get suggestionsStream => _searchResponseSuggestions.stream;

  final _baseUrlDir = 'https://api.mapbox.com/directions/v5';
  final _baseUrlGeo = 'https://api.mapbox.com/geocoding/v5';
  final _accessToken = 'pk.eyJ1IjoidG9tYXNzYXNvdnNreSIsImEiOiJja3N1cGh6Y2MxMTg4Mm9xemphdjJrajdiIn0.kwRl1a8HHpOXfMi617taJA';

  Future<DrivingResponse> getCoordinates(LatLng start, LatLng finish) async {
    final coordinates = '${start.longitude},${start.latitude};${finish.longitude},${finish.latitude}';
    final url = '$_baseUrlDir/mapbox/driving/$coordinates';

    final response = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _accessToken,
    });

    final data = DrivingResponse.fromJson(response.data);
    return data;
  }

  Future<SearchResponse> getSearchResults(String query, LatLng proximity) async {
    if (query.isEmpty) return SearchResponse();

    try {
      final proximityCoordinates = '${proximity.longitude},${proximity.latitude}';
      final url = '$_baseUrlGeo/mapbox.places/$query.json';

      final response = await _dio.get(url, queryParameters: {
        'access_token': _accessToken,
        'autocomplete': 'true',
        'proximity': proximityCoordinates,
      });

      final data = SearchResponse.fromJson(json.decode(response.data));
      return data;
    } catch (error) {
      return SearchResponse();
    }
  }

  void getSearchSuggestions(String query, LatLng proximity) {
    debouncer.value = '';

    debouncer.onValue = (value) async {
      final results = await this.getSearchResults(value, proximity);
      this._searchResponseSuggestions.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) => debouncer.value = query);

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel());
  }

  void dispose() {
    _searchResponseSuggestions.close();
  }
}
