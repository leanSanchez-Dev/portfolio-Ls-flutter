/// Barrel for Bento theme tokens.
///
/// Source of truth for [ThemeData] construction remains
/// `lib/utils/theme_data.dart` (`themeFor` / presets + legacy [AppColors]
/// helpers). This file re-exports the extension and themes for cleaner
/// imports from UI / providers.
library;

export 'package:portfolio_ls/core/theme/app_colors_extension.dart';
export 'package:portfolio_ls/core/theme/app_theme_id.dart';
export 'package:portfolio_ls/utils/theme_data.dart'
    show
        AppColors,
        AppFonts,
        colorsFor,
        darkTheme,
        lightTheme,
        monokaiTheme,
        obsidianTheme,
        pandaTheme,
        themeData,
        themeFor;
