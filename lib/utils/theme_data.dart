import 'package:flutter/material.dart';

// Professional color constants - Azul Rey Metalizado
class AppColors {
  // Light theme colors - Azul Rey Profesional
  static const Color lightPrimary = Color(0xFF1E3A8A); // Azul Rey intenso
  static const Color lightSecondary = Color(0xFF475569); // Gris azulado
  static const Color lightBackground = Color(0xFFFAFAFA); // Gris muy claro
  static const Color lightSurface = Color(0xFFFFFFFF); // Blanco
  static const Color lightText = Color(0xFF1E293B); // Gris muy oscuro
  static const Color lightTextSecondary = Color(0xFF64748B); // Gris medio
  static const Color lightAccent = Color(0xFF3B82F6); // Azul brillante

  // Dark theme colors - Azul Rey Metalizado Mejorado
  static const Color darkPrimary =
      Color(0xFF4F46E5); // Azul Rey metalizado vibrante
  static const Color darkSecondary =
      Color(0xFF8B5CF6); // Púrpura azulado metalizado
  static const Color darkBackground = Color(0xFF0F172A); // Azul muy oscuro
  static const Color darkSurface = Color(0xFF1E293B); // Azul gris oscuro
  static const Color darkText = Color(0xFFF1F5F9); // Gris casi blanco
  static const Color darkTextSecondary =
      Color(0xFFCBD5E1); // Gris claro azulado
  static const Color darkAccent =
      Color(0xFF6366F1); // Azul Rey metalizado claro

  // Enhanced dark mode colors for better visibility
  static const Color darkCardBackground = Color(0xFF2D3748); // Gris medio-oscuro
  static const Color darkChipBackground = Color(0xFF4A5568); // Gris medio
  static const Color darkHoverBackground = Color(0xFF374151); // Gris medio-claro
  static const Color darkBorder = Color(0xFF475569); // Borde visible
  static const Color darkBorderLight = Color(0xFF64748B); // Borde más claro
  
  // Dark mode text colors
  static const Color darkTextPrimary = Color(0xFFFFFFFF); // Blanco puro
  static const Color darkTextSecondaryStrong = Color(0xFFE2E8F0); // Gris muy claro
  static const Color darkTextTertiary = Color(0xFFCBD5E1); // Gris claro

  // Common colors
  static const Color success = Color(0xFF10B981); // Verde esmeralda
  static const Color warning = Color(0xFFF59E0B); // Ámbar
  static const Color error = Color(0xFFEF4444); // Rojo coral

  // Metallic royal blue variants
  static const Color royalBlueLight = Color(0xFF6366F1); // Azul Rey claro
  static const Color royalBlueMedium = Color(0xFF4F46E5); // Azul Rey medio
  static const Color royalBlueDark = Color(0xFF3730A3); // Azul Rey oscuro
  static const Color royalBlueMetallic =
      Color(0xFF4338CA); // Azul Rey metalizado

  // Helper method to get adaptive colors
  static Color getCardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCardBackground
        : lightSurface;
  }

  static Color getChipBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkChipBackground
        : lightPrimary.withOpacity(0.1);
  }

  static Color getChipText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightPrimary;
  }

  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder.withOpacity(0.3)
        : Theme.of(context).dividerColor.withOpacity(0.1);
  }

  static Color getBorderStrong(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderLight.withOpacity(0.4)
        : Theme.of(context).dividerColor.withOpacity(0.2);
  }

  static Color getIconBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkChipBackground
        : lightPrimary.withOpacity(0.1);
  }

  static Color getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightPrimary;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightText;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondaryStrong
        : lightTextSecondary;
  }

  static Color getHoverBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkHoverBackground
        : lightSurface;
  }
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

// Dark Theme - Azul Rey Metalizado Mejorado
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.darkPrimary,
    brightness: Brightness.dark,
    surface: AppColors.darkCardBackground,
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
    onSurface: AppColors.darkTextPrimary,
    onPrimary: Colors.white,
    background: AppColors.darkBackground,
    onBackground: AppColors.darkTextPrimary,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  cardColor: AppColors.darkCardBackground,
  dividerColor: AppColors.darkBorder,
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 48,
      fontWeight: FontWeight.bold,
      color: AppColors.darkTextPrimary,
      height: 1.2,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 36,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
      height: 1.3,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 28,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
      height: 1.3,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 24,
      fontWeight: FontWeight.w500,
      color: AppColors.darkTextPrimary,
      height: 1.4,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: AppColors.darkTextPrimary,
      height: 1.4,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.darkTextPrimary,
      height: 1.6,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.darkTextSecondaryStrong,
      height: 1.5,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      shadowColor: AppColors.royalBlueMetallic.withOpacity(0.3),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.darkPrimary,
      side: BorderSide(color: AppColors.darkPrimary, width: 2),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.darkPrimary,
    size: 24,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.darkBackground,
    foregroundColor: AppColors.darkTextPrimary,
    elevation: 0,
    centerTitle: false,
    iconTheme: IconThemeData(
      color: AppColors.darkPrimary,
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: AppColors.darkTextPrimary,
    ),
  ),
);

// Legacy theme for compatibility
final ThemeData themeData = darkTheme;
