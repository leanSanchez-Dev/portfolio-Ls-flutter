import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/core/theme/app_theme_id.dart';

/// Design tokens ESD Bento Grid Dark-First (lean.dev).
///
/// Los helpers `get*` siguen disponibles para la UI legacy; los tokens nuevos
/// (`*Canvas`, `*Elevated`, `*Accent`, …) son la fuente de verdad del rediseño.
class AppColors {
  AppColors._();

  // ── Dark (default) ────────────────────────────────────────────────────────
  static const Color darkCanvas = Color(0xFF090A0F);
  static const Color darkSurface = Color(0xFF11131A);
  static const Color darkElevated = Color(0xFF181B26);
  static const Color darkBorder = Color.fromRGBO(255, 255, 255, 0.08);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkAccent = Color(0xFF6366F1);
  static const Color darkSecondaryAccent = Color(0xFF10B981);

  // ── Light ─────────────────────────────────────────────────────────────────
  static const Color lightCanvas = Color(0xFFF8FAFC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightElevated = Color(0xFFF1F5F9);
  static const Color lightBorder = Color.fromRGBO(15, 23, 42, 0.08);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightAccent = Color(0xFF4F46E5);
  static const Color lightSecondaryAccent = Color(0xFF059669);

  // ── Semantic ──────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // ── Legacy aliases (UI existente: CV / music / skills) ─────────────────────
  static const Color lightPrimary = lightAccent;
  static const Color lightSecondary = lightTextSecondary;
  static const Color lightBackground = lightCanvas;
  static const Color lightText = lightTextPrimary;
  static const Color darkPrimary = darkAccent;
  static const Color darkSecondary = darkSecondaryAccent;
  static const Color darkBackground = darkCanvas;
  static const Color darkText = darkTextPrimary;
  static const Color darkCardBackground = darkElevated;
  static const Color darkChipBackground = Color(0xFF222636);
  static const Color darkHoverBackground = Color(0xFF1E2230);
  static const Color darkBorderLight = Color(0xFF64748B);
  static const Color darkTextSecondaryStrong = Color(0xFFE2E8F0);
  static const Color darkTextTertiary = Color(0xFFCBD5E1);
  static const Color royalBlueLight = darkAccent;
  static const Color royalBlueMedium = lightAccent;
  static const Color royalBlueDark = Color(0xFF3730A3);
  static const Color royalBlueMetallic = Color(0xFF4338CA);

  static Color getCardBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkElevated
        : lightSurface;
  }

  static Color getChipBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkChipBackground
        : lightAccent.withValues(alpha: 0.1);
  }

  static Color getChipText(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightAccent;
  }

  static Color getBorder(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorder
        : lightBorder;
  }

  static Color getBorderStrong(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkBorderLight.withValues(alpha: 0.4)
        : lightBorder;
  }

  static Color getIconBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkChipBackground
        : lightAccent.withValues(alpha: 0.1);
  }

  static Color getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightAccent;
  }

  static Color getTextPrimary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextPrimary
        : lightTextPrimary;
  }

  static Color getTextSecondary(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkTextSecondaryStrong
        : lightTextSecondary;
  }

  static Color getHoverBackground(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkHoverBackground
        : lightElevated;
  }

  static Color getAccent(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkAccent
        : lightAccent;
  }

  static Color getSecondaryAccent(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSecondaryAccent
        : lightSecondaryAccent;
  }

  static Color getCanvas(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkCanvas
        : lightCanvas;
  }

  static Color getSurface(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkSurface
        : lightSurface;
  }

  static Color getElevated(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkElevated
        : lightElevated;
  }
}

/// Familias tipográficas ESD.
///
/// Sans: Plus Jakarta Sans · Mono: JetBrains Mono (vía `google_fonts`).
/// Poppins permanece en `pubspec` assets por compatibilidad; ThemeData ya no
/// lo usa como familia por defecto.
class AppFonts {
  AppFonts._();

  static String get sansFamily => GoogleFonts.plusJakartaSans().fontFamily!;
  static String get monoFamily => GoogleFonts.jetBrainsMono().fontFamily!;

  static TextStyle mono({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.jetBrainsMono(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }
}

TextTheme _buildTextTheme({
  required Brightness brightness,
  required Color primary,
  required Color secondary,
}) {
  final base = GoogleFonts.plusJakartaSansTextTheme(
    brightness == Brightness.dark
        ? ThemeData.dark().textTheme
        : ThemeData.light().textTheme,
  );

  return base.copyWith(
    displayLarge: base.displayLarge?.copyWith(
      fontSize: 48,
      fontWeight: FontWeight.w800,
      color: primary,
      height: 1.15,
    ),
    displayMedium: base.displayMedium?.copyWith(
      fontSize: 36,
      fontWeight: FontWeight.w700,
      color: primary,
      height: 1.2,
    ),
    headlineLarge: base.headlineLarge?.copyWith(
      fontSize: 28,
      fontWeight: FontWeight.w700,
      color: primary,
      height: 1.25,
    ),
    headlineMedium: base.headlineMedium?.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: primary,
      height: 1.3,
    ),
    headlineSmall: base.headlineSmall?.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: primary,
      height: 1.35,
    ),
    titleLarge: base.titleLarge?.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    titleMedium: base.titleMedium?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    bodyLarge: base.bodyLarge?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: primary,
      height: 1.6,
    ),
    bodyMedium: base.bodyMedium?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: secondary,
      height: 1.5,
    ),
    bodySmall: base.bodySmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: secondary,
      height: 1.45,
    ),
    labelLarge: base.labelLarge?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: primary,
    ),
    labelMedium: GoogleFonts.jetBrainsMono(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: secondary,
    ),
    labelSmall: GoogleFonts.jetBrainsMono(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      color: secondary,
    ),
  );
}

ThemeData _buildTheme({
  required Brightness brightness,
  required AppColorsExtension colors,
}) {
  final isDark = brightness == Brightness.dark;
  final colorScheme = isDark
      ? ColorScheme.dark(
          primary: colors.accentPrimary,
          secondary: colors.accentSecondary,
          surface: colors.bgSurface,
          onSurface: colors.textPrimary,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: AppColors.error,
          outline: colors.borderSubtle,
        )
      : ColorScheme.light(
          primary: colors.accentPrimary,
          secondary: colors.accentSecondary,
          surface: colors.bgSurface,
          onSurface: colors.textPrimary,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: AppColors.error,
          outline: colors.borderSubtle,
        );

  return ThemeData(
    useMaterial3: true,
    brightness: brightness,
    fontFamily: AppFonts.sansFamily,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: colors.bgCanvas,
    cardColor: isDark ? colors.bgSurfaceElevated : colors.bgSurface,
    dividerColor: colors.borderSubtle,
    textTheme: _buildTextTheme(
      brightness: brightness,
      primary: colors.textPrimary,
      secondary: colors.textSecondary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.accentPrimary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.accentPrimary,
        side: BorderSide(color: colors.accentPrimary, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconTheme: isDark
        ? IconThemeData(color: colors.accentPrimary, size: 24)
        : null,
    appBarTheme: AppBarTheme(
      backgroundColor: isDark ? colors.bgCanvas : colors.bgSurface,
      foregroundColor: colors.textPrimary,
      elevation: 0,
      centerTitle: false,
      iconTheme: isDark ? IconThemeData(color: colors.accentPrimary) : null,
      titleTextStyle: GoogleFonts.plusJakartaSans(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),
    ),
    extensions: <ThemeExtension<dynamic>>[colors],
  );
}

/// Tema claro ESD.
final ThemeData lightTheme = _buildTheme(
  brightness: Brightness.light,
  colors: AppColorsExtension.light,
);

/// Tema Obsidian ESD (default dark-first).
final ThemeData obsidianTheme = _buildTheme(
  brightness: Brightness.dark,
  colors: AppColorsExtension.obsidian,
);

/// Alias legacy → [obsidianTheme].
final ThemeData darkTheme = obsidianTheme;

/// Monokai / Monokai Pro inspired.
final ThemeData monokaiTheme = _buildTheme(
  brightness: Brightness.dark,
  colors: AppColorsExtension.monokai,
);

/// Panda Syntax inspired.
final ThemeData pandaTheme = _buildTheme(
  brightness: Brightness.dark,
  colors: AppColorsExtension.panda,
);

/// Color tokens for [id] (pure; safe in unit tests without GoogleFonts).
AppColorsExtension colorsFor(AppThemeId id) => switch (id) {
      AppThemeId.obsidian => AppColorsExtension.obsidian,
      AppThemeId.light => AppColorsExtension.light,
      AppThemeId.monokai => AppColorsExtension.monokai,
      AppThemeId.panda => AppColorsExtension.panda,
    };

/// Resolves [ThemeData] for a persisted / selected [AppThemeId].
ThemeData themeFor(AppThemeId id) => switch (id) {
      AppThemeId.obsidian => obsidianTheme,
      AppThemeId.light => lightTheme,
      AppThemeId.monokai => monokaiTheme,
      AppThemeId.panda => pandaTheme,
    };

/// Alias legacy — dark-first.
final ThemeData themeData = darkTheme;
