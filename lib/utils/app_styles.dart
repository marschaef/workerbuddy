import 'package:flutter/material.dart';

class AppStyles {
  // Farben
  static const Color primaryColor = Color(
    0xFF45BDF9,
  );
  static const Color accentColor = Color(
    0xFF272932,
  );
  static const Color backgroundColor = Color(
    0xFFF5F5F5,
  );
  static const Color textColor = Color(
    0xFF333333,
  );

  // Text-Stile
  static const TextStyle headLine1 = TextStyle(
    fontFamily: "Roboto",
    fontSize: 24.0,
    color: textColor,
    fontVariations: <FontVariation>[
      FontVariation("wght", 700.0),
    ],
  );

  static const TextStyle bodyText = TextStyle(
    fontFamily: "Roboto",
    fontSize: 16.0,
    color: textColor,
    fontVariations: <FontVariation>[
      FontVariation("wght", 400.0),
    ],
  );

  static const TextStyle buttonText = TextStyle(
    fontFamily: "Roboto",
    fontSize: 18.0,
    color: Colors.white,
    fontVariations: <FontVariation>[
      FontVariation("wght", 700.0),
    ],
  );

  // Abstände
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Border Radius
  static const double borderRadius = 12.0;
}
