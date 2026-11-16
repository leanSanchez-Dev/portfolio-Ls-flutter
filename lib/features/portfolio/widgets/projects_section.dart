import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/constants/breakpoints.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/core/utils/scroll_anchor_helper.dart';
import 'package:portfolio_ls/domain/models/portfolio_bento.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_card.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_section_header.dart';
import 'package:portfolio_ls/features/portfolio/widgets/case_study_dialog.dart';
import 'package:portfolio_ls/features/portfolio/widgets/mockups/angular_enterprise_preview.dart';
import 'package:portfolio_ls/features/portfolio/widgets/mockups/flutter_suite_preview.dart';
import 'package:portfolio_ls/features/portfolio/widgets/mockups/fundacer_pwa_preview.dart';
import 'package:portfolio_ls/features/portfolio/widgets/mockups/smart_tv_launcher_preview.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/utils/reveal_on_scroll.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:provider/provider.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bento = context.watch<PortfolioBentoProvider>();
    final language = context.watch<LanguageProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final width = MediaQuery.sizeOf(context).width;
    final twoCols = width >= Breakpoints.mobile;

    final filters = <(BentoProjectFilter, String)>[
      (BentoProjectFilter.all, copy.projectsFilterAll.resolveCode(lang)),
      (
        BentoProjectFilter.fullstack,
        lang == 'en' ? 'Full-Stack' : 'Full-Stack',
      ),
      (BentoProjectFilter.mobile, 'Mobile'),
      (
        BentoProjectFilter.ui,
        lang == 'en' ? 'UI / Architecture' : 'UI / Arquitectura',
      ),
    ];

    return KeyedSubtree(
      key: ScrollAnchorHelper.projectsKey,
      child: BentoContentConstraints(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BentoSectionHeader(
                eyebrow: copy.projectsEyebrow.resolveCode(lang),
                title: copy.projectsTitle.resolveCode(lang),
                subtitle: copy.projectsSubtitle.resolveCode(lang),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in filters)
                    _ProjectFilterPill(
                      label: entry.$2,
                      selected: bento.projectFilter == entry.$1,
                      onTap: () => context
                          .read<PortfolioBentoProvider>()
                          .setProjectFilter(entry.$1),
                    ),
                ],
              ),
              const SizedBox(height: 24),
              LayoutBuilder(
                builder: (context, constraints) {
                  final projects = bento.filteredProjects;
                  if (!twoCols) {
                    return Column(
                      children: [
                        for (var i = 0; i < projects.length; i++) ...[
                          if (i > 0) const SizedBox(height: 18),
                          _ProjectCard(
                            key: ValueKey(projects[i].id),
                            project: projects[i],
                            caseLabel: copy.projectsCaseStudy.resolveCode(lang),
                            lang: lang,
                          ),
                        ],
                      ],
                    );
                  }
                  final rows = <Widget>[];
                  for (var i = 0; i < projects.length; i += 2) {
                    final left = projects[i];
                    final right =
                        i + 1 < projects.length ? projects[i + 1] : null;
                    rows.add(
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _ProjectCard(
                              key: ValueKey(left.id),
                              project: left,
                              caseLabel:
                                  copy.projectsCaseStudy.resolveCode(lang),
                              lang: lang,
                            ),
                          ),
                          const SizedBox(width: 18),
                          Expanded(
                            child: right == null
                                ? const SizedBox.shrink()
                                : _ProjectCard(
                                    key: ValueKey(right.id),
                                    project: right,
                                    caseLabel:
                                        copy.projectsCaseStudy.resolveCode(lang),
                                    lang: lang,
                                  ),
                          ),
                        ],
                      ),
                    );
                    if (i + 2 < projects.length) {
                      rows.add(const SizedBox(height: 18));
                    }
                  }
                  return Column(children: rows);
                },
              ),
              if (bento.filteredProjects.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    '—',
                    style: TextStyle(color: colors.textSecondary),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectFilterPill extends StatelessWidget {
  const _ProjectFilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Semantics(
      button: true,
      selected: selected,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              color: selected ? colors.accentPrimary : colors.bgSurface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: selected ? colors.accentPrimary : colors.borderSubtle,
              ),
            ),
            child: Text(
              label,
              style: AppFonts.mono(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: selected ? Colors.white : colors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    super.key,
    required this.project,
    required this.caseLabel,
    required this.lang,
  });

  final ProjectItem project;
  final String caseLabel;
  final String lang;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return BentoCard(
      onTap: () => openCaseStudyDialog(context, project: project),
      clipBehavior: Clip.antiAlias,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(23)),
            child: _mockupFor(context, project),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.categoryLabel,
                        style: AppFonts.mono(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colors.accentSecondary,
                        ),
                      ),
                    ),
                    Text(
                      project.yearLabel,
                      style: AppFonts.mono(
                        fontSize: 11,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
                if (project.company != null && project.company!.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    project.company!,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: colors.accentPrimary,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Text(
                  project.description.resolveCode(lang),
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 18),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final tag in project.cardTags)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 9,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: colors.bgCanvas,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            tag,
                            style: AppFonts.mono(
                              fontSize: 10,
                              color: colors.textSecondary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$caseLabel →',
                  style: AppFonts.mono(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: colors.accentPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _mockupFor(BuildContext context, ProjectItem project) {
    final asset = project.imageAsset;
    const placeholder = ColoredBox(color: Color(0xFF1A1B26));
    if (asset != null && asset.isNotEmpty) {
      final reduceMotion = MediaQuery.disableAnimationsOf(context);
      return AspectRatio(
        aspectRatio: 16 / 10,
        child: RepaintBoundary(
          child: RevealOnScroll(
            key: ValueKey(asset),
            builder: (context, revealed) {
              if (!revealed) return placeholder;
              return LayoutBuilder(
                builder: (context, constraints) {
                  final dpr = MediaQuery.devicePixelRatioOf(context);
                  final cacheWidth =
                      (constraints.maxWidth * dpr).round().clamp(1, 2048);
                  // Only cacheWidth with BoxFit.cover — paired cacheHeight
                  // would force decode aspect and distort cover crops.
                  return Image.asset(
                    asset,
                    key: ValueKey(asset),
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                    cacheWidth: cacheWidth,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                      if (wasSynchronouslyLoaded || reduceMotion) {
                        return child;
                      }
                      return AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOut,
                        child: child,
                      );
                    },
                    errorBuilder: (_, __, ___) => placeholder,
                  );
                },
              );
            },
          ),
        ),
      );
    }
    return RevealOnScroll(
      key: ValueKey(project.id),
      builder: (context, revealed) {
        if (!revealed) {
          return const AspectRatio(
            aspectRatio: 16 / 10,
            child: placeholder,
          );
        }
        return RepaintBoundary(child: _builtInMockup(project));
      },
    );
  }

  Widget _builtInMockup(ProjectItem project) {
    switch (project.id) {
      case BentoProjectId.fundacer:
        return const FundacerPwaPreview();
      case BentoProjectId.quipuxCobro:
      case BentoProjectId.fisioterapp:
      case BentoProjectId.angular:
        return const AngularEnterprisePreview();
      case BentoProjectId.flutter:
        return const FlutterSuitePreview();
      case BentoProjectId.smarttv:
        return const SmartTvLauncherPreview();
      case BentoProjectId.bodecom:
      case BentoProjectId.navipuntos:
      case BentoProjectId.neat:
      case BentoProjectId.adomiPedidos:
      case BentoProjectId.adomiAliados:
      case BentoProjectId.gesport:
      case BentoProjectId.portfolio:
        return const AspectRatio(
          aspectRatio: 16 / 10,
          child: ColoredBox(color: Color(0xFF1A1B26)),
        );
    }
  }
}
