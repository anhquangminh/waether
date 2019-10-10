import 'package:flutter/material.dart';
import 'package:weather_app/business/provider/WeatherProvider.dart';
import 'package:weather_app/Models/ForecastDaily.dart';
import 'package:weather_app/Models/WeatherCurrent.dart';
import 'Shimmer_Today.dart';
import 'RenderHtmlCharacter.dart';
import 'config/assets.dart';
import 'config/applicationColor.dart';
import 'config/gradient.dart';
import 'Chart_Page.dart';

class Today extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyTodayState();
  }
}

// AutomaticKeepAliveClientMixin: keep state after switch tab
class _MyTodayState extends State<Today> with AutomaticKeepAliveClientMixin {
  WeatherProvider _weatherProvider = WeatherProvider();

  String compareIcons(String input) {
    String result = Assets.iconCloudLittleRain;
    switch (input) {
      case 'Clear':
        {
          result = Assets.iconCloudSun;
          break;
        }
      case 'Clear sky':
        {
          result = Assets.iconSun;
          break;
        }
      case 'Clouds':
        {
          result = Assets.iconCloud;
          break;
        }
      case 'Rain':
        {
          result = Assets.iconRain;
          break;
        }
      case 'Thunder':
        {
          result = Assets.iconThunder;
          break;
        }
      case 'Mist':
        {
          result = Assets.iconDust;
          break;
        }
      case 'Haze':
        {
          result = Assets.iconSnow;
          break;
        }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    var _date = DateTime.now();
    String dayNow = '';
    String monthNow = '';
    String yearNow = '';
    _date.day < 10
        ? dayNow = '0' + _date.day.toString()
        : dayNow = _date.day.toString();
    _date.month < 10
        ? monthNow = '0' + _date.month.toString()
        : monthNow = _date.month.toString();
    _date.year < 10
        ? yearNow = '0' + _date.year.toString()
        : yearNow = _date.year.toString();

    String datenow = '$dayNow/$monthNow/$yearNow';
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          gradient: WidgetHelper.buildGradient(ApplicationColors.dayStartColor,
              ApplicationColors.middayEndColor)),
      child: Container(
          margin: EdgeInsets.all(0) /* margin */,
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Container(
                child: FutureBuilder<WeatherCurrent>(
                    future: _weatherProvider.current(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasError) {
                        if (snapshot.hasData) {
                          WeatherCurrent weatherCurrent = snapshot.data;
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(
                                    bottom: 5, left: 0, top: 10),
                                child: Text(
                                  weatherCurrent.name,
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Roboto",
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10, left: 0),
                                child: Text(
                                  datenow,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10, left: 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.only(bottom: 15, top: 15),
                                      child: new Image.asset(
                                        compareIcons(weatherCurrent
                                            .weather[0].main
                                            .toString()),
                                        color: Colors.yellow[600],
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Container(
                                        margin:
                                            EdgeInsets.only(top: 10, left: 0),
                                        child: Text(
                                          weatherCurrent.weather[0].main
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                    Container(
                                        child: Text(
                                      '(' +
                                          weatherCurrent.weather[0].description
                                              .toString() +
                                          ')',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ))
                                  ],
                                ),
                              ),
                              Container(
                                  child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  FlatButton(
                                    onPressed: pushChart,
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          weatherCurrent.main.temp.toString(),
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          htmlDecode('&#176;') + 'C ',
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                              Container(
                                  child: Text(
                                htmlDecode('&uarr; ') +
                                    weatherCurrent.main.temp_min.toString() +
                                    ' - ' +
                                    htmlDecode('&darr; ') +
                                    weatherCurrent.main.temp_max.toString() +
                                    htmlDecode('&#176;') +
                                    'C',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                              Container(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  'Feels like ' +
                                      weatherCurrent.main.temp.toString() +
                                      ' ' +
                                      htmlDecode('&#176;') +
                                      'C and Humidity ' +
                                      weatherCurrent.main.humidity.toString() +
                                      '%',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic),
                                ),
                              ),
                            ],
                          );
                        } else
                          print('No current weather data');
                      } else
                        print(snapshot.error);
                      return Container(
                        margin: EdgeInsets.only(top: 50),
                        width: 300,
                        height: 200,
                        child: Image.asset(Assets.loading,width: 100,height: 80,color: Colors.white,),
                      );
                    }),
              ),
              Container(
                height: 120,
                margin: EdgeInsets.only(top: 20),
                child: FutureBuilder<ForecastDaily>(
                  future: _weatherProvider.forceDaily(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasError) {
                      if (snapshot.hasData) {
                        ForecastDaily forecastDaily = snapshot.data;
                        // filter date
                        int index = 0;
                        for (int _index = 0;
                            _index < forecastDaily.list.length;
                            _index++) {
                          String date = forecastDaily.list[_index].dt_txt;
                          date = date.substring(
                              date.indexOf('-') + 1, date.length);
                          date = date.substring(0, date.lastIndexOf(':'));

                          String date_time = date
                              .substring(0, date.indexOf(' '))
                              .replaceAll('-', '/');
                          String time = date.substring(
                              date.indexOf(' ') + 1, date.length);

                          String month =
                              date_time.substring(0, date_time.indexOf('/'));
                          String day = date_time.substring(
                              date_time.indexOf('/') + 1, date_time.length);
                          date_time = '$day/$month';

                          var _date = DateTime.now();
                          String dayNow = '';
                          String monthNow = '';
                          _date.day < 10
                              ? dayNow = '0' + _date.day.toString()
                              : dayNow = _date.day.toString();
                          _date.month < 10
                              ? monthNow = '0' + _date.month.toString()
                              : monthNow = _date.month.toString();

                          String date_time_now = '$dayNow/$monthNow';
                          if (date_time_now == date_time)
                            index++;
                          else
                            break;
                        }
                        return Container(
                            color: Colors.lightBlue[650],
                            margin: EdgeInsets.only(top: 0),
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: index == 0 ? 0 : index,
                                itemBuilder:
                                    (BuildContext _context, int _index) {
                                  String date =
                                      forecastDaily.list[_index].dt_txt;
                                  date = date.substring(
                                      date.indexOf('-') + 1, date.length);
                                  date =
                                      date.substring(0, date.lastIndexOf(':'));

                                  String date_time = date
                                      .substring(0, date.indexOf(' '))
                                      .replaceAll('-', '/');
                                  String time = date.substring(
                                      date.indexOf(' ') + 1, date.length);

                                  String month = date_time.substring(
                                      0, date_time.indexOf('/'));
                                  String day = date_time.substring(
                                      date_time.indexOf('/') + 1,
                                      date_time.length);
                                  date_time = '$day/$month';

                                  return Card(
                                    color: Colors.green[300],
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        width: 90,
                                        height: 120,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              child: Text(
                                                time,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  bottom: 2, top: 2),
                                              child: Text(
                                                '(' + date_time + ')',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 0),
                                              child: Image.network(
                                                'http://openweathermap.org/img/w/' +
                                                    forecastDaily.list[_index]
                                                        .weather[0].icon +
                                                    '.png',
                                                width: 40,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 5, top: 0),
                                              child: Text(
                                                forecastDaily
                                                        .list[_index].main.temp
                                                        .toString() +
                                                    htmlDecode('&#176;') +
                                                    'C',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            )
                                          ],
                                        )),
                                  );
                                }));
                      } else {
                        print('No forecast data ');
                      }
                    } else {
                      print(snapshot.error);
                    }
                    return Shimmer_Today();
                  },
                ),
              ),
            ],
          )),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void pushChart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Chart_Page()),
    );
  }
}
