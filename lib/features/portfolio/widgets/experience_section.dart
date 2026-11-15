import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/constants/breakpoints.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/core/utils/scroll_anchor_helper.dart';
import 'package:portfolio_ls/domain/models/portfolio_bento.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_card.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_section_header.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:provider/provider.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bento = context.watch<PortfolioBentoProvider>();
    final language = context.watch<LanguageProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final desktop = Breakpoints.isDesktop(MediaQuery.sizeOf(context).width);
    final experiences = bento.experiences;

    final header = BentoSectionHeader(
      eyebrow: copy.expEyebrow.resolveCode(lang),
      title: copy.expTitle.resolveCode(lang),
      subtitle: copy.expSubtitle.resolveCode(lang),
    );

    final cards = Column(
      children: [
        for (var i = 0; i < experiences.length; i++) ...[
          if (i > 0) const SizedBox(height: 14),
          _ExperienceCard(item: experiences[i], lang: lang),
        ],
      ],
    );

    return KeyedSubtree(
      key: ScrollAnchorHelper.experienceKey,
      child: BentoContentConstraints(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: header),
                    const SizedBox(width: 28),
                    Expanded(flex: 8, child: cards),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    header,
                    const SizedBox(height: 24),
                    cards,
                  ],
                ),
        ),
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({required this.item, required this.lang});

  final ExperienceItem item;
  final String lang;

  static const int _maxVisibleResponsibilities = 4;

  List<LocalizedText> get _visibleResponsibilities {
    final all = item.responsibilities;
    if (all.length <= 5) return all;
    return all.take(_maxVisibleResponsibilities).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final role = item.role.resolveCode(lang);
    final period = item.period.resolveCode(lang);
    final description = item.description.resolveCode(lang).trim();
    final responsibilities = _visibleResponsibilities;
    final hasEngagements = item.engagements.isNotEmpty;
    final currentLabel = lang == 'en' ? 'Current' : 'Actual';

    return BentoCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Semantics(
                      header: true,
                      child: Text(
                        role,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: colors.textPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.company,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: colors.accentPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: item.isCurrent
                          ? colors.accentSecondary.withValues(alpha: 0.12)
                          : colors.bgCanvas,
                      borderRadius: BorderRadius.circular(999),
                      border: item.isCurrent
                          ? Border.all(
                              color: colors.accentSecondary
                                  .withValues(alpha: 0.25),
                            )
                          : null,
                    ),
                    child: Text(
                      period,
                      style: AppFonts.mono(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: item.isCurrent
                            ? colors.accentSecondary
                            : colors.textSecondary,
                      ),
                    ),
                  ),
                  if (item.isCurrent) ...[
                    const SizedBox(height: 6),
                    _StatusChip(
                      label: currentLabel,
                      colors: colors,
                      emphasized: true,
                    ),
                  ],
                ],
              ),
            ],
          ),
          if (description.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: colors.textSecondary,
              ),
            ),
          ],
          if (!hasEngagements) ...[
            if (item.technologies.isNotEmpty) ...[
              const SizedBox(height: 14),
              _TechChips(technologies: item.technologies, colors: colors),
            ],
            if (responsibilities.isNotEmpty) ...[
              const SizedBox(height: 14),
              _ResponsibilityList(
                items: responsibilities,
                lang: lang,
                colors: colors,
              ),
            ],
          ] else ...[
            if (item.technologies.isNotEmpty) ...[
              const SizedBox(height: 14),
              _TechChips(technologies: item.technologies, colors: colors),
            ],
            if (responsibilities.isNotEmpty) ...[
              const SizedBox(height: 14),
              _ResponsibilityList(
                items: responsibilities,
                lang: lang,
                colors: colors,
              ),
            ],
            const SizedBox(height: 16),
            for (var i = 0; i < item.engagements.length; i++) ...[
              if (i > 0) const SizedBox(height: 10),
              _EngagementPanel(
                engagement: item.engagements[i],
                lang: lang,
                currentLabel: currentLabel,
              ),
            ],
          ],
        ],
      ),
    );
  }
}

class _EngagementPanel extends StatelessWidget {
  const _EngagementPanel({
    required this.engagement,
    required this.lang,
    required this.currentLabel,
  });

  final ExperienceEngagement engagement;
  final String lang;
  final String currentLabel;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final title = engagement.title.resolveCode(lang);
    final period = engagement.period?.resolveCode(lang);
    final description = engagement.description.resolveCode(lang).trim();
    final active = engagement.isActive;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: active
            ? colors.accentSecondary.withValues(alpha: 0.06)
            : colors.bgCanvas,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: active
              ? colors.accentSecondary.withValues(alpha: 0.35)
              : colors.borderSubtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colors.textPrimary,
                  ),
                ),
              ),
              if (active) ...[
                const SizedBox(width: 8),
                _StatusChip(
                  label: currentLabel,
                  colors: colors,
                  emphasized: true,
                ),
              ],
            ],
          ),
          if (period != null && period.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              period,
              style: AppFonts.mono(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: active ? colors.accentSecondary : colors.textSecondary,
              ),
            ),
          ],
          if (description.isNotEmpty) ...[
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: colors.textSecondary,
              ),
            ),
          ],
          if (engagement.technologies.isNotEmpty) ...[
            const SizedBox(height: 12),
            _TechChips(technologies: engagement.technologies, colors: colors),
          ],
          if (engagement.responsibilities.isNotEmpty) ...[
            const SizedBox(height: 12),
            _ResponsibilityList(
              items: engagement.responsibilities,
              lang: lang,
              colors: colors,
            ),
          ],
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.colors,
    required this.emphasized,
  });

  final String label;
  final AppColorsExtension colors;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: emphasized
            ? colors.accentSecondary.withValues(alpha: 0.12)
            : colors.bgCanvas,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.accentSecondary.withValues(alpha: 0.25),
        ),
      ),
      child: Text(
        label,
        style: AppFonts.mono(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: colors.accentSecondary,
        ),
      ),
    );
  }
}

class _TechChips extends StatelessWidget {
  const _TechChips({required this.technologies, required this.colors});

  final List<String> technologies;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: [
        for (final tech in technologies)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: colors.bgCanvas,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colors.borderSubtle),
            ),
            child: Text(
              tech,
              style: AppFonts.mono(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: colors.textSecondary,
              ),
            ),
          ),
      ],
    );
  }
}

class _ResponsibilityList extends StatelessWidget {
  const _ResponsibilityList({
    required this.items,
    required this.lang,
    required this.colors,
  });

  final List<LocalizedText> items;
  final String lang;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(height: 6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 7),
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colors.accentPrimary.withValues(alpha: 0.7),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  items[i].resolveCode(lang),
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.45,
                    color: colors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
