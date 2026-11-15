import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

void showBentoSnackBar(BuildContext context, String message) {
  final colors = Theme.of(context).extension<AppColorsExtension>()!;
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: colors.bgSurfaceElevated,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.borderSubtle),
      ),
      content: Text(
        message,
        style: AppFonts.mono(
          fontSize: 12,
          color: colors.textPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
