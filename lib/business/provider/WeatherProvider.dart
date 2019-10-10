import 'dart:convert';

import 'package:weather_app/business/DatabaseManager.dart';
import 'package:weather_app/Models/ForecastDaily.dart';
import 'package:weather_app/Models/Locations.dart';
import 'package:weather_app/Models/WeatherCurrent.dart';
import 'package:http/http.dart' as http;

import '../Api.dart';

class WeatherProvider {
  Future<WeatherCurrent> current() async {
    var client = http.Client();

    String location_id_seted = await DatabaseManager().getIdLocation();
    if (location_id_seted != null && location_id_seted.isNotEmpty) {
      var get = await client.get(Api.current(location_id_seted));
      client.close();
      if (get.statusCode == 200)
        return WeatherCurrent.fromJson(json.decode(get.body));
      else
        return null;
    } else
        return null;
  }

  Future<WeatherCurrent> currentByGPS(lat, lon) async {
    var client = http.Client();

    var get = await client.get(Api.currentByGPS(lat, lon));
    client.close();
    if (get.statusCode == 200)
      return WeatherCurrent.fromJson(json.decode(get.body));
    else
      return null;
  }

  Future<ForecastDaily> forceDaily() async {
    var client = http.Client();

    String location_id_seted = await DatabaseManager().getIdLocation();
    if (location_id_seted != null && location_id_seted.isNotEmpty) {
      var get = await client.get(Api.forecast(location_id_seted));
      client.close();
      if (get.statusCode == 200)
        return ForecastDaily.fromJson(json.decode(get.body));
      else
        return null;
    } else
        return null;
  }

  Future<Locations> search(key_word) async {
    var client = http.Client();
    final get = await client.get(Api.searchLocation(key_word));
    client.close();
    if (get.statusCode == 200)
      return Locations.fromJson(json.decode(get.body));
    else
      return null;
  }
}
