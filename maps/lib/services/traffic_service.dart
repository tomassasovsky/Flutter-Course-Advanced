import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps/models/driving_response.dart';

class TrafficService {
  // SINGLETON:
  TrafficService._();
  static final TrafficService _instance = TrafficService._();
  factory TrafficService() => _instance;

  final _dio = Dio();
  final _baseUrl = 'https://api.mapbox.com/directions/v5';
  final _accessToken = 'pk.eyJ1IjoidG9tYXNzYXNvdnNreSIsImEiOiJja3N1cGh6Y2MxMTg4Mm9xemphdjJrajdiIn0.kwRl1a8HHpOXfMi617taJA';

  Future<DrivingResponse> getCoordinates(LatLng start, LatLng finish) async {
    final coordinates = '${start.longitude},${start.latitude};${finish.longitude},${finish.latitude}';
    final url = '$_baseUrl/mapbox/driving/$coordinates';

    final response = await _dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': _accessToken,
    });

    final data = DrivingResponse.fromJson(response.data);
    return data;
  }
}
