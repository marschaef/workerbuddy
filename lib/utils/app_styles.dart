import 'package:flutter/material.dart';

// ##################################################################
// #                  ZENTRALE DESIGN-STEUERUNG                     #
// ##################################################################
// In dieser Datei wird das komplette Look-and-Feel der App definiert.
// Änderungen hier wirken sich auf die gesamte App aus.

class AppTheme {
  // privater konstruktor, damit man die klasse nicht aus versehen erstellt
  AppTheme._();

  // --- 1. GRUNDFARBEN ---

  static const _primaryColor = Color(0xFF45BDF9);

  // --- 2. ABSTÄNDE & FORMEN ---
  // Globale Werte für Layout und Design.

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double borderRadius =
      12.0; // Globaler Eck-Radius.

  // --- 3. EFFEKTE (Schatten & Verläufe) ---
  // Dynamische Effekte für Light/Dark-Mode.
  static List<BoxShadow> getCardShadow(
    Brightness brightness,
  ) {
    // Passender Schatten für den aktuellen Modus.
    final shadowColor =
        brightness == Brightness.light
        ? Colors.black.withAlpha(25)
        : Colors.white.withAlpha(30);

    return [
      BoxShadow(
        color: shadowColor,
        spreadRadius: 1,
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }

  // Hintergrundverlauf, der die Theme-Farben nutzt.
  static BoxDecoration getBackgroundGradient(
    ColorScheme colorScheme,
  ) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          colorScheme.surface,
          colorScheme.primary.withAlpha(40),
        ],
      ),
    );
  }

  // --- 4. SPEZIAL-STILE ---
  static const TextStyle navigationText =
      TextStyle(fontWeight: FontWeight.bold);

  // --- 5. BASIS-TEXT-THEME ---
  // Globale Textstile, die für beide Themes gelten.
  static const TextTheme _textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w700,
    ),
    headlineMedium: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    ),
  );

  // ##################################################################
  // #                      DAS HELLE THEME (Light)                   #
  // ##################################################################
  static ThemeData get lightTheme {
    // Farbschema aus der Markenfarbe generieren.
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
      primary:
          _primaryColor, // Stellt sicher, dass die Primärfarbe exakt _primaryColor ist.
      // Manuelle Anpassungen für den Light-Mode.
      surface: const Color(0xFFF5F5F5),
      onSurface: const Color(0xFF333333),
    );

    return _getThemeData(colorScheme);
  }

  // ##################################################################
  // #                     DAS DUNKLE THEME (Dark)                    #
  // ##################################################################
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
      primary:
          _primaryColor, // Stellt sicher, dass die Primärfarbe exakt _primaryColor ist.
      // Hier sind die generierten Farben meist schon passend.
    );
    return _getThemeData(colorScheme);
  }

  // ##################################################################
  // #                  GEMEINSAME THEME-DEFINITION                   #
  // ##################################################################
  // Zentrale Methode, um ThemeData zu erstellen und Code-Duplizierung zu vermeiden.
  static ThemeData _getThemeData(
    ColorScheme colorScheme,
  ) {
    final isLight =
        colorScheme.brightness ==
        Brightness.light;

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: colorScheme,
      // Textfarben an das Farbschema anpassen.
      textTheme: _textTheme.apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      ),
      scaffoldBackgroundColor:
          colorScheme.surface,
      elevatedButtonTheme:
          ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  colorScheme.primary,
              foregroundColor:
                  colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                      borderRadius,
                    ),
              ),
              minimumSize: const Size(0, 52),
              padding: const EdgeInsets.symmetric(
                vertical: paddingSmall,
              ),
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      cardTheme: CardThemeData(
        elevation:
            0, // Ich nutze meinen eigenen Schatten.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: paddingSmall,
        ),
        // Im Dark Mode bekommen Karten eine leicht andere Farbe für besseren Kontrast.
        color: isLight
            ? colorScheme.surface
            : colorScheme.surfaceVariant,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          borderSide: BorderSide(
            color: colorScheme.onSurface
                .withAlpha(102), // 40% Deckkraft
          ),
        ),
        floatingLabelStyle: TextStyle(
          color: colorScheme.primary,
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: colorScheme.onPrimary,
        unselectedLabelColor: colorScheme
            .onPrimary
            .withAlpha(178), // 70% Deckkraft
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: colorScheme.primaryContainer,
        ),
        labelStyle: navigationText,
        unselectedLabelStyle: navigationText,
      ),
    );
  }
}
