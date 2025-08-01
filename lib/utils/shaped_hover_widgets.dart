// Widgets de hover inspirados en el estilo de Core Competencies
import 'package:flutter/material.dart';
import '../utils/animations.dart';
import '../utils/theme_data.dart';

/// Widget estilo Core Competencies - Chip con hover y sombra redondeada
class CompetencyStyleChip extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double hoverScale;
  final Duration duration;

  const CompetencyStyleChip({
    super.key,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin,
    this.borderRadius = 20,
    this.hoverScale = 1.05,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final chipBackgroundColor = backgroundColor ?? AppColors.getChipBackground(context);
    final chipTextColor = textColor ?? AppColors.getChipText(context);
    final chipBorderColor = borderColor ?? AppColors.getBorderStrong(context);
    
    return Container(
      margin: margin,
      child: AnimatedHoverContainer(
        hoverScale: hoverScale,
        duration: duration,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: chipBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: chipBorderColor,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).brightness == Brightness.dark 
                    ? Colors.black.withOpacity(0.3)
                    : Theme.of(context).shadowColor.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: chipTextColor,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ),
      ),
    );
  }
}

/// Widget estilo Core Competencies - Tarjeta con ícono y contenido
class CompetencyStyleCard extends StatelessWidget {
  final Widget child;
  final IconData? icon;
  final String? title;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final double hoverScale;
  final double hoverElevation;
  final Duration duration;
  final double? width;

  const CompetencyStyleCard({
    super.key,
    required this.child,
    this.icon,
    this.title,
    this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(24),
    this.margin,
    this.borderRadius = 20,
    this.hoverScale = 1.02,
    this.hoverElevation = 15,
    this.duration = const Duration(milliseconds: 200),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Usar colores más contrastantes para las tarjetas en modo oscuro
    final cardBackgroundColor = backgroundColor ?? 
        (isDarkMode 
            ? Color(0xFF2D3748) // Gris azulado más claro para tarjetas
            : Theme.of(context).cardColor);
    
    return Container(
      width: width,
      margin: margin,
      child: AnimatedHoverContainer(
        hoverScale: hoverScale,
        hoverElevation: hoverElevation,
        hoverShadowColor: Theme.of(context).primaryColor,
        duration: duration,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: cardBackgroundColor,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? (isDarkMode 
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.5)
                  : Theme.of(context).primaryColor.withValues(alpha: 0.2)),
              width: isDarkMode ? 2.5 : 2,
            ),
            boxShadow: [
              BoxShadow(
                color: isDarkMode 
                    ? Colors.black.withValues(alpha: 0.6)
                    : Theme.of(context).primaryColor.withValues(alpha: 0.1),
                blurRadius: isDarkMode ? 25 : 20,
                spreadRadius: 0,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon!,
                  color: isDarkMode 
                      ? Theme.of(context).primaryColor.withValues(alpha: 0.9)
                      : Theme.of(context).primaryColor,
                  size: 32,
                ),
                const SizedBox(height: 16),
              ],
              if (title != null) ...[
                Text(
                  title!,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                ),
                const SizedBox(height: 16),
              ],
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget para crear un grid de chips estilo Core Competencies
class CompetencyChipGrid extends StatelessWidget {
  final List<String> items;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;
  final Color? chipBackgroundColor;
  final Color? chipTextColor;
  final Color? chipBorderColor;
  final double chipBorderRadius;
  final EdgeInsetsGeometry? chipPadding;

  const CompetencyChipGrid({
    super.key,
    required this.items,
    this.alignment = WrapAlignment.center,
    this.spacing = 12,
    this.runSpacing = 12,
    this.chipBackgroundColor,
    this.chipTextColor,
    this.chipBorderColor,
    this.chipBorderRadius = 20,
    this.chipPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: alignment,
      spacing: spacing,
      runSpacing: runSpacing,
      children: items.map((item) => CompetencyStyleChip(
        text: item,
        backgroundColor: chipBackgroundColor,
        textColor: chipTextColor,
        borderColor: chipBorderColor,
        borderRadius: chipBorderRadius,
        padding: chipPadding,
      )).toList(),
    );
  }
}

/// Widget contenedor estilo Core Competencies con borde y gradiente sutil
class CompetencyContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool showShadow;

  const CompetencyContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(40),
    this.margin,
    this.borderRadius = 30,
    this.backgroundColor,
    this.borderColor,
    this.showShadow = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // Contenedor principal con mejor contraste
    final containerBackgroundColor = backgroundColor ?? 
        (isDarkMode 
            ? Color(0xFF2D3748) // Gris azulado más visible
            : Theme.of(context).cardColor);
    
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: containerBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? (isDarkMode 
              ? Theme.of(context).primaryColor.withValues(alpha: 0.6)
              : Theme.of(context).primaryColor.withValues(alpha: 0.2)),
          width: isDarkMode ? 2 : 1,
        ),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: isDarkMode 
                      ? Colors.black.withValues(alpha: 0.5)
                      : Theme.of(context).primaryColor.withValues(alpha: 0.05),
                  blurRadius: isDarkMode ? 35 : 30,
                  spreadRadius: 0,
                  offset: const Offset(0, 15),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}
