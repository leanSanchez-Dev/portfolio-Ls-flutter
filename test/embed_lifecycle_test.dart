// Tests de regresión del bug de peticiones en bucle a github-readme-stats.
//
// Causa raíz: las secciones eran hijas de un `SliverList`, que destruye el
// elemento de las que salen del viewport y lo recrea al volver. Cada
// recreación remontaba la platform view (petición nueva al servicio caído) y
// perdía el flag local de "ya falló".
//
// Aquí se fija el contrato en los dos niveles:
//
// 1. estructural — las secciones no se destruyen al hacer scroll;
// 2. de política — aunque se destruyeran, el presupuesto por URL tiene un tope
//    duro y un fallo lo agota.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_ls/components/github_stats.dart';
import 'package:portfolio_ls/components/music_section.dart';
import 'package:portfolio_ls/components/projects.dart';
import 'package:portfolio_ls/domain/config/external_integrations.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:portfolio_ls/main.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/utils/embed_load_budget.dart';
import 'package:portfolio_ls/utils/web_embed/web_embed.dart';
import 'package:provider/provider.dart';

void main() {
  setUp(EmbedLoadBudget.resetForTesting);
  tearDown(EmbedLoadBudget.resetForTesting);

  Future<void> pumpApp(WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));
  }

  ScrollPosition positionOf(WidgetTester tester) =>
      tester.state<ScrollableState>(find.byType(Scrollable).first).position;

  testWidgets('las secciones sobreviven al scroll sin recrear su State',
      (tester) async {
    await pumpApp(tester);

    // `skipOffstage: false`: un sliver fuera de pantalla sigue en el árbol
    // (que es justo lo que se quiere comprobar), pero el viewport lo declara
    // offstage y los finders por defecto lo ocultan.
    Finder probeFinder(Type type) => find.byType(type, skipOffstage: false);

    // Con `SliverList` las secciones de abajo no existían siquiera en el
    // primer viewport, y desaparecían del árbol al alejarse.
    final probes = <Type>[Projects, GitHubStats, MusicSection];
    final before = <Type, Element>{
      for (final probe in probes) probe: tester.element(probeFinder(probe)),
    };

    final position = positionOf(tester);
    for (var pass = 0; pass < 3; pass++) {
      position.jumpTo(position.maxScrollExtent);
      await tester.pump(const Duration(milliseconds: 100));
      position.jumpTo(0);
      await tester.pump(const Duration(milliseconds: 100));
    }

    for (final probe in probes) {
      expect(
        probeFinder(probe),
        findsOneWidget,
        reason: '$probe desapareció del árbol al hacer scroll',
      );
      expect(
        identical(tester.element(probeFinder(probe)), before[probe]),
        isTrue,
        reason: '$probe se recreó: su State y su platform view se remontaron',
      );
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('las tarjetas de GitHub no exceden el tope de intentos',
      (tester) async {
    await pumpApp(tester);

    final urls = <Uri>[
      GitHubStatsConfig.statsUri(isDarkMode: false),
      GitHubStatsConfig.topLanguagesUri(isDarkMode: false),
    ];

    final position = positionOf(tester);
    for (var pass = 0; pass < 4; pass++) {
      position.jumpTo(position.maxScrollExtent);
      await tester.pump(const Duration(milliseconds: 100));
      position.jumpTo(0);
      await tester.pump(const Duration(milliseconds: 100));
    }

    for (final url in urls) {
      expect(
        EmbedLoadBudget.attemptsFor(url),
        lessThanOrEqualTo(EmbedLoadBudget.maxAttempts),
        reason: 'la URL se pidió más veces que el tope duro: $url',
      );
      // El arreglo estructural debe dejarlo en exactamente un montaje.
      expect(EmbedLoadBudget.attemptsFor(url), 1);
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('una URL con presupuesto agotado no monta la platform view',
      (tester) async {
    final url = GitHubStatsConfig.statsUri(isDarkMode: false);
    EmbedLoadBudget.recordFailure(url);

    tester.view.physicalSize = const Size(1440, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: const MaterialApp(
          locale: Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(child: GitHubStats()),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));

    // La tarjeta de estadísticas arranca en fallback; la de lenguajes, que
    // conserva presupuesto, sí monta su embed.
    expect(find.byType(HtmlImageEmbed), findsOneWidget);
    expect(find.byIcon(Icons.insert_chart_outlined), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  group('EmbedLoadBudget', () {
    final url = Uri.https('example.test', '/card');

    test('un fallo agota el presupuesto para siempre', () {
      expect(EmbedLoadBudget.canAttempt(url), isTrue);
      EmbedLoadBudget.recordAttempt(url);
      EmbedLoadBudget.recordFailure(url);

      expect(EmbedLoadBudget.canAttempt(url), isFalse);
      expect(EmbedLoadBudget.hasFailed(url), isTrue);
      // Ni un `recordSuccess` posterior lo reabre: el 503 es definitivo para
      // la sesión.
      EmbedLoadBudget.recordSuccess(url);
      expect(EmbedLoadBudget.canAttempt(url), isFalse);
    });

    test('el tope de intentos es duro sin necesidad de un fallo explícito', () {
      for (var i = 0; i < EmbedLoadBudget.maxAttempts; i++) {
        expect(EmbedLoadBudget.canAttempt(url), isTrue);
        EmbedLoadBudget.recordAttempt(url);
      }
      expect(EmbedLoadBudget.canAttempt(url), isFalse);

      // Aunque algo siguiera insistiendo, el presupuesto no se reabre.
      for (var i = 0; i < 20; i++) {
        expect(EmbedLoadBudget.canAttempt(url), isFalse);
      }
    });

    test('una carga correcta permite remontar sin consumir presupuesto', () {
      EmbedLoadBudget.recordAttempt(url);
      EmbedLoadBudget.recordSuccess(url);
      for (var i = 0; i < 20; i++) {
        expect(EmbedLoadBudget.canAttempt(url), isTrue);
      }
    });

    test('cada URL lleva su propio presupuesto', () {
      final other = Uri.https('example.test', '/other');
      EmbedLoadBudget.recordFailure(url);
      expect(EmbedLoadBudget.canAttempt(url), isFalse);
      expect(EmbedLoadBudget.canAttempt(other), isTrue);
    });
  });
}
