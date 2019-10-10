import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:weather_app/business/DatabaseManager.dart';
import 'package:weather_app/business/provider/DatabaseProvider.dart';
import 'package:weather_app/business/provider/WeatherProvider.dart';
import 'package:weather_app/Models/Locations.dart' as LocationModel;
import 'package:weather_app/Models/WeatherCurrent.dart';
import 'Search.dart';
import 'Today.dart';
import 'Week.dart';
import 'package:flutter/services.dart';

var primarySwatch = Colors.deepPurple;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: HomePage(title: ''),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _appBarTitle;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  WeatherCurrent _weatherCurrent = null;
  var _location = new Location();
  LocationData _currentLocation;
  WeatherProvider _weatherProvider = WeatherProvider();
  DatabaseManager _databaseManager = DatabaseManager();
  Duration _duration = Duration(seconds: 1);
  Timer _timer;

  var _iconGPS;
  bool _iconGPSstate = true;

  var _tab = <Widget>[
    Today(),
    Week(),
  ];

  _onChange() {}

  _onFocusNode() {}

  @override
  void initState() {
    super.initState();

    _appBarTitle = TextField(
        controller: _controller,
        focusNode: _focusNode,
        onTap: () async {
          _controller.clear();
          _focusNode.unfocus();

          // Open new Screen
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          );

          if (result != null && result == "Seted") {
            setState(() {
              _tab = <Widget>[
                Today(),
                Week(),
              ];
            });
          }
        },
        style: TextStyle(color: Colors.white, fontSize: 18),
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.white,
        cursorRadius: Radius.circular(16.0),
        maxLines: 1,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            hintText: 'Search...',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18)));

    _controller.addListener(_onChange);
    _focusNode.addListener(_onFocusNode);
    _iconGPS = Icon(Icons.my_location, color: Colors.white);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    // This also removes the _printLatestValue listener
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  _nestedScrollViewController() {}

  _tabBarController() {}

  // onBackPress
  Future<bool> _onWillPopScope() {
    return Future(() => true);
  }

  Future<void> _getLocation() async {
    await _location.requestPermission();
    if (await _location.hasPermission()) {
      if (_timer != null && _timer.isActive) _timer.cancel();

      _timer = Timer.periodic(_duration, (_) {
        if (_iconGPSstate) {
          setState(() {
            _iconGPS = Icon(Icons.my_location, color: Colors.yellow);
          });
        } else {
          setState(() {
            _iconGPS = Icon(Icons.my_location, color: Colors.white);
          });
        }
        _iconGPSstate = !_iconGPSstate;
      });

      _currentLocation = await _location.getLocation();
    } else
      _currentLocation = null;

    if (_currentLocation != null) {
      var lat = _currentLocation.latitude.toString();
      var lon = _currentLocation.longitude.toString();

      var currentByGPS = await _weatherProvider.currentByGPS(lat, lon);

      var id = currentByGPS.id;
      var name = currentByGPS.name;
      var country = currentByGPS.sys.country;

      var json = {
        "id": id,
        "name": name,
        "country": country,
        "coord": {"lon": lon, "lat": lat}
      };

      print(json);

      LocationModel.Location location = LocationModel.Location.fromJson(json);
      await _databaseManager.insertLocation(location);

      setState(() {
        _tab = <Widget>[
          Today(),
          Week(),
        ];
      });
      
      setState(() {
        _iconGPS = Icon(Icons.my_location, color: Colors.white);
        _timer.cancel();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Create Database
    DatabaseProvider().create().then((_)async{
      if(await _location.hasPermission() == false) {
        _getLocation();
      }
    });

    return WillPopScope(
      onWillPop: _onWillPopScope,
      child: DefaultTabController(
        length: _tab.length,
        child: NestedScrollView(
            controller: _nestedScrollViewController(),
            physics: NeverScrollableScrollPhysics(),
            headerSliverBuilder: (BuildContext context, bool isScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.blue[800],
                  title: _appBarTitle,
                  actions: <Widget>[
                    Builder(
                        builder: (context) => IconButton(
                            icon: IconButton(
                                icon: _iconGPS,
                                onPressed: () async {
                                  await _getLocation();
                                })))
                  ],
                  pinned: true,
                  floating: true,
                  forceElevated: isScrolled,
                  bottom: TabBar(
                    unselectedLabelColor: Colors.white70,
                    indicatorColor: Colors.orange,
                    tabs: <Widget>[Tab(text: 'TODAY'), Tab(text: 'WEEK')],
                    controller: _tabBarController(),
                  ),
                )
              ];
            },
            body: GestureDetector(
              onTap: () {},
              child: Scaffold(
                body: TabBarView(
                  children: _tab,
                ),
              ),
            )),
      ),
    );
  }
}
