// import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:json_theme/json_theme.dart';

class ThemeProvider with ChangeNotifier {
  final ThemeData darkMode;
  ThemeProvider(this.darkMode);

  late ThemeData lightMode;

  late ThemeData _themeData = darkMode;

  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    if (_themeData == lightMode) {
      _themeData = darkMode;
    } else {
      // final themeStr =
      //     await rootBundle.loadString('assets/appainter_theme.json');
      // final themeJson = jsonDecode(themeStr);
      // lightMode = ThemeDecoder.decodeThemeData(themeJson)!;
      // _themeData = lightMode;
    }
    notifyListeners();
  }
}
