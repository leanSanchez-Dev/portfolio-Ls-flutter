import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio_ls/portfolio.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/utils/keyboard_handler.dart';
import 'package:portfolio_ls/utils/web_config.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';

void main() {
  // Inicializar configuraciones para web
  initializeWebConfig();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'Leonardo Sanchez - Portfolio',
            theme: themeProvider.themeData,
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            
            // Configuración de localización
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es'), // Español
              Locale('en'), // Inglés
            ],
            locale: languageProvider.currentLocale,
            
            home: const SafeKeyboardHandler(
              child: Portfolio(),
            ),
          );
        },
      ),
    );
  }
}
