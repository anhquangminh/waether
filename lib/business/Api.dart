class Api {
  static String key = 'b80c043c37f60763eb9d74989bca7554';
  static String unit = 'metric';

  static String current(String id) {
    return 'http://api.openweathermap.org/data/2.5/weather?id=$id&units='+unit+'&appid=$key';
  }

  static String currentByGPS(lat, lon) {
    return 'http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$key';
  }

  static String forecast(id) {
    return 'http://api.openweathermap.org/data/2.5/forecast?id=$id&units=$unit&appid=$key';
  }

  static String searchLocation(key_word) {
    return 'https://location-query.herokuapp.com/location?key_word=$key_word';
  }
}