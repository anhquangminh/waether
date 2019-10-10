import 'package:flutter/material.dart';
import 'package:weather_app/business/provider/WeatherProvider.dart';
import 'package:weather_app/Models/ForecastDaily.dart';
import 'package:weather_app/View/Shimmer_Week.dart';
import 'package:weather_app/View/config/assets.dart';

import 'RenderHtmlCharacter.dart';

class Week extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyWeekState();
  }
}

// AutomaticKeepAliveClientMixin: keep state after switch tab
class _MyWeekState extends State<Week> with AutomaticKeepAliveClientMixin {
  WeatherProvider _weatherProvider = WeatherProvider();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: EdgeInsets.all(5),
        color: Colors.deepPurple,
        child: FutureBuilder<ForecastDaily>(
          future: _weatherProvider.forceDaily(),
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              if (snapshot.hasData) {
                ForecastDaily forecastDaily = snapshot.data;
                return _mainUI(forecastDaily);
              }
            }
            return Shimmer_Week();
          },
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  String compareIcons(String input) {
    String result = Assets.iconCloudLittleRain;
    switch (input) {
      case 'clear':
        {
          result = Assets.iconDust;
          break;
        }
      case 'clear sky':
        {
          result = Assets.iconSun;
          break;
        }
      case 'Clouds':
        {
          result = Assets.iconCloud;
          break;
        }
    }

    return result;
  }

  _mainUI(ForecastDaily forecastDaily) {
    return Container(
        child: ListView.builder(
      itemCount: forecastDaily.list.length,
      itemBuilder: (context, index) {
        String date = forecastDaily.list[index].dt_txt;
        date = date.substring(date.indexOf('-') + 1, date.length);
        date = date.substring(0, date.lastIndexOf(':'));

        String date_time =
            date.substring(0, date.indexOf(' ')).replaceAll('-', '/');
        String time = date.substring(date.indexOf(' ') + 1, date.length);
        String month = date_time.substring(0, date_time.indexOf('/'));
        String day =
            date_time.substring(date_time.indexOf('/') + 1, date_time.length);
        date_time = '$day/$month';

        return Card(
          margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          color: Colors.lightBlue[50],
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(top: 0, left: 30, bottom: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(
                          'http://openweathermap.org/img/w/' +
                              forecastDaily.list[index].weather[0].icon +
                              '.png',
                          width: 52,
                          fit: BoxFit.cover,
                        ),
// So sanh clear de lay anh
//                      Image.asset(
//                        compareIcons(forecastDaily.list[index].weather[0].main),
//                        fit: BoxFit.fill,
//                        width: 50.0,
//                        height: 50.0,
//                        color: Colors.orange.withOpacity(0.8),
//                      ),
                        // Clear, sunny, rain...
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(forecastDaily.list[index].weather[0].main,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                            '(' +
                                forecastDaily
                                    .list[index].weather[0].description +
                                ')',
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 5),
                        child: Text(
                          date_time,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.timer,color:Colors.deepPurple,size: 16,),
                          Text(
                            time +
                                ' , ' +
                                forecastDaily.list[index].main.temp.toString() +
                                ' ' +
                                htmlDecode('&#176;') +
                                'C',
                            style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 0),
                        child: Text(
                          htmlDecode('&uarr; ') +
                              forecastDaily.list[index].main.temp_min
                                  .toString() +
                              ' - ' +
                              htmlDecode('&darr; ') +
                              forecastDaily.list[index].main.temp_max
                                  .toString() +
                              htmlDecode('&#176;') +
                              'C',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Text(
                        'Humidity ' +
                            forecastDaily.list[index].main.humidity.toString() +
                            '%',
                        style: TextStyle(
                            color: Colors.deepPurple,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ));
  }
}
