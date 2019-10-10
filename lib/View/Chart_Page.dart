import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:weather_app/Models/WeatherCurrent.dart';
import 'package:weather_app/business/provider/WeatherProvider.dart';
import 'package:weather_app/view/Home.dart';
import 'Shimmer_Chart.dart';
import 'RenderHtmlCharacter.dart';
import 'config/assets.dart';
import 'config/applicationColor.dart';
import 'config/gradient.dart';
import 'package:weather_app/Models/Chart_data.dart';
import 'package:weather_app/Models/ForecastDaily.dart';

class Chart_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new Chart_PageState(),
    );
  }
}

class Chart_PageState extends StatefulWidget {
  Chart_PageState({Key key}) : super(key: key);

  @override
  _Chart_PageState createState() => new _Chart_PageState();
}

class _Chart_PageState extends State<Chart_PageState> {
  WeatherProvider _weatherProvider = WeatherProvider();
  ForecastDaily forecastDaily;

  // add chart
  final List<charts.Series> seriesList = List();

  /// Creates a [LineChart] with sample data and no transition.

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
    return new Scaffold(
//      backgroundColor: ApplicationColors.middayEndColor,
        appBar: new AppBar(
          automaticallyImplyLeading: true,
          backgroundColor: ApplicationColors.middayStartColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }),
          title: Padding(
            padding: EdgeInsets.only(left: 30.0),
            child: new Text('Chart Temperature'),
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              gradient: WidgetHelper.buildGradient(
                  ApplicationColors.middayStartColor,
                  ApplicationColors.middayEndColor)),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Container(
                height: 400,
                width: double.infinity,
                child: FutureBuilder<WeatherCurrent>(
                    future: _weatherProvider.current(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasError) {
                        if (snapshot.hasData) {
                          WeatherCurrent weatherCurrent = snapshot.data;
                          return new Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(top: 40),
                                  child: new Text(
                                    weatherCurrent.name,
                                    style: new TextStyle(
                                        fontSize: 35.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Arial"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10, bottom: 10),
                                  child: new Text(
                                    datenow,
                                    style: new TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Arial"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: new Image.asset(
                                    Assets.iconThermometer,
                                    fit: BoxFit.fill,
                                    width: 120.0,
                                    height: 120.0,
                                    color: Colors.white,
                                  ),
                                ),
                                new Text(
                                  "Temperature",
                                  style: new TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Arial"),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 20, bottom: 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: 4, right: 2),
                                        child: Text(
                                          "min",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Text(
                                        weatherCurrent.main.temp_min
                                                .toString() +
                                            htmlDecode('&#176;') +
                                            'C',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 4, right: 2, left: 10),
                                        child: Text(
                                          "max",
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      Text(
                                        weatherCurrent.main.temp_max
                                                .toString() +
                                            htmlDecode('&#176;') +
                                            'C',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                        } else
                          print('No current weather data');
                      } else
                        print(snapshot.error);
                      return Shimmer_Chart();
                    }),
              ),
              Container(
                height: 20,
                width: double.infinity,
                margin: EdgeInsets.only(left: 50),
                child: Text(
                  htmlDecode('&#176;') + 'C',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
              Container(
                  height: 200,
                  width: 300,
                  color: Colors.lightBlue[400],
                  child: FutureBuilder(
                    future: _weatherProvider.forceDaily(),
                    builder: (context, snapshot) {
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

                      String datenow = '$yearNow-$monthNow-$dayNow';
                      int time_min;
                      if (!snapshot.hasError) {
                        if (snapshot.hasData) {
                          ForecastDaily forecastDaily = snapshot.data;
                          List<LinearChart> data = List();
                          for (int i = 0; i < forecastDaily.list.length; i++) {
                            String date = forecastDaily.list[i].dt_txt;
                            String time = date.substring(
                                date.indexOf(' ') + 1, date.length);
                            int timer =
                                int.parse(time.substring(0, time.indexOf(':')));

                            //get date_min
                            String date_min = forecastDaily.list[0].dt_txt;
                            String time_1 = date_min.substring(
                                date_min.indexOf(' ') + 1, date_min.length);
                            time_min = int.parse(
                                time_1.substring(0, time_1.indexOf(':')));

                            if (date.substring(0, date.indexOf(' ')) ==
                                datenow) {
                              print(timer);
//                              print("Nhiet do :"+double.parse((value.main.temp.toString())).toStringAsFixed(0));
                              data.add(LinearChart(
                                  timer,
                                  int.parse(double.parse((forecastDaily
                                          .list[i].main.temp
                                          .toString()))
                                      .toStringAsFixed(0))));
                            }
                          }
                          return charts.LineChart(
                            _createSampleData(data),
                            domainAxis: new charts.NumericAxisSpec(
                              viewport: new charts.NumericExtents(time_min, 21),
                            ),
                            behaviors: [new charts.PanAndZoomBehavior()],
                          );
                        }
                      }
                      return charts.LineChart(_createSampleData(null)
                          // Sets up a currency formatter for the measure axis.
                          );
                    },
                  )),
              Container(
                height: 20,
                width: double.infinity,
                margin: EdgeInsets.only(left: 350,top: 0),
                child: Text(
                  'h',
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.white),
                ),
              ),
            ],
          ),
        ));
  }

  _createSampleData(List<LinearChart> data) {
    if (data == null) {
      data = List();
      data.add(LinearChart(0, 0));
      data.add(LinearChart(1, 0));
    }

    return [
      new charts.Series<LinearChart, int>(
        id: 'Chart',
        colorFn: (_, __) => charts.MaterialPalette.white,
        domainFn: (LinearChart sales, _) => sales.temperature,
        measureFn: (LinearChart sales, _) => sales.time,
        data: data,
      )
    ];
  }
}
