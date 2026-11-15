import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_section_header.dart';
import 'package:portfolio_ls/features/portfolio/widgets/capabilities_section.dart';
import 'package:portfolio_ls/features/portfolio/widgets/contact_section.dart';
import 'package:portfolio_ls/features/portfolio/widgets/experience_section.dart';
import 'package:portfolio_ls/features/portfolio/widgets/glass_navbar.dart';
import 'package:portfolio_ls/features/portfolio/widgets/hero_bento_section.dart';
import 'package:portfolio_ls/features/portfolio/widgets/projects_section.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:provider/provider.dart';

/// Bento dark-first portfolio shell (ESD Phases 3–5).
class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bento = context.watch<PortfolioBentoProvider>();
    if (!bento.isLoaded) {
      return Scaffold(
        backgroundColor: colors.bgCanvas,
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final language = context.watch<LanguageProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final year = DateTime.now().year;

    return Scaffold(
      backgroundColor: colors.bgCanvas,
      body: Stack(
        children: [
          const Positioned.fill(child: _AmbientGlows()),
          SelectionArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                const SliverToBoxAdapter(child: HeroBentoSection()),
                const SliverToBoxAdapter(child: CapabilitiesSection()),
                const SliverToBoxAdapter(child: ProjectsSection()),
                const SliverToBoxAdapter(child: ExperienceSection()),
                const SliverToBoxAdapter(child: ContactSection()),
                SliverToBoxAdapter(
                  child: _Footer(
                    brand: bento.data.brandName,
                    rights: copy.footerRights.resolveCode(lang),
                    builtWith: copy.footerBuiltWith.resolveCode(lang),
                    year: year,
                    developerName: bento.data.developerName,
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
          const Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlassNavbar(),
          ),
        ],
      ),
    );
  }
}

class _AmbientGlows extends StatelessWidget {
  const _AmbientGlows();

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          Positioned(
            top: -140,
            left: -100,
            child: _Glow(
              size: 420,
              color: const Color(0xFF6366F1).withValues(alpha: 0.14),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.28,
            right: -110,
            child: _Glow(
              size: 380,
              color: const Color(0xFF10B981).withValues(alpha: 0.10),
            ),
          ),
          Positioned(
            bottom: 40,
            left: MediaQuery.sizeOf(context).width * 0.18,
            child: _Glow(
              size: 360,
              color: const Color(0xFF6366F1).withValues(alpha: 0.08),
            ),
          ),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.size, required this.color});
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({
    required this.brand,
    required this.rights,
    required this.builtWith,
    required this.year,
    required this.developerName,
  });

  final String brand;
  final String rights;
  final String builtWith;
  final int year;
  final String developerName;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final parts = brand.split('.');
    final head = parts.isNotEmpty ? parts.first : brand;

    return BentoContentConstraints(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 28),
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: colors.borderSubtle)),
        ),
        child: Wrap(
          spacing: 16,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                RichText(
                  text: TextSpan(
                    style: AppFonts.mono(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colors.textPrimary,
                    ),
                    children: [
                      TextSpan(text: head),
                      TextSpan(
                        text: '.',
                        style: TextStyle(color: colors.accentPrimary),
                      ),
                      if (parts.length > 1) TextSpan(text: parts.sublist(1).join('.')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('|', style: TextStyle(color: colors.borderSubtle)),
                ),
                Text(
                  '© $year $developerName. $rights',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.textSecondary,
                  ),
                ),
              ],
            ),
            Text(
              builtWith,
              style: AppFonts.mono(
                fontSize: 11,
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
