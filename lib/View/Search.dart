import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/business/DatabaseManager.dart';
import 'package:weather_app/business/provider/WeatherProvider.dart';
import 'package:weather_app/Models/Locations.dart';
BuildContext globalContext;

class Search extends StatelessWidget {
  var primarySwatch = Colors.deepPurple;

  @override
  Widget build(BuildContext context) {
    globalContext = context;
    return MaterialApp(
      title: 'Weather',
      theme: ThemeData(
        primarySwatch: primarySwatch,
      ),
      home: SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  Icon _searchIcon = Icon(Icons.search, color: Colors.white);
  IconButton _iconClear;
  Widget _appBarTitle;
  TextEditingController _controller = TextEditingController();
  FocusNode _focusNode = FocusNode();
  Widget _body;

  WeatherProvider _weatherProvider = WeatherProvider();

  _onChange() {
    print(_controller.text);
  }

  _onFocusNode() {}

  @override
  void initState() {
    super.initState();

    _iconClear = IconButton(
        icon: Icon(Icons.clear, color: Colors.white.withOpacity(0.5)),
        onPressed: () {
          _controller.clear();
        });

    _appBarTitle = TextField(
        controller: _controller,
        focusNode: _focusNode,
        autofocus: true,
        onSubmitted: (_) {
          if (_.isNotEmpty) _search();
        },
        style: TextStyle(color: Colors.white, fontSize: 18),
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.white,
        cursorRadius: Radius.circular(16.0),
        maxLines: 1,
        decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: _searchIcon,
            suffixIcon: _iconClear,
            hintText: 'Search...',
            hintStyle:
                TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 18)));

    _controller.addListener(_onChange);
    _focusNode.addListener(_onFocusNode);

    _body = Center(
      child: Text(''),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: _appBarTitle,
      ),
      body: Container(
          color: Colors.blue[500],
          child: Center(
        child: _body,
      )),
    );
  }

  _listView(Locations locations) {
    return ListView.builder(
        itemCount: locations.result.length,
        itemBuilder: (context, index) {
          Location data = locations.result[index];
          return Card(
            color: Colors.brown,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.only(top: 5, left: 20, right: 20, bottom: 5),
            child: Material(
                elevation: 5,
                child: InkWell(
                  onTap: () async {
                    print('Clicked to ' + data.name);
                    await DatabaseManager().insertLocation(data);
                    print(await DatabaseManager().getIdLocation());
                    // Open new Activity
                    Navigator.pop(globalContext, 'Seted');
                  },
                  child: Container(
                    color: Colors.green[100],
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.name + " ," + data.country,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          );
        });
  }

  _search() async {
    setState(() {
      _body = Center(child: CircularProgressIndicator());
    });
    Locations locations = await _weatherProvider.search(_controller.text);

    setState(() {
      if (locations != null) _body = _listView(locations);
    });
  }
}
