import 'package:flutter/material.dart';

// ##################################################################
// #                  ZENTRALE DESIGN-STEUERUNG                     #
// ##################################################################
// In dieser Datei wird das komplette Look-and-Feel der App definiert.
// Änderungen hier wirken sich auf die gesamte App aus.

class AppTheme {
  // privater konstruktor, damit man die klasse nicht aus versehen erstellt
  AppTheme._();

  // --- 1. GRUNDFARBEN (Branding) ---
  // Hier legst du die Hauptfarben deiner Marke fest.
  static const _primaryColor = Color(0xFF45BDF9);
  static const _onPrimaryColor = Colors.white; // Textfarbe AUF der Hauptfarbe (z.B. in Buttons)
  static const _backgroundColor = Color(0xFFF5F5F5); // Standard-Hintergrund für die meisten Seiten
  static const _textColor = Color(0xFF333333); // Standard-Textfarbe auf hellen Hintergründen

  // --- 2. AKZENT- & STATUS-FARBEN ---
  // Farben für spezielle Hervorhebungen oder Zustände wie Fehler.
  static const _lightSecondaryColor = Color(0xFF00527A); // Ein dunkleres, satteres Blau
  static const _lightErrorColor = Color(0xFFB00020); // Standard Material Light Error

  // Dieselben Farben, aber für den Dark Mode optimiert (meist heller).
  static const _darkSecondaryColor = Color(0xFF82DDFF); // Helleres Blau als Akzent
  static const _darkErrorColor = Color(0xFFCF6679); // Standard Material Dark Error

  // --- 3. ABSTÄNDE & FORMEN ---
  // Diese Werte steuern das allgemeine Layout und die "Weichheit" des Designs.
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double borderRadius = 12.0; // Globaler Eck-Radius. Macht die App "weicher" oder "kantiger".

  // --- 4. EFFEKTE (Schatten & Verläufe) ---
  // Methoden, die je nach Theme (Light/Dark) unterschiedliche Effekte zurückgeben.
  static List<BoxShadow> getCardShadow(Brightness brightness) {
    // Gibt einen passenden Schatten zurück: dunkel für Light Mode, heller "Glow" für Dark Mode.
    final shadowColor = brightness == Brightness.light
        ? Colors.black.withAlpha(25)
        : Colors.white.withAlpha(30); // Erhöhte Transparenz für besseren Glow im Dark Mode

    return [
      BoxShadow(
        color: shadowColor,
        spreadRadius: 1,
        blurRadius: 8, // Etwas stärkerer Blur für mehr Sichtbarkeit
        offset: const Offset(0, 2),
      )
    ];
  }

  // Gibt einen passenden Hintergrundverlauf zurück.
  static BoxDecoration getBackgroundGradient(ColorScheme colorScheme) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [colorScheme.surface, colorScheme.primary.withAlpha(40)],
      ),
    );
  }

  // --- 5. SPEZIAL-STILE (falls nötig) ---
  static const TextStyle navigationText = TextStyle(
    fontWeight: FontWeight.bold,
  );

  // ##################################################################
  // #                      DAS HELLE THEME (Light)                   #
  // ##################################################################
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme(
        primary: _primaryColor,
        onPrimary: _onPrimaryColor,
        secondary: _lightSecondaryColor,
        onSecondary: Colors.white,
        error: _lightErrorColor,
        onError: Colors.white,
        surface: _backgroundColor,
        onSurface: _textColor,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        // Definiert die globalen Textstile. Änderungen hier betreffen alle Texte.
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
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        // Stil für alle primären Buttons in der App.
        style: ElevatedButton.styleFrom(
          backgroundColor: _primaryColor,
          foregroundColor: _textColor, // Besserer Kontrast für Lesbarkeit (Accessibility)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          minimumSize: const Size(0, 52), // höhe fix, breite flexibel
          padding: const EdgeInsets.symmetric(vertical: paddingSmall),
        ),
      ),
      appBarTheme: const AppBarTheme(
        // Stil für die obere App-Leiste.
        backgroundColor: _primaryColor,
        foregroundColor: _onPrimaryColor,
      ),
      cardTheme: CardThemeData(
        // Stil für alle "Karten" in der App.
        elevation: 0, // benutze meinen eigenen schatten (getCardShadow)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        margin: const EdgeInsets.symmetric(vertical: paddingSmall),
      ),
      inputDecorationTheme: InputDecorationTheme(
        // Stil für alle Eingabefelder (Textfelder).
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: _textColor.withAlpha(102), // Neutralerer Rand (0.4 opacity)
          ),
        ),
        floatingLabelStyle: const TextStyle(
          color: _primaryColor,
        ),
      ),
      tabBarTheme: const TabBarThemeData(
        // Stil für die Tab-Leiste (z.B. in der AppBar).
        labelColor: _onPrimaryColor,
        unselectedLabelColor: _textColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          color: _primaryColor,
        ),
        labelStyle: navigationText, // nur für schriftart/dicke etc.
        unselectedLabelStyle: navigationText,
      ),
    );
  }

  // ##################################################################
  // #                     DAS DUNKLE THEME (Dark)                    #
  // ##################################################################
  static ThemeData get darkTheme {
    // Basis ist das lightTheme. Hier werden nur die Abweichungen für den Dark Mode definiert.
    return lightTheme.copyWith(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: _primaryColor,
        onPrimary: _onPrimaryColor,
        secondary: _darkSecondaryColor,
        onSecondary: Colors.black, // Text auf dem hellen Akzent
        error: _darkErrorColor,
        onError: Colors.black, // Text auf der hellen Error-Farbe
        surface: Color(0xFF121212), // Standard-Dunkelmodus-Hintergrund
        onSurface: Color(0xFFE0E0E0), // Hellerer Text für dunklen Hintergrund
      ),
      scaffoldBackgroundColor: const Color(0xFF121212), // Hintergrund muss explizit gesetzt werden.
      cardTheme: lightTheme.cardTheme.copyWith(
        color: const Color(0xFF2A2A2A), // Heller für mehr Kontrast zum Hintergrund
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        // Button-Stil für den Dark Mode anpassen.
        style: lightTheme.elevatedButtonTheme.style?.copyWith(
          foregroundColor: WidgetStateProperty.all(_onPrimaryColor), // Heller Text im Dark Mode
        ),
      ),
      inputDecorationTheme: lightTheme.inputDecorationTheme.copyWith(
        // Eingabefelder für den Dark Mode anpassen.
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(
            color: const Color(0xFFE0E0E0).withAlpha(102), // Hellerer Rand (0.4 opacity)
          ),
        ),
      ),
      // TextTheme anpassen, damit die Texte auch hell werden.
      textTheme: lightTheme.textTheme.apply(
        bodyColor: const Color(0xFFE0E0E0), // onSurface für Dark
        displayColor: const Color(0xFFE0E0E0), // onSurface für Dark
        decorationColor: const Color(0xFFE0E0E0), // onSurface für Dark
      ),
      tabBarTheme: lightTheme.tabBarTheme.copyWith(
        unselectedLabelColor: const Color(0xFFE0E0E0), // Hellerer Text für inaktive Tabs
      ),
    );
  }
}
