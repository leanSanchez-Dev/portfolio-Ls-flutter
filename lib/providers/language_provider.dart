import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('es'); // Español por defecto

  Locale get currentLocale => _currentLocale;

  bool get isSpanish => _currentLocale.languageCode == 'es';
  bool get isEnglish => _currentLocale.languageCode == 'en';

  void setLocale(Locale locale) {
    if (_currentLocale != locale) {
      _currentLocale = locale;
      notifyListeners();
    }
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
}
