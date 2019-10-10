class _Weather {
  var id, main, description, icon;

  _Weather({this.id, this.main, this.description, this.icon});

  factory _Weather.fromJson(Map<String, dynamic> json) {
    return _Weather(
        id: json['id'],
        main: json['main'],
        description: json['description'],
        icon: json['icon']);
  }
}

class _Main {
  var temp, pressure, humidity, temp_min, temp_max;

  _Main(
      {this.temp, this.pressure, this.humidity, this.temp_min, this.temp_max});

  factory _Main.fromJson(Map<String, dynamic> json) {
    return _Main(
        temp: json['temp'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        temp_min: json['temp_min'],
        temp_max: json['temp_max']);
  }
}

class _City {
  var id, name, country;

  _City({this.id, this.name, this.country});

  factory _City.fromJson(Map<String, dynamic> json) {
    return _City(id: json['id'], name: json['name'], country: json['country']);
  }
}

class _Item {
  _Main main;
  List<_Weather> weather;
  var dt_txt;

  _Item({this.main, this.weather, this.dt_txt});

  factory _Item.fromJson(Map<String, dynamic> json) {
    return _Item(
        main: _Main.fromJson(json['main']),
        weather: (json['weather'] as List)
            .map((value) => _Weather.fromJson(value))
            .toList(),
        dt_txt: json['dt_txt']);
  }
}

class ForecastDaily {
  List<_Item> list;
  _City city;

  ForecastDaily({this.list, this.city});

  factory ForecastDaily.fromJson(Map<String, dynamic> json) {
    return ForecastDaily(
        list: (json['list'] as List)
            .map((value) => _Item.fromJson(value))
            .toList(),
        city: _City.fromJson(json['city']));
  }
}
