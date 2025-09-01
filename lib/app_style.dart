import 'package:flutter/material.dart';

// Diese Klasse enthält Konstante für das visuelle Styling

class AppStyle {
  // Standard Button Text
  static const TextStyle baseTextStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );

  // Ausgewählter Button Text
  static const TextStyle pressedTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
  );

  // Hintergrund Gradienteneffekt
  static final BoxDecoration backgroundGradient = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [Colors.white, Colors.lightBlue.shade100],
    ),
  );
}
