//lib/ui/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData build() {
    return ThemeData(
      // fallback font for UI:
      fontFamily: 'Urbanist',
      textTheme: const TextTheme(
        // headlineSmall is used in DusKhariGrid for baseUnit.character
        headlineSmall: TextStyle(
          fontFamily: 'GurbachhanAkkhaLipi',
          fontSize: 32,
        ),
        // bodyLarge (e.g. for syllable transliteration)
        bodyLarge: TextStyle(fontFamily: 'GurbachhanAkkhaLipi', fontSize: 20),
        // you can define more if you need—e.g. bodyMedium for small chars
      ),
    );
  }
}
