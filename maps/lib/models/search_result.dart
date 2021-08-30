import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchResult {
  final bool cancelled;
  final bool manual;
  final LatLng? location;
  final String? placeName;
  final String? description;

  SearchResult({
    this.cancelled = false,
    this.manual = false,
    this.location,
    this.placeName,
    this.description,
  });
}
