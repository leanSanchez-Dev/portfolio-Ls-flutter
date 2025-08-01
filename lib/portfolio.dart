import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/components/about.dart';
import 'package:portfolio_ls/components/banner.dart';
import 'package:portfolio_ls/components/projects.dart';
import 'package:portfolio_ls/components/work_experience.dart';
import 'package:portfolio_ls/components/footer.dart';
import 'package:portfolio_ls/components/skills.dart';
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
  final ScrollController _scrollController = ScrollController();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey workExpKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
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
                          color: Theme.of(context).dividerColor.withOpacity(0.1),
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
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Leonardo Sanchez',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                actions: [
                  if (MediaQuery.of(context).size.width > 800)
                    ..._buildDesktopNavigation(),
                  const LanguageSelector(),
                  const SizedBox(width: 12),
                  _buildThemeToggle(),
                  const SizedBox(width: 16),
                ],
              ),

              // Portfolio Content
              SliverList(
                delegate: SliverChildListDelegate([
                  // About Section
                  const About(),

                  // Skills Section
                  Container(
                    key: skillsKey,
                    child: const Skills(),
                  ),

                  // Work Experience Section
                  Container(
                    key: workExpKey,
                    child: const WorkExperience(),
                  ),

                  // Projects Section
                  Container(
                    key: projectsKey,
                    child: const Projects(),
                  ),

                  // Banner CTA Section
                  const BannerInf(),

                  // Footer Section
                  Container(
                    key: contactKey,
                    child: const Footer(),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),

      // Mobile Navigation Drawer
      endDrawer: MediaQuery.of(context).size.width <= 800
          ? _buildMobileDrawer()
          : null,
    );
  }

  List<Widget> _buildDesktopNavigation() {
    return [
      _buildNavItem(AppLocalizations.of(context)!.skillsNav, () => _scrollToSection(skillsKey)),
      _buildNavItem(AppLocalizations.of(context)!.experienceNav, () => _scrollToSection(workExpKey)),
      _buildNavItem(AppLocalizations.of(context)!.projectsNav, () => _scrollToSection(projectsKey)),
      _buildNavItem(AppLocalizations.of(context)!.contactNav, () => _scrollToSection(contactKey)),
    ];
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
                          themeProvider.isDarkMode ? AppLocalizations.of(context)!.lightMode : AppLocalizations.of(context)!.darkMode,
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
