import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/domain/models/portfolio_bento.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_snackbar.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openCaseStudyDialog(
  BuildContext context, {
  required ProjectItem project,
}) {
  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Case study',
    barrierColor: const Color(0xBF020617),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (context, animation, secondaryAnimation) {
      return CaseStudyDialog(project: project);
    },
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.96, end: 1).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class CaseStudyDialog extends StatelessWidget {
  const CaseStudyDialog({super.key, required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final language = context.watch<LanguageProvider>();
    final copy = context.watch<PortfolioBentoProvider>().data.copy;
    final lang = language.currentLocale.languageCode;
    final portfolioLang = PortfolioLanguage.fromCode(lang);
    final study = project.caseStudyFor(portfolioLang);

    return Shortcuts(
      shortcuts: const {
        SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
      },
      child: Actions(
        actions: {
          DismissIntent: CallbackAction<DismissIntent>(
            onInvoke: (_) {
              Navigator.of(context).maybePop();
              return null;
            },
          ),
        },
        child: Focus(
          autofocus: true,
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640, maxHeight: 720),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.fromLTRB(24, 22, 24, 24),
                  decoration: BoxDecoration(
                    color: colors.bgSurface,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: colors.borderSubtle),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.categoryLabel,
                                  style: AppFonts.mono(
                                    fontSize: 11,
                                    color: colors.accentSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Semantics(
                                  header: true,
                                  child: Text(
                                    project.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.copyWith(
                                          color: colors.textPrimary,
                                          fontWeight: FontWeight.w800,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Semantics(
                            button: true,
                            label: copy.modalCloseBtn.resolveCode(lang),
                            child: IconButton(
                              tooltip: copy.modalCloseBtn.resolveCode(lang),
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: Icon(
                                Icons.close_rounded,
                                color: colors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _Block(
                                title: copy.modalProblemTitle.resolveCode(lang),
                                body: study.problem,
                              ),
                              const SizedBox(height: 16),
                              _Block(
                                title:
                                    copy.modalSolutionTitle.resolveCode(lang),
                                body: study.solution,
                              ),
                              const SizedBox(height: 16),
                              _Block(
                                title: copy.modalImpactTitle.resolveCode(lang),
                                body: study.impact,
                              ),
                              const SizedBox(height: 18),
                              Text(
                                copy.modalStackTitle.resolveCode(lang),
                                style: AppFonts.mono(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: colors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final tech in project.stack)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: colors.bgCanvas,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: colors.borderSubtle,
                                        ),
                                      ),
                                      child: Text(
                                        tech,
                                        style: AppFonts.mono(
                                          fontSize: 11,
                                          color: colors.textPrimary,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => _openOrToast(
                                context,
                                url: project.liveUrl,
                                toast: copy.toastDemoPreview.resolveCode(lang),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colors.textPrimary,
                                side: BorderSide(color: colors.borderSubtle),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(copy.modalDemoBtn.resolveCode(lang)),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: FilledButton(
                              onPressed: () => _openOrToast(
                                context,
                                url: project.repoUrl,
                                toast: copy.toastRepoPreview.resolveCode(lang),
                              ),
                              style: FilledButton.styleFrom(
                                backgroundColor: colors.accentPrimary,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: Text(copy.modalRepoBtn.resolveCode(lang)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openOrToast(
    BuildContext context, {
    required String? url,
    required String toast,
  }) async {
    if (url == null || url.isEmpty) {
      showBentoSnackBar(context, toast);
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      showBentoSnackBar(context, toast);
      return;
    }
    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      showBentoSnackBar(context, toast);
    }
  }
}

class _Block extends StatelessWidget {
  const _Block({required this.title, required this.body});
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.mono(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: colors.accentPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          body,
          style: TextStyle(
            color: colors.textSecondary,
            height: 1.55,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
