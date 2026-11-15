import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/components/about.dart';
import 'package:portfolio_ls/components/banner.dart';
import 'package:portfolio_ls/components/projects.dart';
import 'package:portfolio_ls/components/work_experience.dart';
import 'package:portfolio_ls/components/footer.dart';
import 'package:portfolio_ls/components/skills.dart';
import 'package:portfolio_ls/components/cv_section.dart';
import 'package:portfolio_ls/components/github_stats.dart';
import 'package:portfolio_ls/components/music_section.dart';
import 'package:portfolio_ls/components/language_selector.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  /// Ancho a partir del cual se muestra el nav horizontal en lugar del drawer.
  ///
  /// Coincide con el breakpoint `desktop` de la rule del repo (`>= 1024`). El
  /// valor anterior (800) dejaba la banda tablet 800–1023 con el nav completo,
  /// donde las etiquetas en español ya no caben junto al título, el selector de
  /// idioma y el toggle de tema.
  static const double _desktopNavBreakpoint = 1024;

  /// Ancho a partir del cual caben las siete secciones en línea. Entre 1024 y
  /// este valor, GitHub y Música viven en un menú de overflow.
  ///
  /// `actions` de `AppBar` se dispone con `NavigationToolbar`, que da al slot
  /// trailing su ancho intrínseco sin acotarlo: `Wrap`, `Expanded` o un scroll
  /// horizontal ahí dentro no tienen restricción de la que colgar. Por eso el
  /// nav se escalona por breakpoint en vez de intentar fluir.
  static const double _fullNavBreakpoint = 1280;

  final ScrollController _scrollController = ScrollController();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey workExpKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey githubKey = GlobalKey();
  final GlobalKey cvKey = GlobalKey();
  final GlobalKey musicKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final showDesktopNav = width >= _desktopNavBreakpoint;

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Modern App Bar
              SliverAppBar(
                expandedHeight: 80.0,
                floating: true,
                pinned: true,
                snap: false,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: Border(
                        bottom: BorderSide(
                          color:
                              Theme.of(context).dividerColor.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ),
                title: AnimatedFadeSlide(
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'LS',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Leonardo Sanchez',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  if (showDesktopNav)
                    ..._buildDesktopNavigation(
                      showAllInline: width >= _fullNavBreakpoint,
                    ),
                  const LanguageSelector(),
                  const SizedBox(width: 12),
                  _buildThemeToggle(),
                  // `AppBar` solo inyecta el botón del endDrawer cuando
                  // `actions` está vacío, y aquí nunca lo está: sin este botón
                  // el drawer quedaba inalcanzable en móvil y tablet.
                  if (!showDesktopNav) const EndDrawerButton(),
                  const SizedBox(width: 16),
                ],
              ),

              // Portfolio Content
              ..._buildSectionSlivers(),
            ],
          ),
        ],
      ),

      // Mobile Navigation Drawer
      endDrawer: showDesktopNav ? null : _buildMobileDrawer(),
    );
  }

  /// Secciones del portafolio, **una por sliver**.
  ///
  /// Antes vivían todas dentro de un único `SliverList`, y eso era el origen
  /// de los errores de consola: `SliverList` recicla: destruye el elemento de
  /// cada hijo que sale del viewport (+`cacheExtent`) y lo reconstruye desde
  /// cero al volver. Con secciones de pantalla completa eso pasa en cada
  /// pasada de scroll, y cada recreación de `State`:
  ///
  /// - remontaba el `<img>` de GitHub Stats → una petición nueva a
  ///   `github-readme-stats` por pasada, perdiendo el flag de "ya falló";
  /// - remontaba el `<iframe>` de Spotify → recarga completa del reproductor;
  /// - mataba `_ProjectsState` a mitad de la precarga de imágenes.
  ///
  /// Los slivers de un `CustomScrollView` **no** se reciclan: viven en el
  /// árbol mientras viva el scroll. El `RepaintBoundary` sustituye al que
  /// `SliverChildListDelegate` añadía a cada hijo, para que el autoplay del
  /// carrusel no repinte el resto de la página.
  List<Widget> _buildSectionSlivers() {
    final sections = <Widget>[
      const About(),
      Container(key: skillsKey, child: const Skills()),
      Container(key: workExpKey, child: const WorkExperience()),
      Container(key: projectsKey, child: const Projects()),
      // GitHub Stats va justo después de Proyectos: continúa la misma
      // narrativa (lo que construyo → mi actividad real).
      Container(key: githubKey, child: const GitHubStats()),
      Container(key: cvKey, child: const CVSection()),
      // Música cierra en personal antes del CTA: tras la evidencia técnica y
      // el CV, el toque humano.
      Container(key: musicKey, child: const MusicSection()),
      BannerInf(onViewProjects: () => _scrollToSection(projectsKey)),
      Container(key: contactKey, child: const Footer()),
    ];

    return [
      for (final section in sections)
        SliverToBoxAdapter(child: RepaintBoundary(child: section)),
    ];
  }

  List<Widget> _buildDesktopNavigation({required bool showAllInline}) {
    final l10n = AppLocalizations.of(context)!;
    return [
      _buildNavItem(l10n.skillsNav, () => _scrollToSection(skillsKey)),
      _buildNavItem(l10n.experienceNav, () => _scrollToSection(workExpKey)),
      _buildNavItem(l10n.projectsNav, () => _scrollToSection(projectsKey)),
      if (showAllInline)
        _buildNavItem(l10n.githubNav, () => _scrollToSection(githubKey)),
      _buildNavItem('CV', () => _scrollToSection(cvKey)),
      if (showAllInline)
        _buildNavItem(l10n.musicNav, () => _scrollToSection(musicKey)),
      _buildNavItem(l10n.contactNav, () => _scrollToSection(contactKey)),
      if (!showAllInline) _buildOverflowMenu(l10n),
    ];
  }

  /// Menú de overflow del nav desktop estrecho (1024–1279).
  ///
  /// Recoge las secciones que no caben en línea para que ninguna quede sin
  /// acceso desde el nav, como pasaba antes con GitHub Stats y Música.
  Widget _buildOverflowMenu(AppLocalizations l10n) {
    return PopupMenuButton<VoidCallback>(
      tooltip: l10n.moreNav,
      onSelected: (action) => action(),
      itemBuilder: (context) => [
        PopupMenuItem<VoidCallback>(
          value: () => _scrollToSection(githubKey),
          child: _buildOverflowMenuItem(
              FontAwesomeIcons.chartLine, l10n.githubNav),
        ),
        PopupMenuItem<VoidCallback>(
          value: () => _scrollToSection(musicKey),
          child: _buildOverflowMenuItem(
              FontAwesomeIcons.headphones, l10n.musicNav),
        ),
      ],
      icon: Icon(
        FontAwesomeIcons.ellipsis,
        size: 18,
        color: Theme.of(context).textTheme.bodyMedium?.color,
      ),
    );
  }

  Widget _buildOverflowMenuItem(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Text(label, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }

  Widget _buildNavItem(String title, VoidCallback onTap) {
    return AnimatedHoverContainer(
      child: TextButton(
        onPressed: onTap,
        child: Text(
          title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget _buildThemeToggle() {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return AnimatedHoverContainer(
          child: IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                themeProvider.isDarkMode
                    ? FontAwesomeIcons.sun
                    : FontAwesomeIcons.moon,
                key: ValueKey(themeProvider.isDarkMode),
                color: Theme.of(context).primaryColor,
              ),
            ),
            tooltip: themeProvider.isDarkMode
                ? AppLocalizations.of(context)!.switchToLightMode
                : AppLocalizations.of(context)!.switchToDarkMode,
          ),
        );
      },
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            // Drawer Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'LS',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Leonardo Sanchez',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // Navigation Items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildMobileNavItem(
                    AppLocalizations.of(context)!.skillsNav,
                    FontAwesomeIcons.code,
                    () => _scrollToSection(skillsKey),
                  ),
                  _buildMobileNavItem(
                    AppLocalizations.of(context)!.experienceNav,
                    FontAwesomeIcons.briefcase,
                    () => _scrollToSection(workExpKey),
                  ),
                  _buildMobileNavItem(
                    AppLocalizations.of(context)!.projectsNav,
                    FontAwesomeIcons.folderOpen,
                    () => _scrollToSection(projectsKey),
                  ),
                  _buildMobileNavItem(
                    AppLocalizations.of(context)!.githubNav,
                    FontAwesomeIcons.chartLine,
                    () => _scrollToSection(githubKey),
                  ),
                  _buildMobileNavItem(
                    'CV',
                    FontAwesomeIcons.fileText,
                    () => _scrollToSection(cvKey),
                  ),
                  _buildMobileNavItem(
                    AppLocalizations.of(context)!.musicNav,
                    FontAwesomeIcons.headphones,
                    () => _scrollToSection(musicKey),
                  ),
                  _buildMobileNavItem(
                    AppLocalizations.of(context)!.contactNav,
                    FontAwesomeIcons.envelope,
                    () => _scrollToSection(contactKey),
                  ),
                ],
              ),
            ),

            // Theme Toggle and Language Selector in Drawer
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Theme Toggle
                  Consumer<ThemeProvider>(
                    builder: (context, themeProvider, child) {
                      return ListTile(
                        leading: Icon(
                          themeProvider.isDarkMode
                              ? FontAwesomeIcons.sun
                              : FontAwesomeIcons.moon,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          themeProvider.isDarkMode
                              ? AppLocalizations.of(context)!.lightMode
                              : AppLocalizations.of(context)!.darkMode,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () {
                          themeProvider.toggleTheme();
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),

                  // Language Selector
                  Consumer<LanguageProvider>(
                    builder: (context, languageProvider, child) {
                      return ListTile(
                        leading: Icon(
                          FontAwesomeIcons.globe,
                          color: Theme.of(context).primaryColor,
                        ),
                        title: Text(
                          languageProvider.otherLanguageName,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        onTap: () {
                          languageProvider.toggleLanguage();
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      leading: Icon(
        icon,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      onTap: () {
        Navigator.pop(context);
        Future.delayed(const Duration(milliseconds: 200), onTap);
      },
    );
  }
}
