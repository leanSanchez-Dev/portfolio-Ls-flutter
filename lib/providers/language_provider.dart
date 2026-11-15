import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Idioma global con persistencia en [SharedPreferences].
///
/// Default: español (`es`). Preferimos shared_preferences sobre
/// web_local_storage.
class LanguageProvider with ChangeNotifier {
  static const String _prefsKey = 'lean_dev_locale';

  Locale _currentLocale = const Locale('es');
  bool _initialized = false;

  Locale get currentLocale => _currentLocale;

  bool get isSpanish => _currentLocale.languageCode == 'es';
  bool get isEnglish => _currentLocale.languageCode == 'en';
  bool get isInitialized => _initialized;

  /// Carga preferencia persistida. Idempotente.
  Future<void> init() async {
    if (_initialized) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      final code = prefs.getString(_prefsKey) ?? 'es';
      _currentLocale = Locale(code == 'en' ? 'en' : 'es');
    } catch (_) {
      _currentLocale = const Locale('es');
    }
    _initialized = true;
    notifyListeners();
  }

  void setLocale(Locale locale) {
    final nextCode = locale.languageCode == 'en' ? 'en' : 'es';
    final next = Locale(nextCode);
    if (_currentLocale.languageCode == next.languageCode) return;
    _currentLocale = next;
    _persist(nextCode);
    notifyListeners();
  }

  void toggleLanguage() {
    if (_currentLocale.languageCode == 'es') {
      setLocale(const Locale('en'));
    } else {
      setLocale(const Locale('es'));
    }
  }

  String get currentLanguageName {
    return _currentLocale.languageCode == 'es' ? 'Español' : 'English';
  }

  String get otherLanguageName {
    return _currentLocale.languageCode == 'es' ? 'English' : 'Español';
  }

  Future<void> _persist(String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, code);
    } catch (_) {
      // Ignore storage failures.
    }
  }
}
