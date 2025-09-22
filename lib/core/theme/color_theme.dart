import 'package:flutter/material.dart';
import 'package:skincare/widget/auth/custom_button.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.green,
    colorScheme: ColorScheme.fromSeed(
      seedColor: CustomButton.primary,
      primary: CustomButton.primary,
      secondary: Colors.teal, // 👈 change if you want
      brightness: Brightness.light,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: CustomButton.primary,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 16,
        color: Colors.black54,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: CustomButton.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
