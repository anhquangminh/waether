class Coord {
  var lon, lat;

  Coord({this.lon, this.lat});

  factory Coord.fromJson(Map<String, dynamic> json) {
    return Coord(
      lon: json['lon'],
      lat: json['lat']
    );
  }
}

class Location {
  var id;
  final String name, country;
  final Coord coord;

  Location({this.id, this.name, this.country, this.coord});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      country: json['country'],
      coord: Coord.fromJson(json['coord'])
    );
  }
}

class Locations {
  var code;
  var key_word;
  final List<Location> result;

  Locations({this.code, this.key_word, this.result});

  factory Locations.fromJson(Map<String, dynamic> json) {
    return Locations(
        code: json['code'],
        key_word: json['key_word'],
        result: (json['result'] as List).map((value) => Location.fromJson(value)).toList()
    );
  }
}