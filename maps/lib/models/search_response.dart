class SearchResponse {
  SearchResponse({
    this.type,
    this.query,
    this.features,
    this.attribution,
  });

  final String? type;
  final List<String>? query;
  final List<Feature>? features;
  final String? attribution;

  factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        type: json["type"],
        query: json['query'] == null ? null : List<String>.from(json["query"].map((x) => x.toString())),
        features: json['features'] == null ? null : List<Feature>.from(json["features"].map((x) => Feature.fromJson(x))),
        attribution: json["attribution"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        if (query != null) "query": List<dynamic>.from(query!.map((x) => x)),
        if (features != null) "features": List<dynamic>.from(features!.map((x) => x.toJson())),
        "attribution": attribution,
      };
}

class Feature {
  Feature({
    this.id,
    this.type,
    this.placeType,
    this.relevance,
    this.properties,
    this.textEs,
    this.placeNameEs,
    this.text,
    this.placeName,
    this.center,
    this.geometry,
    this.context,
    this.languageEs,
    this.language,
    this.bbox,
  });

  final String? id;
  final String? type;
  final List<String>? placeType;
  final int? relevance;
  final Properties? properties;
  final String? textEs;
  final String? placeNameEs;
  final String? text;
  final String? placeName;
  final List<double>? center;
  final Geometry? geometry;
  final List<Context>? context;
  final String? languageEs;
  final String? language;
  final List<double>? bbox;

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        placeType: json['place_type'] == null ? null : List<String>.from(json["place_type"].map((x) => x)),
        properties: json['properties'] == null ? null : Properties.fromJson(json["properties"]),
        center: json['center'] == null ? null : List<double>.from(json["center"].map((x) => x.toDouble())),
        geometry: json['geometry'] == null ? null : Geometry.fromJson(json["geometry"]),
        context: json['context'] == null ? null : List<Context>.from(json["context"].map((x) => Context.fromJson(x))),
        id: json["id"],
        type: json["type"],
        relevance: json["relevance"],
        textEs: json["text_es"],
        placeNameEs: json["place_name_es"],
        text: json["text"],
        placeName: json["place_name"],
        languageEs: json["language_es"],
        language: json["language"],
        bbox: json['bbox'] == null ? null : List<double>.from(json["bbox"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        if (placeType != null) "place_type": List<dynamic>.from(placeType!.map((x) => x)),
        "relevance": relevance,
        "properties": properties?.toJson(),
        "text_es": textEs,
        "place_name_es": placeNameEs,
        "text": text,
        "place_name": placeName,
        if (center != null) "center": List<dynamic>.from(center!.map((x) => x)),
        "geometry": geometry?.toJson(),
        if (context != null) "context": List<dynamic>.from(context!.map((x) => x.toJson())),
        "language_es": languageEs,
        "language": language,
        if (bbox != null) "bbox": List<dynamic>.from(bbox!.map((x) => x)),
      };
}

class Context {
  Context({
    this.id,
    this.wikidata,
    this.textEs,
    this.languageEs,
    this.text,
    this.language,
    this.shortCode,
  });

  final String? id;
  final String? wikidata;
  final String? textEs;
  final String? languageEs;
  final String? text;
  final String? language;
  final String? shortCode;

  factory Context.fromJson(Map<String, dynamic> json) => Context(
        id: json["id"],
        wikidata: json["wikidata"],
        textEs: json["text_es"],
        languageEs: json["language_es"],
        text: json["text"],
        language: json["language"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "wikidata": wikidata,
        "text_es": textEs,
        "language_es": languageEs,
        "text": text,
        "language": language,
        "short_code": shortCode,
      };
}

class Geometry {
  Geometry({
    this.coordinates,
    this.type,
  });

  final List<double>? coordinates;
  final String? type;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
        "type": type,
      };
}

class Properties {
  Properties({
    this.foursquare,
    this.landmark,
    this.address,
    this.category,
    this.wikidata,
    this.shortCode,
  });

  final String? foursquare;
  final bool? landmark;
  final String? address;
  final String? category;
  final String? wikidata;
  final String? shortCode;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        foursquare: json["foursquare"],
        landmark: json["landmark"],
        address: json["address"],
        category: json["category"],
        wikidata: json["wikidata"],
        shortCode: json["short_code"],
      );

  Map<String, dynamic> toJson() => {
        "foursquare": foursquare,
        "landmark": landmark,
        "address": address,
        "category": category,
        "wikidata": wikidata,
        "short_code": shortCode,
      };
}
