import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'config/assets.dart';

class Shimmer_Chart extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Shimmer_ChartState();
  }
}

class _Shimmer_ChartState extends State<Shimmer_Chart> {
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

class _ShimmerLayout extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement createState
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 10,
                        color: Colors.grey[400],
                        margin: EdgeInsets.all(5),
                      ),
                      Container(
                        height: 40,
                        color: Colors.grey[400],
                        margin: EdgeInsets.all(5),
                        child:  new Image.asset(
                          Assets.loading,
                          fit:BoxFit.fill,
                          width: 30.0,
                          height: 30.0,
                        ),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey[400],
                        margin: EdgeInsets.all(5),
                      ),
                      Container(
                        height: 10,
                        color: Colors.grey[400],
                        margin: EdgeInsets.all(5),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 50,
                        color: Colors.grey[300],
                        margin: EdgeInsets.all(5),
                      ),
                      Container(
                        height: 5,
                        width: 60,
                        color: Colors.grey[300],
                        margin: EdgeInsets.all(2),
                      ),
                      Container(
                        height: 5,
                        width: 60,
                        color: Colors.grey[300],
                        margin: EdgeInsets.all(2),
                      ),
                    ],
                  ),
                )
              ],
            ),

            Container(
              height: 5,
              margin: EdgeInsets.only(left: 5, right: 5, top: 20),
              color: Colors.grey[400],
            )
          ],
        ));
  }

}
