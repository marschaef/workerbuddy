import 'package:flutter/material.dart';

class AppStyle {
  static const TextStyle baseTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle pressedTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  static final BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Colors.lightBlue.shade100],
    ),
  );
}
