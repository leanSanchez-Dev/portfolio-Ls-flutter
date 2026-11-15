import 'package:flutter/material.dart';

/// Semantic color tokens for the Bento dark-first redesign.
///
/// Consume via `Theme.of(context).extension<AppColorsExtension>()!`.
@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.bgCanvas,
    required this.bgSurface,
    required this.bgSurfaceElevated,
    required this.borderSubtle,
    required this.textPrimary,
    required this.textSecondary,
    required this.accentPrimary,
    required this.accentSecondary,
  });

  final Color bgCanvas;
  final Color bgSurface;
  final Color bgSurfaceElevated;
  final Color borderSubtle;
  final Color textPrimary;
  final Color textSecondary;
  final Color accentPrimary;
  final Color accentSecondary;

  /// Obsidian / dark-first ESD (default).
  static const AppColorsExtension dark = AppColorsExtension(
    bgCanvas: Color(0xFF090A0F),
    bgSurface: Color(0xFF11131A),
    bgSurfaceElevated: Color(0xFF181B26),
    borderSubtle: Color(0x14FFFFFF),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    accentPrimary: Color(0xFF6366F1),
    accentSecondary: Color(0xFF10B981),
  );

  /// Alias of [dark] for naming clarity.
  static const AppColorsExtension obsidian = dark;

  static const AppColorsExtension light = AppColorsExtension(
    bgCanvas: Color(0xFFF8FAFC),
    bgSurface: Color(0xFFFFFFFF),
    bgSurfaceElevated: Color(0xFFF1F5F9),
    borderSubtle: Color(0x140F172A),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    accentPrimary: Color(0xFF4F46E5),
    accentSecondary: Color(0xFF059669),
  );

  /// Monokai / Monokai Pro inspired.
  static const AppColorsExtension monokai = AppColorsExtension(
    bgCanvas: Color(0xFF272822),
    bgSurface: Color(0xFF2D2A2E),
    bgSurfaceElevated: Color(0xFF3E3D32),
    borderSubtle: Color(0x14FFFFFF),
    textPrimary: Color(0xFFF8F8F2),
    textSecondary: Color(0xFFCFCFC2),
    accentPrimary: Color(0xFFFF6188),
    accentSecondary: Color(0xFFA9DC76),
  );

  /// Panda Syntax inspired.
  static const AppColorsExtension panda = AppColorsExtension(
    bgCanvas: Color(0xFF292A2B),
    bgSurface: Color(0xFF31353A),
    bgSurfaceElevated: Color(0xFF3B3E43),
    borderSubtle: Color(0x14FFFFFF),
    textPrimary: Color(0xFFE6E6E6),
    textSecondary: Color(0xFFBBBBBB),
    accentPrimary: Color(0xFFFF75B5),
    accentSecondary: Color(0xFF19F9D8),
  );

  @override
  AppColorsExtension copyWith({
    Color? bgCanvas,
    Color? bgSurface,
    Color? bgSurfaceElevated,
    Color? borderSubtle,
    Color? textPrimary,
    Color? textSecondary,
    Color? accentPrimary,
    Color? accentSecondary,
  }) {
    return AppColorsExtension(
      bgCanvas: bgCanvas ?? this.bgCanvas,
      bgSurface: bgSurface ?? this.bgSurface,
      bgSurfaceElevated: bgSurfaceElevated ?? this.bgSurfaceElevated,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      accentPrimary: accentPrimary ?? this.accentPrimary,
      accentSecondary: accentSecondary ?? this.accentSecondary,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) return this;
    return AppColorsExtension(
      bgCanvas: Color.lerp(bgCanvas, other.bgCanvas, t)!,
      bgSurface: Color.lerp(bgSurface, other.bgSurface, t)!,
      bgSurfaceElevated:
          Color.lerp(bgSurfaceElevated, other.bgSurfaceElevated, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      accentPrimary: Color.lerp(accentPrimary, other.accentPrimary, t)!,
      accentSecondary: Color.lerp(accentSecondary, other.accentSecondary, t)!,
    );
  }
}
