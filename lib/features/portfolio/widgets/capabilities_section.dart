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

class CapabilitiesSection extends StatelessWidget {
  const CapabilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bento = context.watch<PortfolioBentoProvider>();
    final language = context.watch<LanguageProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final width = MediaQuery.sizeOf(context).width;
    final crossAxisCount = width >= Breakpoints.desktop
        ? 3
        : (width >= Breakpoints.mobile ? 2 : 1);

    final pillars = [
      _Pillar(
        icon: Icons.phone_iphone_rounded,
        title: copy.skillsMobileTitle.resolveCode(lang),
        desc: copy.skillsMobileDesc.resolveCode(lang),
        color: colors.accentSecondary,
      ),
      _Pillar(
        icon: Icons.web_asset_rounded,
        title: copy.skillsFrontendTitle.resolveCode(lang),
        desc: copy.skillsFrontendDesc.resolveCode(lang),
        color: colors.accentPrimary,
      ),
      _Pillar(
        icon: Icons.cloud_outlined,
        title: copy.skillsBackendTitle.resolveCode(lang),
        desc: copy.skillsBackendDesc.resolveCode(lang),
        color: const Color(0xFF38BDF8),
      ),
    ];

    final filters = [
      (TechCategory.all, copy.skillsTabAll.resolveCode(lang)),
      (TechCategory.mobile, copy.skillsTabMobile.resolveCode(lang)),
      (TechCategory.frontend, copy.skillsTabFrontend.resolveCode(lang)),
      (TechCategory.backend, copy.skillsTabBackend.resolveCode(lang)),
    ];

    return KeyedSubtree(
      key: ScrollAnchorHelper.skillsKey,
      child: BentoContentConstraints(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BentoSectionHeader(
                eyebrow: copy.skillsEyebrow.resolveCode(lang),
                title: copy.skillsTitle.resolveCode(lang),
                subtitle: copy.skillsSubtitle.resolveCode(lang),
              ),
              const SizedBox(height: 28),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (crossAxisCount == 1) {
                    return Column(
                      children: [
                        for (var i = 0; i < pillars.length; i++) ...[
                          if (i > 0) const SizedBox(height: 14),
                          _PillarCard(pillar: pillars[i]),
                        ],
                      ],
                    );
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var i = 0; i < pillars.length; i++) ...[
                        if (i > 0) const SizedBox(width: 14),
                        Expanded(child: _PillarCard(pillar: pillars[i])),
                      ],
                    ],
                  );
                },
              ),
              const SizedBox(height: 40),
              Text(
                copy.skillsMatrixTitle.resolveCode(lang),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                copy.skillsMatrixHint.resolveCode(lang),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colors.textSecondary,
                    ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final entry in filters)
                    _FilterChip(
                      label: entry.$2,
                      selected: bento.techFilter == entry.$1,
                      onTap: () => context
                          .read<PortfolioBentoProvider>()
                          .setTechFilter(entry.$1),
                    ),
                ],
              ),
              const SizedBox(height: 18),
              AnimatedSize(
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                alignment: Alignment.topCenter,
                child: _TechStackGrid(items: bento.filteredTech),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Pillar {
  const _Pillar({
    required this.icon,
    required this.title,
    required this.desc,
    required this.color,
  });
  final IconData icon;
  final String title;
  final String desc;
  final Color color;
}

class _PillarCard extends StatelessWidget {
  const _PillarCard({required this.pillar});
  final _Pillar pillar;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return BentoCard(
      padding: const EdgeInsets.all(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: pillar.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(pillar.icon, color: pillar.color, size: 22),
          ),
          const SizedBox(height: 16),
          Text(
            pillar.title,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: colors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            pillar.desc,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: colors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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
                color: selected
                    ? colors.accentPrimary
                    : colors.borderSubtle,
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

class _TechStackGrid extends StatelessWidget {
  const _TechStackGrid({required this.items});
  final List<TechItem> items;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final width = MediaQuery.sizeOf(context).width;
    final cols = width >= 1100 ? 4 : (width >= 768 ? 3 : 2);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: cols,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 2.4,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return BentoCard(
          enableHoverLift: true,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.tag,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppFonts.mono(
                  fontSize: 10,
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
