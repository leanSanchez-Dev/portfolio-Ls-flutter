// Smoke tests de la app. El portafolio no tiene contador: el test por defecto
// de Flutter que venía aquí (`find.byIcon(Icons.add)`) fallaba siempre.
//
// Estos tests corren en la VM de Dart, donde `dart:ui_web`/`package:web` no
// existen. Se apoyan en la fachada `lib/utils/web_embed/`, que en VM resuelve
// al stub y pinta un placeholder en vez de una platform view.

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_ls/components/projects.dart';
import 'package:portfolio_ls/data/datasources/projects_local_datasource.dart';
import 'package:portfolio_ls/data/repositories/projects_repository_impl.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:portfolio_ls/main.dart';
import 'package:portfolio_ls/portfolio.dart';
import 'package:portfolio_ls/providers/projects_provider.dart';
import 'package:portfolio_ls/utils/reveal_on_scroll.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('MyApp monta el portafolio y su barra superior',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    // Varias secciones arrancan sus animaciones con `Future.delayed`; hay que
    // dejarlas vencer o el binding reporta timers pendientes.
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));

    expect(find.byType(Portfolio), findsOneWidget);
    expect(find.text('Leonardo Sanchez'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  // El idioma por defecto es español, que tiene las etiquetas de nav más
  // largas: es el caso peor de ancho y el que se prueba aquí.
  testWidgets('en desktop ancho las siete secciones caben en línea',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));

    expect(find.widgetWithText(TextButton, 'Habilidades'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Música'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Contacto'), findsOneWidget);
    expect(find.byType(PopupMenuButton<VoidCallback>), findsNothing);
    expect(find.byType(EndDrawerButton), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('en desktop estrecho GitHub y Música pasan al menú de overflow',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1100, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));

    expect(find.widgetWithText(TextButton, 'Habilidades'), findsOneWidget);
    expect(find.widgetWithText(TextButton, 'Música'), findsNothing);

    await tester.tap(find.byType(PopupMenuButton<VoidCallback>));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 400));

    expect(find.text('Música'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('bajo 1024 el nav se sustituye por el botón del drawer',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(500, 3000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));

    expect(find.widgetWithText(TextButton, 'Habilidades'), findsNothing);
    expect(find.byType(EndDrawerButton), findsOneWidget);

    await tester.tap(find.byType(EndDrawerButton));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.widgetWithText(ListTile, 'Música'), findsOneWidget);
    expect(find.widgetWithText(ListTile, 'GitHub'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('el filtro por tecnología reconstruye la lista de proyectos',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1440, 2000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    addTearDown(tester.view.resetDevicePixelRatio);

    final provider = ProjectsProvider(
      const ProjectsRepositoryImpl(ProjectsLocalDataSource()),
    )..load();
    final tecnologia = provider.technologies.first;

    await tester.pumpWidget(
      ChangeNotifierProvider<ProjectsProvider>.value(
        value: provider,
        child: const MaterialApp(
          locale: Locale('es'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(child: Projects()),
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    await tester.pump(const Duration(seconds: 3));

    expect(find.byType(ChoiceChip), findsWidgets);
    expect(find.widgetWithText(ChoiceChip, 'Todos'), findsOneWidget);

    await tester.tap(find.widgetWithText(ChoiceChip, tecnologia));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(provider.selectedTechnology, tecnologia);
    expect(
      provider.filteredProjects.length,
      lessThanOrEqualTo(provider.projects.length),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('con reduced motion no se envuelve el contenido en Animate',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MediaQuery(
        data: MediaQueryData(disableAnimations: true),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: RevealAnimation(child: Text('contenido')),
        ),
      ),
    );

    expect(find.text('contenido'), findsOneWidget);
    expect(find.byType(Animate), findsNothing);
  });
}
