import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

/// Eyebrow + heading + optional subtitle used across Bento sections.
class BentoSectionHeader extends StatelessWidget {
  const BentoSectionHeader({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
    this.accentColor,
    this.align = TextAlign.left,
  });

  final String eyebrow;
  final String title;
  final String? subtitle;
  final Color? accentColor;
  final TextAlign align;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final accent = accentColor ?? colors.accentPrimary;
    final cross = align == TextAlign.center
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return Column(
      crossAxisAlignment: cross,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 24, height: 1, color: accent),
            const SizedBox(width: 8),
            Text(
              eyebrow.toUpperCase(),
              style: AppFonts.mono(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.6,
                color: accent,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Semantics(
          header: true,
          child: Text(
            title,
            textAlign: align,
            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                  color: colors.textPrimary,
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  height: 1.15,
                ),
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            textAlign: align,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: colors.textSecondary,
                  height: 1.55,
                ),
          ),
        ],
      ],
    );
  }
}

/// Shared horizontal padding + max width for Bento sections.
class BentoContentConstraints extends StatelessWidget {
  const BentoContentConstraints({super.key, required this.child});

  final Widget child;

  static const double maxWidth = 1152;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final horizontal = width < 600 ? 16.0 : (width < 1100 ? 24.0 : 32.0);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: child,
        ),
      ),
    );
  }
}
