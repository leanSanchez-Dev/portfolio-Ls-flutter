import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/theme_data.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightTheme;
  bool _isDarkMode = false;

  ThemeData get themeData => _themeData;
  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _themeData = _isDarkMode ? darkTheme : lightTheme;
    notifyListeners();
  }

  void setLightTheme() {
    _themeData = lightTheme;
    _isDarkMode = false;
    notifyListeners();
  }

  void setDarkTheme() {
    _themeData = darkTheme;
    _isDarkMode = true;
    notifyListeners();
  }
}
