import 'package:flutter/material.dart';

class AppTheme {
  // Warhammer 40K Color Palette
  static const Color imperialGold = Color(0xFFFFD700);
  static const Color bloodRed = Color(0xFF8B0000);
  static const Color abyssalBlack = Color(0xFF1A1A1A);
  static const Color warningRed = Color(0xFFFF4444);
  static const Color mechanicusGrey = Color(0xFF505050);
  static const Color purityWhite = Color(0xFFF0F0F0);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.dark(
        primary: bloodRed,
        secondary: imperialGold,
        surface: abyssalBlack,
        background: abyssalBlack,
        error: warningRed,
        onPrimary: purityWhite,
        onSecondary: abyssalBlack,
        onSurface: purityWhite,
        onBackground: purityWhite,
        onError: purityWhite,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: abyssalBlack,
        foregroundColor: imperialGold,
        elevation: 0,
      ),
      cardTheme: CardTheme(
        color: mechanicusGrey,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide.none,
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: abyssalBlack,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: imperialGold, width: 1),
        ),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: imperialGold,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: imperialGold,
          fontWeight: FontWeight.bold,
        ),
        titleLarge: TextStyle(
          color: purityWhite,
          fontWeight: FontWeight.bold,
        ),
        bodyLarge: TextStyle(
          color: purityWhite,
        ),
        bodyMedium: TextStyle(
          color: purityWhite,
        ),
      ),
      iconTheme: const IconThemeData(
        color: imperialGold,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: bloodRed,
          foregroundColor: purityWhite,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: bloodRed,
        foregroundColor: imperialGold,
        elevation: 0,
      ),
    );
  }

  static ThemeData get lightTheme {
    return darkTheme; // Force dark theme for W40K style
  }
}
