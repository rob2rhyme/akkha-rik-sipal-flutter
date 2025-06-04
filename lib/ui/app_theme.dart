// lib/ui/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData build() {
    return ThemeData(
      // Use Akkha Lipi by default for all Text widgets.
      fontFamily: 'Urbanist',

      primarySwatch: Colors.deepPurple,

      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'GurbachhanAkkhaLipi', // explicit override
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          // inherits 'GurbachhanAkkhaLipi'
        ),
        // You can define more variants here as needed...
      ),
    );
  }
}
