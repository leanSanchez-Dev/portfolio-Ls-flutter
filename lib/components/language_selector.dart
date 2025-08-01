import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        return AnimatedHoverContainer(
          hoverScale: 1.05,
          child: InkWell(
            onTap: () {
              languageProvider.toggleLanguage();
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.getChipBackground(context),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.getBorderStrong(context),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.black.withOpacity(0.3)
                        : Theme.of(context).shadowColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.language,
                    size: 18,
                    color: AppColors.getIconColor(context),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    languageProvider.isSpanish ? 'ES' : 'EN',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.getChipText(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    size: 16,
                    color: AppColors.getIconColor(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class FloatingLanguageSelector extends StatelessWidget {
  const FloatingLanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      right: 20,
      child: SafeArea(
        child: Consumer<LanguageProvider>(
          builder: (context, languageProvider, child) {
            return AnimatedHoverContainer(
              hoverScale: 1.1,
              hoverElevation: 12,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                color: AppColors.getCardBackground(context),
                child: InkWell(
                  onTap: () => languageProvider.toggleLanguage(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppColors.getBorderStrong(context),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.language,
                            size: 18,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              languageProvider.currentLanguageName,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.getTextPrimary(context),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '→ ${languageProvider.otherLanguageName}',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.getTextSecondary(context),
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
