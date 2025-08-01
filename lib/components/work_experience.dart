import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_ls/providers/language_provider.dart';

import '../models/experience.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience>
    with TickerProviderStateMixin {
  late AnimationController _headerController;
  late AnimationController _timelineController;

  List<Experience> experiencias =
      jsonStr.map((item) => Experience.fromJson(item)).toList();

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _timelineController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    if (mounted) {
      _headerController.forward();
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _timelineController.forward();
      }
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _timelineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width < 900
            ? MediaQuery.of(context).size.width * 0.95
            : MediaQuery.of(context).size.width < 1600
                ? 700
                : 800,
      ),
      child: AnimatedFadeSlide(
        child: Card(
          elevation: 0,
          color: AppColors.getCardBackground(context),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: BorderSide(
              color: AppColors.getBorder(context),
              width: 1,
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 32),
                _buildTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(-0.3, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _headerController,
            curve: Curves.easeOut,
          )),
          child: FadeTransition(
            opacity: _headerController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.getIconBackground(context),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        FontAwesomeIcons.briefcase,
                        color: AppColors.getIconColor(context),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.workExperienceTitle,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          Text(
                            '${experiencias.length} positions',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withOpacity(0.6),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  height: 1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.3),
                        Theme.of(context).primaryColor.withOpacity(0.1),
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

  Widget _buildTimeline() {
    return AnimatedBuilder(
      animation: _timelineController,
      builder: (context, child) {
        return Column(
          children: [
            for (int i = 0; i < experiencias.length; i++)
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.3, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _timelineController,
                  curve: Interval(
                    i * 0.1,
                    (i * 0.1) + 0.3,
                    curve: Curves.easeOut,
                  ),
                )),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0, end: 1).animate(
                    CurvedAnimation(
                      parent: _timelineController,
                      curve: Interval(
                        i * 0.1,
                        (i * 0.1) + 0.3,
                        curve: Curves.easeOut,
                      ),
                    ),
                  ),
                  child: _buildExperienceCard(experiencias[i], i == 0),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildExperienceCard(Experience experience, bool isFirst) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isFirst
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).brightness == Brightness.dark
                          ? AppColors.darkChipBackground
                          : Theme.of(context).primaryColor.withOpacity(0.3),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).primaryColor,
                    width: isFirst ? 3 : 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: isFirst
                    ? Icon(
                        FontAwesomeIcons.star,
                        size: 8,
                        color: Colors.white,
                      )
                    : null,
              ),
              if (experience != experiencias.last)
                Container(
                  width: 3,
                  height: 120,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: Theme.of(context).brightness == Brightness.dark
                          ? [
                              Theme.of(context).primaryColor.withOpacity(0.6),
                              Theme.of(context).primaryColor.withOpacity(0.2),
                            ]
                          : [
                              Theme.of(context).primaryColor.withOpacity(0.3),
                              Theme.of(context).primaryColor.withOpacity(0.1),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),

          // Experience content
          Expanded(
            child: AnimatedHoverContainer(
              hoverScale: 1.02,
              hoverElevation: 15,
              hoverShadowColor: Theme.of(context).primaryColor,
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: Theme.of(context).brightness == Brightness.dark
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.darkCardBackground,
                            AppColors.darkCardBackground.withOpacity(0.8),
                          ],
                        )
                      : null,
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.getCardBackground(context)
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? AppColors.darkBorderLight.withOpacity(0.3)
                        : AppColors.getBorder(context),
                    width: Theme.of(context).brightness == Brightness.dark ? 1.5 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.black.withOpacity(0.4)
                          : Theme.of(context).shadowColor.withOpacity(0.05),
                      blurRadius: Theme.of(context).brightness == Brightness.dark ? 15 : 10,
                      spreadRadius: Theme.of(context).brightness == Brightness.dark ? 2 : 0,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            experience.getLocalizedCargo(Provider.of<LanguageProvider>(context).currentLocale),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        if (isFirst)
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).primaryColor.withOpacity(0.8),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              AppLocalizations.of(context)!.current,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.building,
                          size: 14,
                          color: Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          experience.empresa,
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.calendar,
                          size: 12,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${experience.getLocalizedFechaInicio(Provider.of<LanguageProvider>(context).currentLocale)} - ${experience.getLocalizedFechaFin(Provider.of<LanguageProvider>(context).currentLocale)}',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.6),
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      experience.getLocalizedDescripcion(Provider.of<LanguageProvider>(context).currentLocale),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                          ),
                    ),
                    
                    // Proyectos específicos
                    if (experience.getLocalizedProyectos(Provider.of<LanguageProvider>(context).currentLocale) != null && experience.getLocalizedProyectos(Provider.of<LanguageProvider>(context).currentLocale)!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.projectsLabel,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      ...experience.getLocalizedProyectos(Provider.of<LanguageProvider>(context).currentLocale)!.map((proyecto) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                proyecto,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      height: 1.4,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                    
                    // Responsabilidades
                    if (experience.getLocalizedResponsabilidades(Provider.of<LanguageProvider>(context).currentLocale) != null && experience.getLocalizedResponsabilidades(Provider.of<LanguageProvider>(context).currentLocale)!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      Text(
                        AppLocalizations.of(context)!.responsibilitiesLabel,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      const SizedBox(height: 8),
                      ...experience.getLocalizedResponsabilidades(Provider.of<LanguageProvider>(context).currentLocale)!.map((responsabilidad) => Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                responsabilidad,
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      height: 1.4,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface
                                          .withOpacity(0.7),
                                    ),
                              ),
                            ),
                          ],
                        ),
                      )),
                    ],
                    
                    // Tecnologías
                    if (experience.tecnologias != null && experience.tecnologias!.isNotEmpty) ...[
                      const SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context)!.technologiesLabel,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? AppColors.darkTextPrimary
                                  : Theme.of(context).primaryColor,
                              fontSize: 14,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: experience.tecnologias!.map((tech) => AnimatedHoverContainer(
                          hoverScale: 1.05,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              gradient: Theme.of(context).brightness == Brightness.dark
                                  ? LinearGradient(
                                      colors: [
                                        AppColors.darkChipBackground,
                                        AppColors.darkChipBackground.withOpacity(0.8),
                                      ],
                                    )
                                  : null,
                              color: Theme.of(context).brightness == Brightness.light
                                  ? AppColors.getChipBackground(context)
                                  : null,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? AppColors.darkBorderLight.withOpacity(0.5)
                                    : AppColors.getBorderStrong(context),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? Colors.black.withOpacity(0.3)
                                      : Theme.of(context).shadowColor.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Text(
                              tech,
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: AppColors.getChipText(context),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                        )).toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
