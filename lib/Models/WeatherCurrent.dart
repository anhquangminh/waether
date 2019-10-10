class _Weather {
  var id, main, description, icon;

  _Weather({this.id, this.main, this.description, this.icon});

  factory _Weather.fromJson(Map<String, dynamic> json) {
    return _Weather(id: json['id'], main: json['main'], description: json['description'], icon: json['icon']);
  }
}

class _Main {
  var temp, pressure, humidity, temp_min, temp_max;

  _Main({this.temp, this.pressure, this.humidity, this.temp_min, this.temp_max});

  factory _Main.fromJson(Map<String, dynamic> json) {
    return _Main(
        temp: json['temp'],
        pressure: json['pressure'],
        humidity: json['humidity'],
        temp_min: json['temp_min'],
        temp_max: json['temp_max']);
  }
}

class _Sys{
  var type, id, message, country, sunrise, sunset;

  _Sys({this.type, this.id, this.message, this.country, this.sunrise, this.sunset});

  factory _Sys.fromJson(Map<String, dynamic> json) {
    return _Sys(
      type: json['type'],
      id: json['id'],
      message: json['message'],
      country: json['country'],
      sunrise: json['sunrise'],
      sunset: json['sunset']
    );
  }
}

class WeatherCurrent {
  int id;
  List<_Weather> weather;
  _Main main;
  _Sys sys;
  var name;

  WeatherCurrent({this.id, this.weather, this.main, this.sys, this.name});

  factory WeatherCurrent.fromJson(Map<String, dynamic> json) {
    return WeatherCurrent(
      id: json['id'],
      weather: (json['weather'] as List).map((value) => _Weather.fromJson(value)).toList(),
      main: _Main.fromJson(json['main']),
      sys: _Sys.fromJson(json['sys']),
      name: json['name']
    );
  } 
}
