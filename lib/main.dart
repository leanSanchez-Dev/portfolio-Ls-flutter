import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:portfolio_ls/data/datasources/portfolio_bento_local_datasource.dart';
import 'package:portfolio_ls/data/datasources/projects_local_datasource.dart';
import 'package:portfolio_ls/data/repositories/portfolio_bento_repository_impl.dart';
import 'package:portfolio_ls/data/repositories/projects_repository_impl.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:portfolio_ls/features/portfolio/pages/portfolio_page.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/providers/projects_provider.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/utils/keyboard_handler.dart';
import 'package:portfolio_ls/utils/web_config.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeWebConfig();

  final themeProvider = ThemeProvider();
  final languageProvider = LanguageProvider();
  await Future.wait([
    themeProvider.init(),
    languageProvider.init(),
  ]);

  runApp(MyApp(
    themeProvider: themeProvider,
    languageProvider: languageProvider,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.themeProvider,
    required this.languageProvider,
  });

  final ThemeProvider themeProvider;
  final LanguageProvider languageProvider;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider<LanguageProvider>.value(value: languageProvider),
        ChangeNotifierProvider(
          create: (context) => ProjectsProvider(
            const ProjectsRepositoryImpl(ProjectsLocalDataSource()),
          )..load(),
        ),
        ChangeNotifierProvider(
          create: (context) => PortfolioBentoProvider(
            const PortfolioBentoRepositoryImpl(
              PortfolioBentoLocalDataSource(),
            ),
          )..load(),
        ),
      ],
      child: Consumer2<ThemeProvider, LanguageProvider>(
        builder: (context, themeProvider, languageProvider, child) {
          return MaterialApp(
            title: 'Leonardo Sanchez - Portfolio',
            theme: themeProvider.themeData,
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es'),
              Locale('en'),
            ],
            locale: languageProvider.currentLocale,
            home: const SafeKeyboardHandler(
              child: PortfolioPage(),
            ),
          );
        },
      ),
    );
  }
}
