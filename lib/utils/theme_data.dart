import 'package:flutter/material.dart';

// Define the color scheme using constants for better maintainability
const Color _primaryColor = Color(0xFF1A1C1E); // Dark blue
const Color _primaryColorLight = Color(0xFF9E9E9E); // Lighter shade of primary
const Color _primaryColorDark = Color(0xFF000000); // Black
const Color _canvasColor = _primaryColor; // For compatibility with some themes

// Use a ThemeData constructor and set properties based on the provided JSON
final ThemeData themeData = ThemeData(
  // Apply material 3 visual design language
  useMaterial3: true,

  // Color scheme (consider using ThemeData.from with a custom ColorScheme if desired)
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    error: Color(0xFFFFB4AB), // Light red
    errorContainer: Color(0xFF93000A), // Darker red
    inversePrimary: Color(0xFF225FA6), // Light blue
    inverseSurface: Color(0xFFE3E2E6), // Light gray
    onError: Color(0xFF690005), // Dark red
    onErrorContainer: Color(0xFFFFB4AB), // Light red
    onInverseSurface: Color(0xFF2F3033), // Dark gray
    onPrimary: Color(0xFF003060), // Dark blue
    onPrimaryContainer: Color(0xFFD5E3FF), // Light blue
    onSecondary: Color(0xFF273141), // Gray
    onSecondaryContainer: Color(0xFFD9E3F8), // Light gray
    onSurface: Color(0xFFE3E2E6), // Light gray
    onSurfaceVariant: Color(0xFFC4C6CF), // Lighter gray
    onTertiary: Color(0xFF3E2845), // Darker blue
    onTertiaryContainer: Color(0xFFF8D8FE), // Light blue
    outline: Color(0xFF8E9199), // Light gray
    outlineVariant: Color(0xFF43474E), // Darker gray
    primary: _primaryColor, // Dark blue
    primaryContainer: Color(0xFF004788), // Darker blue
    scrim: Colors.black, // Black overlay
    secondary: Color(0xFFBDC7DC), // Light blue
    secondaryContainer: Color(0xFF3D4758), // Darker blue
    shadow: Colors.black, // Black shadow
    surface: _primaryColor, // Dark blue
    surfaceTint: _primaryColor, // Dark blue (for compatibility)
    surfaceContainerHighest: Color(0xFF43474E), // Darker gray
    tertiary: Color(0xFFDBBDE2), // Light blue
    tertiaryContainer: Color(0xFF553E5D), // Darker blue
  ),

  // Other properties based on the JSON
  canvasColor: _canvasColor,
  dialogBackgroundColor: _primaryColor,
  disabledColor: const Color(0x62FFFFFF), // Light gray with 62% opacity
  dividerColor: const Color(0x01feeee6), // Light green with 1F% opacity
  focusColor: Colors.white,
  highlightColor: const Color(0x40CCCCCC), // Light gray with 40% opacity
  hintColor: const Color(0x99FFFFFF), // Light gray with 99% opacity
  hoverColor: const Color(0x0AFFFFFF), // Light blue with 0A% opacity
  unselectedWidgetColor: const Color(0xB3FFFFFF), // Light gray with 73% opacity
  visualDensity: VisualDensity.compact, // More compact UI elements
  indicatorColor: const Color(0xFFE3E2E6), // Light gray
  materialTapTargetSize:
      MaterialTapTargetSize.shrinkWrap, // Smaller tap target area
  platform: TargetPlatform.windows, // Set to the desired platform
  primaryColor: _primaryColor, // Dark blue
  primaryColorDark: _primaryColorDark, // Black
  primaryColorLight: _primaryColorLight, // Lighter shade of primary
  primaryIconTheme: const IconThemeData(color: Colors.white), // White icons
  inputDecorationTheme: const InputDecorationTheme(
    alignLabelWithHint: false,
    filled: false,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    isCollapsed: false,
    isDense: false,
  ),
  scaffoldBackgroundColor: _primaryColor,
  secondaryHeaderColor: const Color(0xFF616161), // Gray
  shadowColor: Colors.black, // Black shadow
  splashColor: const Color(0x40CCCCCC), // Light gray with 40% opacity
  textTheme: const TextTheme(
    bodyLarge: TextStyle(
      color: Color(0xFFE3E2E6),
      decoration: TextDecoration.none,
      decorationColor: Color(0xFFE3E2E6),
      fontFamily: 'Poppins',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      inherit: false,
      letterSpacing: 0.5,
      textBaseline: TextBaseline.alphabetic,
    ),
  ),
  buttonTheme: ButtonThemeData(
    alignedDropdown: false, // Don't align dropdown buttons with other text
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFA7C8FF), // Custom primary color for buttons
      brightness: Brightness.dark,
      // ... other color scheme properties as in the JSON ...
    ),
    height: 36, // Button height
    // layoutBehavior: ButtonLayoutBehavior.padded, // Use padding inside buttons
    minWidth: 88, // Minimum button width
    padding: const EdgeInsets.symmetric(
        horizontal: 16, vertical: 0), // Custom padding
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)), // Rounded corners
      side: BorderSide(
        // Omit the side
        color: Colors.transparent, // Transparent color
        style: BorderStyle.none, // No border style
        width: 0, // Zero width
      ),
    ),
  ),
// Use the ripple splash effect
);
