import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/theme/app_theme_id.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tema global multi-preset con persistencia en [SharedPreferences].
///
/// Default: [AppThemeId.obsidian]. Migra `lean_dev_is_dark` si no hay
/// `lean_dev_theme_id`.
///
/// ## UI contract (para picker / navbar)
/// ```dart
/// context.watch<ThemeProvider>().themeId
/// context.read<ThemeProvider>().setTheme(AppThemeId.monokai)
/// context.read<ThemeProvider>().cycleTheme()
/// ```
/// [toggleTheme] llama [cycleTheme] para que el botón actual siga funcionando
/// hasta que UI Expert añada un selector.
class ThemeProvider extends ChangeNotifier {
  static const String prefsThemeIdKey = 'lean_dev_theme_id';
  static const String _legacyPrefsKey = 'lean_dev_is_dark';

  AppThemeId _themeId = AppThemeId.obsidian;
  bool _initialized = false;

  AppThemeId get themeId => _themeId;
  ThemeData get themeData => themeFor(_themeId);
  bool get isDarkMode => _themeId.isDark;
  bool get isInitialized => _initialized;

  /// Carga preferencia persistida. Idempotente.
  Future<void> init() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final storedId = prefs.getString(prefsThemeIdKey);
      if (storedId != null) {
        _apply(AppThemeId.fromStorage(storedId), persist: false);
      } else {
        // Migrate legacy bool: true → obsidian, false → light.
        final legacyDark = prefs.getBool(_legacyPrefsKey);
        final migrated = legacyDark == false
            ? AppThemeId.light
            : AppThemeId.obsidian;
        _apply(migrated, persist: true);
      }
    } catch (_) {
      _apply(AppThemeId.obsidian, persist: false);
    }
    _initialized = true;
    notifyListeners();
  }

  void setTheme(AppThemeId id) {
    if (_themeId == id) return;
    _apply(id, persist: true);
    notifyListeners();
  }

  /// obsidian → monokai → panda → light → obsidian.
  void cycleTheme() {
    setTheme(_themeId.next);
  }

  /// Backward-compat: cycles through all presets (was light↔dark).
  void toggleTheme() => cycleTheme();

  void setLightTheme() => setTheme(AppThemeId.light);

  void setDarkTheme() => setTheme(AppThemeId.obsidian);

  void _apply(AppThemeId id, {required bool persist}) {
    _themeId = id;
    if (persist) {
      _persist(id);
    }
  }

  Future<void> _persist(AppThemeId id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefsThemeIdKey, id.storageKey);
      // Keep legacy key coherent for older readers.
      await prefs.setBool(_legacyPrefsKey, id.isDark);
    } catch (_) {
      // Ignore storage failures (private mode / restricted iframes).
    }
  }
}
