import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/core/theme/app_theme_id.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart' show colorsFor;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AppThemeId', () {
    test('fromStorage defaults to obsidian', () {
      expect(AppThemeId.fromStorage(null), AppThemeId.obsidian);
      expect(AppThemeId.fromStorage(''), AppThemeId.obsidian);
      expect(AppThemeId.fromStorage('unknown'), AppThemeId.obsidian);
      expect(AppThemeId.fromStorage('monokai'), AppThemeId.monokai);
    });

    test('labels and cycle order', () {
      expect(AppThemeId.light.labelEs, 'Claro');
      expect(AppThemeId.light.labelEn, 'Light');
      expect(AppThemeId.obsidian.labelEs, 'Obsidian');
      expect(AppThemeId.monokai.labelEn, 'Monokai');
      expect(AppThemeId.panda.labelEs, 'Panda');
      expect(AppThemeId.obsidian.next, AppThemeId.monokai);
      expect(AppThemeId.monokai.next, AppThemeId.panda);
      expect(AppThemeId.panda.next, AppThemeId.light);
      expect(AppThemeId.light.next, AppThemeId.obsidian);
      expect(AppThemeId.obsidian.isDark, isTrue);
      expect(AppThemeId.monokai.isDark, isTrue);
      expect(AppThemeId.panda.isDark, isTrue);
      expect(AppThemeId.light.isDark, isFalse);
    });
  });

  group('AppColorsExtension presets', () {
    test('all four presets register on ThemeData', () {
      for (final id in AppThemeId.values) {
        final colors = colorsFor(id);
        final theme = ThemeData(
          extensions: <ThemeExtension<dynamic>>[colors],
        );
        final ext = theme.extension<AppColorsExtension>();
        expect(ext, isNotNull, reason: '$id missing AppColorsExtension');
        expect(ext, same(colors));
      }
    });

    test('Obsidian (dark) keeps ESD indigo/emerald', () {
      expect(AppColorsExtension.obsidian, same(AppColorsExtension.dark));
      expect(AppColorsExtension.dark.bgCanvas, const Color(0xFF090A0F));
      expect(AppColorsExtension.dark.accentPrimary, const Color(0xFF6366F1));
      expect(AppColorsExtension.dark.accentSecondary, const Color(0xFF10B981));
    });

    test('Monokai pink accent + green secondary', () {
      final m = AppColorsExtension.monokai;
      expect(m.bgCanvas, const Color(0xFF272822));
      expect(m.bgSurface, const Color(0xFF2D2A2E));
      expect(m.bgSurfaceElevated, const Color(0xFF3E3D32));
      expect(m.borderSubtle, const Color(0x14FFFFFF));
      expect(m.textPrimary, const Color(0xFFF8F8F2));
      expect(m.textSecondary, const Color(0xFFCFCFC2));
      expect(m.accentPrimary, const Color(0xFFFF6188));
      expect(m.accentSecondary, const Color(0xFFA9DC76));
    });

    test('Panda pink primary + cyan secondary', () {
      final p = AppColorsExtension.panda;
      expect(p.bgCanvas, const Color(0xFF292A2B));
      expect(p.bgSurface, const Color(0xFF31353A));
      expect(p.bgSurfaceElevated, const Color(0xFF3B3E43));
      expect(p.borderSubtle, const Color(0x14FFFFFF));
      expect(p.textPrimary, const Color(0xFFE6E6E6));
      expect(p.textSecondary, const Color(0xFFBBBBBB));
      expect(p.accentPrimary, const Color(0xFFFF75B5));
      expect(p.accentSecondary, const Color(0xFF19F9D8));
    });
  });

  group('ThemeProvider', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('default is obsidian; setTheme + cycleTheme', () {
      final provider = ThemeProvider();
      expect(provider.themeId, AppThemeId.obsidian);
      expect(provider.isDarkMode, isTrue);

      provider.setTheme(AppThemeId.monokai);
      expect(provider.themeId, AppThemeId.monokai);
      expect(provider.isDarkMode, isTrue);

      provider.cycleTheme();
      expect(provider.themeId, AppThemeId.panda);

      provider.toggleTheme();
      expect(provider.themeId, AppThemeId.light);
      expect(provider.isDarkMode, isFalse);

      provider.cycleTheme();
      expect(provider.themeId, AppThemeId.obsidian);
    });

    test('init migrates legacy lean_dev_is_dark bool', () async {
      SharedPreferences.setMockInitialValues({
        'lean_dev_is_dark': false,
      });
      final provider = ThemeProvider();
      await provider.init();
      expect(provider.themeId, AppThemeId.light);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(ThemeProvider.prefsThemeIdKey), 'light');
    });

    test('init prefers lean_dev_theme_id over legacy bool', () async {
      SharedPreferences.setMockInitialValues({
        'lean_dev_theme_id': 'panda',
        'lean_dev_is_dark': false,
      });
      final provider = ThemeProvider();
      await provider.init();
      expect(provider.themeId, AppThemeId.panda);
      expect(provider.isDarkMode, isTrue);
    });

    test('setTheme persists storage key', () async {
      SharedPreferences.setMockInitialValues({});
      final provider = ThemeProvider();
      provider.setTheme(AppThemeId.monokai);
      await Future<void>.delayed(Duration.zero);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString(ThemeProvider.prefsThemeIdKey), 'monokai');
      expect(prefs.getBool('lean_dev_is_dark'), isTrue);
    });
  });
}
