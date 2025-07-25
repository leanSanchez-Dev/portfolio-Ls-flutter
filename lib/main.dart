import 'package:flutter/material.dart';
import 'package:portfolio_ls/portfolio.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Leonardo Sanchez - Portfolio',
            theme: themeProvider.themeData,
            debugShowCheckedModeBanner: false,
            home: const Portfolio(),
          );
        },
      ),
    );
  }
}
