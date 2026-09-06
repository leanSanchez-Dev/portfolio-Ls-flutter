import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/domain/config/external_integrations.dart';
import 'package:portfolio_ls/models/projects.dart';
import 'package:portfolio_ls/providers/projects_provider.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/utils/image_loader.dart' as image_loader;
import 'package:portfolio_ls/utils/reveal_on_scroll.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with TickerProviderStateMixin {
  final CarouselSliderController _controller = CarouselSliderController();
  late AnimationController _headerController;
  late AnimationController _carouselController;

  /// Última lista filtrada vista en `build`, para detectar cambios de filtro.
  List<Project>? _lastFiltered;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _carouselController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
  }

  /// La sección está muy por debajo del fold: ni animación ni precarga de
  /// imágenes ocurren hasta que entra en el viewport.
  void _onRevealed() {
    _preloadImages();

    if (prefersReducedMotion(context)) {
      _headerController.value = 1;
      _carouselController.value = 1;
      return;
    }

    _headerController.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _carouselController.forward();
      }
    });
  }

  Future<void> _preloadImages() async {
    final projects = _lastFiltered ?? const <Project>[];
    final imagePaths = projects.map((project) => project.url).toList();
    if (!mounted || imagePaths.isEmpty) return;
    await image_loader.ImagePreloader.preloadImages(imagePaths, context);
  }

  @override
  void dispose() {
    _headerController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  /// Al cambiar el filtro la lista se acorta y `currentIndex` puede quedar
  /// fuera de rango, así que se resetea el índice y se lleva el carrusel a la
  /// primera posición.
  void _syncWithFilter(List<Project> filtered) {
    if (identical(filtered, _lastFiltered)) return;
    final isFirstBuild = _lastFiltered == null;
    _lastFiltered = filtered;
    currentIndex = 0;
    if (isFirstBuild || filtered.isEmpty) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _controller.jumpToPage(0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final projects = context
        .select<ProjectsProvider, List<Project>>((p) => p.filteredProjects);
    final isEmptyResult =
        context.select<ProjectsProvider, bool>((p) => p.isEmptyResult);
    // Los `select` viven aquí, en el `build` de este State: dentro del
    // `builder` de RevealOnScroll ya sería otro elemento en construcción.
    final technologies =
        context.select<ProjectsProvider, List<String>>((p) => p.technologies);
    final selected =
        context.select<ProjectsProvider, String?>((p) => p.selectedTechnology);
    _syncWithFilter(projects);

    return RevealOnScroll(
      onRevealed: _onRevealed,
      builder: (context, _) => Container(
        margin: const EdgeInsets.symmetric(vertical: 40),
        width: double.infinity,
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildFilterChips(technologies, selected),
            const SizedBox(height: 24),
            if (isEmptyResult)
              _buildEmptyState()
            else ...[
              _buildProjectsCarousel(projects),
              const SizedBox(height: 32),
              _buildIndicators(projects),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips(List<String> technologies, String? selected) {
    final l10n = AppLocalizations.of(context)!;
    if (technologies.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Text(
            l10n.projectsFilterLabel,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.getTextSecondary(context),
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildChoiceChip(
                label: l10n.filterAll,
                value: null,
                isSelected: selected == null,
              ),
              for (final tecnologia in technologies)
                _buildChoiceChip(
                  label: tecnologia,
                  value: tecnologia,
                  isSelected: selected == tecnologia,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChoiceChip({
    required String label,
    required String? value,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      showCheckmark: false,
      // El estado de selección no se transmite solo por color: `ChoiceChip`
      // expone `selected` en semántica y además cambia el peso tipográfico.
      labelStyle: theme.textTheme.bodyMedium?.copyWith(
        color: isSelected ? Colors.white : AppColors.getChipText(context),
        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
      ),
      backgroundColor: AppColors.getChipBackground(context),
      selectedColor: theme.primaryColor,
      side: BorderSide(
        color: isSelected
            ? theme.primaryColor
            : AppColors.getBorderStrong(context),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      onSelected: (_) =>
          context.read<ProjectsProvider>().selectTechnology(value),
    );
  }

  Widget _buildEmptyState() {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        children: [
          Icon(
            FontAwesomeIcons.folderOpen,
            size: 28,
            color: AppColors.getTextSecondary(context),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noProjectsForFilter,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.getTextSecondary(context),
                ),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => context.read<ProjectsProvider>().clearFilter(),
            child: Text(l10n.clearFilter),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.3),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _headerController,
            curve: Curves.easeOut,
          )),
          child: FadeTransition(
            opacity: _headerController,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        FontAwesomeIcons.folderOpen,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      AppLocalizations.of(context)!.featuredProjects,
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.featuredProjectsDescription,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Container(
                  height: 1,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).primaryColor.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectsCarousel(List<Project> projects) {
    return AnimatedBuilder(
      animation: _carouselController,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: _carouselController,
              curve: Curves.easeOut,
            ),
          ),
          child: FadeTransition(
            opacity: _carouselController,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: projects.length,
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.6,
                      aspectRatio: 16 / 9,
                      // Con un solo resultado el autoplay solo provocaría
                      // saltos innecesarios (y pelearía con el reseteo de
                      // índice al filtrar).
                      autoPlay: projects.length > 1,
                      autoPlayInterval: const Duration(seconds: 5),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction:
                          MediaQuery.of(context).size.width < 900 ? 0.85 : 0.7,
                      onPageChanged: (index, reason) {
                        if (!mounted || index == currentIndex) return;
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return _buildProjectCard(projects[index], index);
                    },
                  ),

                  // Navigation arrows
                  if (MediaQuery.of(context).size.width > 900) ...[
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedHoverContainer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: Theme.of(context).primaryColor,
                              ),
                              tooltip:
                                  AppLocalizations.of(context)!.previousProject,
                              onPressed: () => _controller.previousPage(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedHoverContainer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.chevronRight,
                                color: Theme.of(context).primaryColor,
                              ),
                              tooltip:
                                  AppLocalizations.of(context)!.nextProject,
                              onPressed: () => _controller.nextPage(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    return AnimatedHoverContainer(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Stack(
            children: [
              // Project image con optimización de carga
              image_loader.OptimizedImageLoader(
                imageUrl: project.url,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 800),
                useShimmer: true,
                errorWidget: Container(
                  color: Theme.of(context).cardColor,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            FontAwesomeIcons.triangleExclamation,
                            color: Colors.red,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No se pudo cargar la imagen del proyecto',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  project.tag == 'Flutter'
                                      ? FontAwesomeIcons.mobileScreen
                                      : FontAwesomeIcons.code,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  project.tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          AnimatedHoverContainer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                tooltip:
                                    AppLocalizations.of(context)!.viewOnGitHub,
                                onPressed: () => _launchGitHub(),
                                iconSize: 16,
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        project.project,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.building,
                            color: Colors.white.withOpacity(0.8),
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project.empresa,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators(List<Project> projects) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: projects.asMap().entries.map((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentIndex == entry.key ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentIndex == entry.key
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.3),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _launchGitHub() async {
    // La URL sale de la config de dominio, no se compone en el widget.
    await launchUrl(
      GitHubStatsConfig.profileUri,
      webOnlyWindowName: '_blank',
    );
  }
}
