import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/constants/breakpoints.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/core/theme/app_theme_id.dart';
import 'package:portfolio_ls/core/utils/scroll_anchor_helper.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:provider/provider.dart';

class GlassNavbar extends StatelessWidget {
  const GlassNavbar({
    super.key,
    this.isScrolling = false,
  });

  static const double height = 68;

  /// When true, uses near-zero blur sigma to keep scroll cheap.
  final bool isScrolling;

  /// Idle blur — cheaper than legacy σ18 while preserving glass look.
  static const double _idleSigma = 12;

  /// Near-zero sigma while scrolling — keeps [BackdropFilter] mounted (no pop).
  static const double _scrollSigma = 0.01;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bento = context.watch<PortfolioBentoProvider>();
    final language = context.watch<LanguageProvider>();
    final theme = context.watch<ThemeProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final width = MediaQuery.sizeOf(context).width;
    final isMobile = Breakpoints.isMobile(width);

    final links = <_NavLink>[
      _NavLink(copy.navHome.resolveCode(lang), ScrollAnchorHelper.scrollToHome),
      _NavLink(
        copy.navSkills.resolveCode(lang),
        ScrollAnchorHelper.scrollToSkills,
      ),
      _NavLink(
        copy.navProjects.resolveCode(lang),
        ScrollAnchorHelper.scrollToProjects,
      ),
      _NavLink(
        copy.navExperience.resolveCode(lang),
        ScrollAnchorHelper.scrollToExperience,
      ),
      _NavLink(
        copy.navContact.resolveCode(lang),
        ScrollAnchorHelper.scrollToContact,
      ),
    ];

    final bar = DecoratedBox(
      decoration: BoxDecoration(
        color: colors.bgCanvas.withValues(
          alpha: isScrolling ? 0.92 : 0.78,
        ),
        border: Border(
          bottom: BorderSide(color: colors.borderSubtle),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: height,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1152),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: width < 600 ? 16 : 24,
                ),
                child: Row(
                  children: [
                    _BrandMark(
                      brandName: bento.data.brandName,
                      onTap: ScrollAnchorHelper.scrollToHome,
                    ),
                    const Spacer(),
                    if (!isMobile) ...[
                      for (final link in links)
                        _NavTextButton(
                          label: link.label,
                          onPressed: link.onTap,
                        ),
                      const SizedBox(width: 8),
                    ],
                    _LangToggle(
                      isSpanish: language.isSpanish,
                      onToggle: language.toggleLanguage,
                    ),
                    const SizedBox(width: 8),
                    _ThemeSelector(
                      themeId: theme.themeId,
                      isSpanish: language.isSpanish,
                      onSelected: theme.setTheme,
                    ),
                    if (isMobile) ...[
                      const SizedBox(width: 4),
                      Semantics(
                        button: true,
                        label: 'Menu',
                        child: IconButton(
                          tooltip: 'Menu',
                          onPressed: () => _openMobileNav(context, links),
                          icon: Icon(
                            Icons.menu_rounded,
                            color: colors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final sigma = isScrolling ? _scrollSigma : _idleSigma;

    return RepaintBoundary(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
          child: bar,
        ),
      ),
    );
  }

  Future<void> _openMobileNav(
    BuildContext context,
    List<_NavLink> links,
  ) async {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: colors.bgSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colors.borderSubtle,
                    borderRadius: BorderRadius.circular(99),
                  ),
                ),
                const SizedBox(height: 16),
                for (final link in links)
                  ListTile(
                    title: Text(
                      link.label,
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onTap: () async {
                      Navigator.of(sheetContext).pop();
                      await link.onTap();
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NavLink {
  const _NavLink(this.label, this.onTap);
  final String label;
  final Future<void> Function() onTap;
}

class _BrandMark extends StatelessWidget {
  const _BrandMark({required this.brandName, required this.onTap});

  final String brandName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final parts = brandName.split('.');
    final head = parts.isNotEmpty ? parts.first : brandName;
    final tail = parts.length > 1 ? '.${parts.sublist(1).join('.')}' : '';

    return Semantics(
      button: true,
      label: brandName,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [colors.accentPrimary, colors.accentSecondary],
                ),
              ),
              padding: const EdgeInsets.all(1),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: colors.bgSurface,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Center(
                  child: Text(
                    '</>',
                    style: AppFonts.mono(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: colors.accentPrimary,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            RichText(
              text: TextSpan(
                style: AppFonts.mono(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: colors.textPrimary,
                ),
                children: [
                  TextSpan(text: head),
                  TextSpan(
                    text: tail.isEmpty ? '' : '.',
                    style: TextStyle(color: colors.accentPrimary),
                  ),
                  if (tail.length > 1) TextSpan(text: tail.substring(1)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavTextButton extends StatelessWidget {
  const _NavTextButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: colors.textSecondary,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _LangToggle extends StatelessWidget {
  const _LangToggle({required this.isSpanish, required this.onToggle});

  final bool isSpanish;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Semantics(
      button: true,
      label: isSpanish ? 'Switch to English' : 'Cambiar a Español',
      child: Tooltip(
        message: isSpanish ? 'EN' : 'ES',
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: colors.borderSubtle),
              color: colors.bgSurface.withValues(alpha: 0.6),
            ),
            child: Text(
              isSpanish ? 'ES' : 'EN',
              style: AppFonts.mono(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: colors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector({
    required this.themeId,
    required this.isSpanish,
    required this.onSelected,
  });

  /// Display order: Obsidian → Monokai → Panda → Light.
  static const List<AppThemeId> _menuOrder = [
    AppThemeId.obsidian,
    AppThemeId.monokai,
    AppThemeId.panda,
    AppThemeId.light,
  ];

  final AppThemeId themeId;
  final bool isSpanish;
  final ValueChanged<AppThemeId> onSelected;

  String _labelFor(AppThemeId id) => isSpanish ? id.labelEs : id.labelEn;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final currentLabel = _labelFor(themeId);
    final semanticsLabel = isSpanish
        ? 'Tema: $currentLabel. Abrir selector de temas'
        : 'Theme: $currentLabel. Open theme selector';

    return Semantics(
      button: true,
      label: semanticsLabel,
      child: PopupMenuButton<AppThemeId>(
        tooltip: currentLabel,
        initialValue: themeId,
        offset: const Offset(0, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: colors.bgSurfaceElevated,
        onSelected: onSelected,
        itemBuilder: (context) {
          return [
            for (final id in _menuOrder)
              CheckedPopupMenuItem<AppThemeId>(
                value: id,
                checked: id == themeId,
                child: Row(
                  children: [
                    _ThemeSwatch(
                      primary: colorsFor(id).accentPrimary,
                      secondary: id == AppThemeId.panda
                          ? colorsFor(id).accentSecondary
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      _labelFor(id),
                      style: TextStyle(
                        color: colors.textPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
          ];
        },
        child: SizedBox(
          width: 40,
          height: 40,
          child: Icon(
            Icons.palette_outlined,
            color: colors.textPrimary,
            size: 20,
          ),
        ),
      ),
    );
  }
}

class _ThemeSwatch extends StatelessWidget {
  const _ThemeSwatch({required this.primary, this.secondary});

  final Color primary;
  final Color? secondary;

  @override
  Widget build(BuildContext context) {
    final second = secondary;
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: second == null
            ? null
            : SweepGradient(colors: [primary, second, primary]),
        color: second == null ? primary : null,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
    );
  }
}
