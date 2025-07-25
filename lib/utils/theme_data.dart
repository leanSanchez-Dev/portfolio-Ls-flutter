import 'package:flutter/material.dart';

// Professional color constants
class AppColors {
  // Light theme colors
  static const Color lightPrimary = Color(0xFF2563EB);
  static const Color lightSecondary = Color(0xFF64748B);
  static const Color lightBackground = Color(0xFFFAFAFA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightText = Color(0xFF1E293B);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightAccent = Color(0xFF3B82F6);

  // Dark theme colors
  static const Color darkPrimary = Color(0xFF3B82F6);
  static const Color darkSecondary = Color(0xFF64748B);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkText = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkAccent = Color(0xFF60A5FA);

  // Common colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
}

// Light Theme
final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.lightPrimary,
    brightness: Brightness.light,
    surface: AppColors.lightSurface,
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
    onSurface: AppColors.lightText,
    onPrimary: Colors.white,
  ),
  scaffoldBackgroundColor: AppColors.lightBackground,
  cardColor: AppColors.lightSurface,
  disabledColor: const Color(0x62FFFFFF), // Light gray with 62% opacity
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: AppColors.lightText,
      height: 1.2,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
      height: 1.3,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.lightText,
      height: 1.4,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.lightText,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.lightText,
      height: 1.6,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.lightTextSecondary,
      height: 1.5,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.lightPrimary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.lightSurface,
    foregroundColor: AppColors.lightText,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.lightText,
    ),
  ),
);

// Dark Theme
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.darkPrimary,
    brightness: Brightness.dark,
    surface: AppColors.darkSurface,
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    onSurface: AppColors.darkText,
    onPrimary: AppColors.darkBackground,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkSurface,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: AppColors.darkText,
      height: 1.2,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
      height: 1.3,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.darkText,
      height: 1.4,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.darkText,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.darkText,
      height: 1.6,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.darkTextSecondary,
      height: 1.5,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    foregroundColor: AppColors.darkText,
    elevation: 0,
    centerTitle: false,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkText,
    ),
  ),
);

// Legacy theme for compatibility
final ThemeData themeData = darkTheme;
