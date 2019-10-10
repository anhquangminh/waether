import 'package:flutter/material.dart';
class WidgetHelper {

  static LinearGradient buildGradient(Color startColor, Color endColor) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.2, 0.99],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        startColor,
        endColor,
      ],
    );
  }
}