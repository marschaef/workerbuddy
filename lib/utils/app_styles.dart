import 'package:flutter/material.dart';

/// Definiert das visuelle Erscheinungsbild der App.
///
/// Enthält Farbpaletten, Schriftstile und Komponenten-Designs
/// für den Light- und Dark-Mode.
/// Änderungen hier wirken sich global auf die App aus.
class AppTheme {
  AppTheme._();

  // Definiert die primäre Akzentfarbe der Anwendung.
  static const _primaryColor = Color(0xFF45BDF9);

  // Standardisierte Abstände für ein konsistentes Layout.
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  // Standard-Radius für abgerundete Ecken.
  static const double borderRadius = 12.0;

  /// Erzeugt einen dezenten Schatten für Karten, angepasst an den Theme-Modus.
  static List<BoxShadow> getCardShadow(
    Brightness brightness,
  ) {
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

  /// Erzeugt einen sanften Hintergrundverlauf.
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

  // Text-Stil für die Navigationsleiste.
  static const TextStyle navigationText =
      TextStyle(fontWeight: FontWeight.bold);

  // Definiert die grundlegenden Text-Stile der App.
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
      fontSize: 14.0,
      fontWeight: FontWeight.w700,
    ),
  );

  /// Konfiguration für das helle Theme.
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.light,
      primary: _primaryColor,
      onPrimary: Colors.white,

      surface: const Color(0xFFF5F5F5),
      onSurface: const Color(0xFF333333),
    );

    return _getThemeData(colorScheme);
  }

  /// Konfiguration für das dunkle Theme.
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: _primaryColor,
      brightness: Brightness.dark,
      primary: _primaryColor,
      onPrimary: Colors.white,
    );
    return _getThemeData(colorScheme);
  }

  /// Baut das `ThemeData`-Objekt basierend auf einem `ColorScheme`.
  /// Hier werden die globalen Stile für Widgets wie Buttons, Karten etc. definiert.
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
              elevation: 4.0,
              shadowColor: Colors.black
                  .withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                      borderRadius,
                    ),
              ),
              minimumSize: const Size(0, 52),
              padding: const EdgeInsets.symmetric(
                vertical: paddingMedium,
                horizontal: paddingLarge,
              ),
            ),
          ),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: paddingSmall,
        ),

        color: isLight
            ? colorScheme.surface
            : colorScheme.surfaceContainerHighest,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            borderRadius,
          ),
          borderSide: BorderSide(
            color: colorScheme.onSurface
                .withAlpha(102),
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
            .withAlpha(178),
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