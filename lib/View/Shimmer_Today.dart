import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'config/assets.dart';

class Shimmer_Today extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Shimmer_TodayState();
  }
}

class _Shimmer_TodayState extends State<Shimmer_Today> {
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
      padding: EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                color: Colors.grey[400],
                width: 50,
                height: 80,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                color: Colors.grey[400],
                width: 50,
                height: 80,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                color: Colors.grey[400],
                width: 50,
                height: 80,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                color: Colors.grey[400],
                width: 50,
                height: 80,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                color: Colors.grey[400],
                width: 50,
                height: 80,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
