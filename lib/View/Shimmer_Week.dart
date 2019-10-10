import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'config/assets.dart';

class Shimmer_Week extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Shimmer_WeekState();
  }
}

class _Shimmer_WeekState extends State<Shimmer_Week> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Shimmer.fromColors(
      highlightColor: Colors.white,
      baseColor: Colors.grey[400],
      child: _ShimmerLayout(),
    );
  }
}

class _ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      //padding: EdgeInsets.only(left: 10, right: 10, top: 20),
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 50,
            width: 350,
            color: Colors.grey[400],
            margin: EdgeInsets.all(10),
          ),
          Container(
            height: 50,
            width: 350,
            color: Colors.grey[400],
            margin: EdgeInsets.all(10),
          ),
          Container(
            height: 50,
            width: 350,
            color: Colors.grey[400],
            margin: EdgeInsets.all(10),
          ),
          Container(
            height: 50,
            width: 350,
            color: Colors.grey[400],
            margin: EdgeInsets.all(10),
          ),
          Container(
            height: 50,
            width: 350,
            color: Colors.grey[400],
            margin: EdgeInsets.all(10),
          ),
          Container(
            height: 50,
            width: 350,
            color: Colors.grey[400],
            margin: EdgeInsets.all(10),
          )
        ],
      ),

    );
  }
}
