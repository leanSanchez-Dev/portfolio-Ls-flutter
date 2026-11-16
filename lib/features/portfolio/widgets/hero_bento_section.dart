import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
import 'package:url_launcher/url_launcher.dart';

class HeroBentoSection extends StatefulWidget {
  const HeroBentoSection({super.key});

  @override
  State<HeroBentoSection> createState() => _HeroBentoSectionState();
}

class _HeroBentoSectionState extends State<HeroBentoSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulse;
  bool _showLeanTs = true;
  bool _showPrimaryProfile = true;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final reduce = MediaQuery.disableAnimationsOf(context);
    if (reduce) {
      _pulse.stop();
      _pulse.value = 1;
    } else if (!_pulse.isAnimating) {
      _pulse.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bento = context.watch<PortfolioBentoProvider>();
    final language = context.watch<LanguageProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final data = bento.data;
    final width = MediaQuery.sizeOf(context).width;
    final desktop = Breakpoints.isDesktop(width);

    final editorial = _EditorialColumn(
      copy: copy,
      lang: lang,
      developerName: data.developerName,
      pulse: _pulse,
      profileImageAsset: data.profileImageAsset,
      profileImageAltAsset: data.profileImageAltAsset,
      showPrimaryProfile: _showPrimaryProfile,
      onToggleProfile: () =>
          setState(() => _showPrimaryProfile = !_showPrimaryProfile),
      githubUrl: data.githubUrl,
      linkedInUrl: data.linkedInUrl,
      contactEmail: data.contactEmail,
      desktop: desktop,
    );
    final codeBento = _CodeBentoColumn(
      copy: copy,
      lang: lang,
      developerName: data.developerName,
      brandName: data.brandName,
      showLeanTs: _showLeanTs,
      onTabChanged: (lean) => setState(() => _showLeanTs = lean),
    );

    return KeyedSubtree(
      key: ScrollAnchorHelper.homeKey,
      child: BentoContentConstraints(
        child: Padding(
          padding: EdgeInsets.only(
            top: GlassNavSpacer.top + (desktop ? 48 : 28),
            bottom: desktop ? 72 : 48,
          ),
          child: desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(flex: 7, child: editorial),
                    const SizedBox(width: 28),
                    Expanded(flex: 5, child: codeBento),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    editorial,
                    const SizedBox(height: 28),
                    codeBento,
                  ],
                ),
        ),
      ),
    );
  }
}

/// Top inset matching sticky GlassNavbar (+ safe area handled by page).
class GlassNavSpacer {
  static double get top => 68;
}

class _EditorialColumn extends StatelessWidget {
  const _EditorialColumn({
    required this.copy,
    required this.lang,
    required this.developerName,
    required this.pulse,
    required this.profileImageAsset,
    required this.profileImageAltAsset,
    required this.showPrimaryProfile,
    required this.onToggleProfile,
    required this.githubUrl,
    required this.linkedInUrl,
    required this.contactEmail,
    required this.desktop,
  });

  final BentoUiCopy copy;
  final String lang;
  final String developerName;
  final AnimationController pulse;
  final String? profileImageAsset;
  final String? profileImageAltAsset;
  final bool showPrimaryProfile;
  final VoidCallback onToggleProfile;
  final String githubUrl;
  final String linkedInUrl;
  final String contactEmail;
  final bool desktop;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final description = copy.heroDescription.resolveCode(lang);
    final highlight = copy.heroDescriptionHighlight.resolveCode(lang);
    final hasSocial = githubUrl.isNotEmpty ||
        linkedInUrl.isNotEmpty ||
        contactEmail.isNotEmpty;

    final hasProfile =
        profileImageAsset != null && profileImageAsset!.isNotEmpty;
    // Assets (dev_bg/ls_bg) are circular art in a square file — container must be circle.
    final avatarSize = desktop ? 168.0 : 120.0;
    final titleSize = MediaQuery.sizeOf(context).width < 600 ? 34.0 : 46.0;

    final availabilityBadge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: colors.accentSecondary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: colors.accentSecondary.withValues(alpha: 0.28),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: pulse,
            builder: (context, child) {
              final t = pulse.value;
              return Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: (1 - t) * 0.7,
                    child: Container(
                      width: 10 + t * 8,
                      height: 10 + t * 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.accentSecondary.withValues(alpha: 0.45),
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors.accentSecondary,
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(width: 8),
          Text(
            copy.heroBadge.resolveCode(lang),
            style: TextStyle(
              color: colors.accentSecondary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    final greetingBlock = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        availabilityBadge,
        const SizedBox(height: 20),
        Semantics(
          header: true,
          child: Text.rich(
            TextSpan(
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: titleSize,
                    height: 1.12,
                    color: colors.textPrimary,
                  ),
              children: [
                TextSpan(text: '${copy.heroGreeting.resolveCode(lang)} '),
                WidgetSpan(
                  alignment: PlaceholderAlignment.baseline,
                  baseline: TextBaseline.alphabetic,
                  child: ShaderMask(
                    shaderCallback: (bounds) => LinearGradient(
                      colors: [
                        colors.accentPrimary,
                        Color.lerp(
                              colors.accentPrimary,
                              colors.accentSecondary,
                              0.5,
                            ) ??
                            colors.accentPrimary,
                        colors.accentSecondary,
                      ],
                    ).createShader(bounds),
                    child: Text(
                      developerName,
                      style: Theme.of(context)
                          .textTheme
                          .displayMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: titleSize,
                            height: 1.12,
                            color: Colors.white,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          copy.heroSubtitle.resolveCode(lang),
          style: AppFonts.mono(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: colors.accentPrimary,
          ),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasProfile)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ProfileAvatar(
                primaryAsset: profileImageAsset!,
                altAsset: profileImageAltAsset,
                showPrimary: showPrimaryProfile,
                onToggle: onToggleProfile,
                size: avatarSize,
                developerName: developerName,
              ),
              SizedBox(width: desktop ? 28 : 18),
              Expanded(child: greetingBlock),
            ],
          )
        else
          greetingBlock,
        const SizedBox(height: 16),
        _HighlightedDescription(
          full: description,
          highlight: highlight,
          baseColor: colors.textSecondary,
          emphasizeColor: colors.textPrimary,
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              onPressed: ScrollAnchorHelper.scrollToProjects,
              style: FilledButton.styleFrom(
                backgroundColor: colors.accentPrimary,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(Icons.arrow_forward_rounded, size: 18),
              label: Text(copy.heroCtaPrimary.resolveCode(lang)),
            ),
            OutlinedButton.icon(
              onPressed: ScrollAnchorHelper.scrollToContact,
              style: OutlinedButton.styleFrom(
                foregroundColor: colors.textPrimary,
                side: BorderSide(color: colors.borderSubtle),
                backgroundColor: colors.bgSurface,
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: Icon(
                Icons.chat_bubble_outline_rounded,
                size: 18,
                color: colors.accentSecondary,
              ),
              label: Text(copy.heroCtaSecondary.resolveCode(lang)),
            ),
          ],
        ),
        if (hasSocial) ...[
          const SizedBox(height: 20),
          _HeroSocialStrip(
            githubUrl: githubUrl,
            linkedInUrl: linkedInUrl,
            contactEmail: contactEmail,
          ),
        ],
      ],
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({
    required this.primaryAsset,
    required this.altAsset,
    required this.showPrimary,
    required this.onToggle,
    required this.size,
    required this.developerName,
  });

  final String primaryAsset;
  final String? altAsset;
  final bool showPrimary;
  final VoidCallback onToggle;
  final double size;
  final String developerName;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final canToggle = altAsset != null && altAsset!.isNotEmpty;
    final asset = showPrimary || !canToggle ? primaryAsset : altAsset!;

    return Semantics(
      image: true,
      label: developerName,
      button: canToggle,
      child: MouseRegion(
        cursor: canToggle
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        child: GestureDetector(
          onTap: canToggle ? onToggle : null,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colors.accentPrimary.withValues(alpha: 0.55),
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colors.accentPrimary.withValues(alpha: 0.22),
                      blurRadius: 22,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: AnimatedSwitcher(
                    duration: reduceMotion
                        ? Duration.zero
                        : const Duration(milliseconds: 280),
                    child: Image.asset(
                      asset,
                      key: ValueKey<String>(asset),
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                      alignment: const Alignment(0, -0.08),
                      gaplessPlayback: true,
                      // Square display — both dims match exact avatar size.
                      cacheWidth: (size *
                              MediaQuery.devicePixelRatioOf(context))
                          .round()
                          .clamp(1, 1024),
                      cacheHeight: (size *
                              MediaQuery.devicePixelRatioOf(context))
                          .round()
                          .clamp(1, 1024),
                      errorBuilder: (_, __, ___) => ColoredBox(
                        color: colors.bgSurfaceElevated,
                        child: Icon(
                          Icons.person_rounded,
                          size: size * 0.4,
                          color: colors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (canToggle)
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Semantics(
                    button: true,
                    label: 'Toggle profile photo',
                    child: Material(
                      color: colors.accentPrimary,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: onToggle,
                        customBorder: const CircleBorder(),
                        child: const Padding(
                          padding: EdgeInsets.all(9),
                          child: FaIcon(
                            FontAwesomeIcons.cameraRotate,
                            color: Colors.white,
                            size: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroSocialStrip extends StatelessWidget {
  const _HeroSocialStrip({
    required this.githubUrl,
    required this.linkedInUrl,
    required this.contactEmail,
  });

  final String githubUrl;
  final String linkedInUrl;
  final String contactEmail;

  Future<void> _open(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final items = <Widget>[];

    if (githubUrl.isNotEmpty) {
      items.add(
        _SocialIconButton(
          icon: FontAwesomeIcons.github,
          label: 'GitHub',
          onTap: () => _open(githubUrl),
          colors: colors,
        ),
      );
    }
    if (linkedInUrl.isNotEmpty) {
      items.add(
        _SocialIconButton(
          icon: FontAwesomeIcons.linkedinIn,
          label: 'LinkedIn',
          onTap: () => _open(linkedInUrl),
          colors: colors,
        ),
      );
    }
    if (contactEmail.isNotEmpty) {
      items.add(
        _SocialIconButton(
          icon: FontAwesomeIcons.envelope,
          label: contactEmail,
          onTap: () => _open('mailto:$contactEmail'),
          colors: colors,
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: items,
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.colors,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final AppColorsExtension colors;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Tooltip(
          message: label,
          child: Material(
            color: colors.bgSurface,
            borderRadius: BorderRadius.circular(14),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: colors.borderSubtle),
                ),
                child: FaIcon(
                  icon,
                  size: 16,
                  color: colors.textPrimary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HighlightedDescription extends StatelessWidget {
  const _HighlightedDescription({
    required this.full,
    required this.highlight,
    required this.baseColor,
    required this.emphasizeColor,
  });

  final String full;
  final String highlight;
  final Color baseColor;
  final Color emphasizeColor;

  @override
  Widget build(BuildContext context) {
    final idx = full.indexOf(highlight);
    final style = Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: baseColor,
          height: 1.6,
        );
    if (idx < 0) {
      return Text(full, style: style);
    }
    return Text.rich(
      TextSpan(
        style: style,
        children: [
          TextSpan(text: full.substring(0, idx)),
          TextSpan(
            text: highlight,
            style: TextStyle(
              color: emphasizeColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: full.substring(idx + highlight.length)),
        ],
      ),
    );
  }
}

class _CodeBentoColumn extends StatelessWidget {
  const _CodeBentoColumn({
    required this.copy,
    required this.lang,
    required this.developerName,
    required this.brandName,
    required this.showLeanTs,
    required this.onTabChanged,
  });

  final BentoUiCopy copy;
  final String lang;
  final String developerName;
  final String brandName;
  final bool showLeanTs;
  final ValueChanged<bool> onTabChanged;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;

    return Column(
      children: [
        BentoCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const _Dot(Color(0xFFF43F5E)),
                  const SizedBox(width: 6),
                  const _Dot(Color(0xFFFBBF24)),
                  const SizedBox(width: 6),
                  const _Dot(Color(0xFF10B981)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: colors.bgCanvas,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _CodeTab(
                          label: 'lean.ts',
                          selected: showLeanTs,
                          onTap: () => onTabChanged(true),
                        ),
                        _CodeTab(
                          label: 'app.dart',
                          selected: !showLeanTs,
                          onTap: () => onTabChanged(false),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              AnimatedSwitcher(
                duration: MediaQuery.disableAnimationsOf(context)
                    ? Duration.zero
                    : const Duration(milliseconds: 220),
                child: showLeanTs
                    ? _LeanTsSnippet(
                        key: const ValueKey('lean'),
                        name: developerName,
                        brand: brandName,
                      )
                    : const _AppDartSnippet(key: ValueKey('dart')),
              ),
              const SizedBox(height: 14),
              Divider(color: colors.borderSubtle, height: 1),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.check_circle_outline,
                      size: 14, color: colors.accentSecondary),
                  const SizedBox(width: 6),
                  Text(
                    'build: passing (99.8% perf)',
                    style: AppFonts.mono(
                      fontSize: 11,
                      color: colors.accentSecondary,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'UTF-8 · v2026',
                    style: AppFonts.mono(
                      fontSize: 11,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: BentoCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _MiniIcon(
                          icon: Icons.location_on_outlined,
                          color: colors.accentPrimary,
                        ),
                        const Spacer(),
                        _Chip(label: 'UTC-5', colors: colors),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      copy.heroLocationLabel.resolveCode(lang).toUpperCase(),
                      style: AppFonts.mono(
                        fontSize: 10,
                        letterSpacing: 1.2,
                        color: colors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Popayán, Colombia',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      copy.heroRemoteReady.resolveCode(lang),
                      style: AppFonts.mono(
                        fontSize: 11,
                        color: colors.accentPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: BentoCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _MiniIcon(
                          icon: Icons.bolt_rounded,
                          color: colors.accentSecondary,
                        ),
                        const Spacer(),
                        _Chip(
                          label: 'SENIOR',
                          colors: colors,
                          accent: true,
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Text(
                      copy.heroExpYears.resolveCode(lang),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: colors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Flutter · Angular · Next.js · Spring',
                      style: AppFonts.mono(
                        fontSize: 11,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot(this.color);
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color.withValues(alpha: 0.85), shape: BoxShape.circle),
    );
  }
}

class _CodeTab extends StatelessWidget {
  const _CodeTab({
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? colors.bgSurfaceElevated : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            style: AppFonts.mono(
              fontSize: 11,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? colors.accentPrimary : colors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniIcon extends StatelessWidget {
  const _MiniIcon({required this.icon, required this.color});
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(icon, size: 18, color: color),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.colors, this.accent = false});
  final String label;
  final AppColorsExtension colors;
  final bool accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: accent
            ? colors.accentSecondary.withValues(alpha: 0.12)
            : colors.bgCanvas,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: AppFonts.mono(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: accent ? colors.accentSecondary : colors.textSecondary,
        ),
      ),
    );
  }
}

class _LeanTsSnippet extends StatelessWidget {
  const _LeanTsSnippet({super.key, required this.name, required this.brand});
  final String name;
  final String brand;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final comment = colors.textSecondary;
    final kw = colors.accentPrimary;
    final id = colors.accentSecondary;
    final str = const Color(0xFFFBBF24);
    final plain = colors.textPrimary;

    TextSpan mono(String text, Color color, {FontWeight? w}) => TextSpan(
          text: text,
          style: AppFonts.mono(fontSize: 12.5, color: color, fontWeight: w),
        );

    return Text.rich(
      TextSpan(
        children: [
          mono('// Senior Software Engineer\n', comment),
          mono('const ', kw),
          mono('developer', id, w: FontWeight.w600),
          mono(' = {\n', plain),
          mono('  name: ', plain),
          mono("'$name'", str),
          mono(',\n', plain),
          mono('  brand: ', plain),
          mono("'$brand'", str),
          mono(',\n', plain),
          mono('  coreStack: [', plain),
          mono("'Flutter'", id),
          mono(', ', plain),
          mono("'Angular'", id),
          mono(', ', plain),
          mono("'Next.js'", id),
          mono(', ', plain),
          mono("'Spring'", id),
          mono('],\n', plain),
          mono('  cleanArchitecture: ', plain),
          mono('true', kw, w: FontWeight.w600),
          mono('\n};', plain),
        ],
      ),
    );
  }
}

class _AppDartSnippet extends StatelessWidget {
  const _AppDartSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final comment = colors.textSecondary;
    final kw = colors.accentPrimary;
    final id = colors.accentSecondary;
    final str = const Color(0xFFFBBF24);
    final fn = const Color(0xFF38BDF8);
    final plain = colors.textPrimary;

    TextSpan mono(String text, Color color, {FontWeight? w}) => TextSpan(
          text: text,
          style: AppFonts.mono(fontSize: 12.5, color: color, fontWeight: w),
        );

    return Text.rich(
      TextSpan(
        children: [
          mono('// Offline-First Clean Architecture\n', comment),
          mono('class ', kw),
          mono('AppBootstrap', id, w: FontWeight.w600),
          mono(' {\n', plain),
          mono('  final ', kw),
          mono("sdk = 'Flutter + FVM';\n", str),
          mono('  final ', kw),
          mono("backend = 'Spring & Supabase';\n", str),
          mono('  Future<void> ', plain),
          mono('deploy', fn),
          mono('() => ', plain),
          mono('shipFast()', id),
          mono(';\n}', plain),
        ],
      ),
    );
  }
}
