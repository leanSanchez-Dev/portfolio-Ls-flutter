import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:portfolio_ls/portfolio.dart';
// import 'package:portfolio_ls/providers/theme_provider.dart';
// import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ThemeData darkMode;
  final darkThemeStr =
      await rootBundle.loadString('assets/appainter_theme_blue.json');
  final darkThemeJson = jsonDecode(darkThemeStr);
  darkMode = ThemeDecoder.decodeThemeData(darkThemeJson)!;

  runApp(MyApp(
    themeData: darkMode,
  ));
}

class MyApp extends StatelessWidget {
  final ThemeData? themeData;
  const MyApp({
    super.key,
    this.themeData,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portfolio LS',
      theme: themeData,
      home: const Portfolio(),
    );
  }
}
