import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/core/constants/breakpoints.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';
import 'package:portfolio_ls/core/utils/scroll_anchor_helper.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_card.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_section_header.dart';
import 'package:portfolio_ls/features/portfolio/widgets/bento_snackbar.dart';
import 'package:portfolio_ls/providers/language_provider.dart';
import 'package:portfolio_ls/providers/portfolio_bento_provider.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  bool _copied = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _messageCtrl.dispose();
    super.dispose();
  }

  Future<void> _copyEmail(String email, String toast) async {
    await Clipboard.setData(ClipboardData(text: email));
    if (!mounted) return;
    setState(() => _copied = true);
    showBentoSnackBar(context, toast);
    await Future<void>.delayed(const Duration(seconds: 2));
    if (mounted) setState(() => _copied = false);
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _submit(String invalidToast, String successToast) {
    final valid = _formKey.currentState?.validate() ?? false;
    if (!valid) {
      showBentoSnackBar(context, invalidToast);
      return;
    }
    showBentoSnackBar(context, successToast);
    _formKey.currentState?.reset();
    _nameCtrl.clear();
    _emailCtrl.clear();
    _messageCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final bento = context.watch<PortfolioBentoProvider>();
    final language = context.watch<LanguageProvider>();
    final lang = language.currentLocale.languageCode;
    final copy = bento.data.copy;
    final email = bento.data.contactEmail;
    final githubUrl = bento.data.githubUrl;
    final linkedInUrl = bento.data.linkedInUrl;
    final desktop = Breakpoints.isDesktop(MediaQuery.sizeOf(context).width);
    final hasSocialLinks = githubUrl.isNotEmpty || linkedInUrl.isNotEmpty;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BentoSectionHeader(
          eyebrow: copy.contactEyebrow.resolveCode(lang),
          title: copy.contactTitle.resolveCode(lang),
          subtitle: copy.contactSubtitle.resolveCode(lang),
          accentColor: colors.accentSecondary,
        ),
        const SizedBox(height: 20),
        BentoCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                copy.contactDirectEmailLabel.resolveCode(lang),
                style: AppFonts.mono(
                  fontSize: 11,
                  color: colors.textSecondary,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(12, 8, 8, 8),
                decoration: BoxDecoration(
                  color: colors.bgCanvas,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: colors.borderSubtle),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        email,
                        style: AppFonts.mono(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colors.textPrimary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Semantics(
                      button: true,
                      label: copy.contactCopyBtn.resolveCode(lang),
                      child: FilledButton.icon(
                        onPressed: () => _copyEmail(
                          email,
                          copy.toastEmailCopied.resolveCode(lang),
                        ),
                        style: FilledButton.styleFrom(
                          backgroundColor: colors.accentPrimary,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.copy_rounded, size: 14),
                        label: Text(
                          _copied
                              ? copy.contactCopiedBtn.resolveCode(lang)
                              : copy.contactCopyBtn.resolveCode(lang),
                          style: AppFonts.mono(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (hasSocialLinks) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    if (githubUrl.isNotEmpty)
                      _ContactSocialLink(
                        icon: FontAwesomeIcons.github,
                        label: 'GitHub',
                        onTap: () => _openUrl(githubUrl),
                      ),
                    if (linkedInUrl.isNotEmpty)
                      _ContactSocialLink(
                        icon: FontAwesomeIcons.linkedinIn,
                        label: 'LinkedIn',
                        onTap: () => _openUrl(linkedInUrl),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );

    final form = BentoCard(
      padding: const EdgeInsets.all(24),
      enableHoverLift: false,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                final sideBySide = constraints.maxWidth >= 480;
                final nameField = _Field(
                  label: copy.contactFormName.resolveCode(lang),
                  hint: copy.contactFormNamePh.resolveCode(lang),
                  controller: _nameCtrl,
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? '' : null,
                );
                final emailField = _Field(
                  label: copy.contactFormEmail.resolveCode(lang),
                  hint: copy.contactFormEmailPh.resolveCode(lang),
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    final value = v?.trim() ?? '';
                    if (value.isEmpty || !value.contains('@')) return '';
                    return null;
                  },
                );
                if (!sideBySide) {
                  return Column(
                    children: [
                      nameField,
                      const SizedBox(height: 14),
                      emailField,
                    ],
                  );
                }
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: nameField),
                    const SizedBox(width: 14),
                    Expanded(child: emailField),
                  ],
                );
              },
            ),
            const SizedBox(height: 14),
            _Field(
              label: copy.contactFormMessage.resolveCode(lang),
              hint: copy.contactFormMessagePh.resolveCode(lang),
              controller: _messageCtrl,
              maxLines: 5,
              validator: (v) => (v == null || v.trim().isEmpty) ? '' : null,
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: colors.accentSecondary,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      copy.contactResponseTime.resolveCode(lang),
                      style: AppFonts.mono(
                        fontSize: 11,
                        color: colors.textSecondary,
                      ),
                    ),
                  ],
                ),
                FilledButton.icon(
                  onPressed: () => _submit(
                    copy.toastFormInvalid.resolveCode(lang),
                    copy.toastFormSuccess.resolveCode(lang),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.accentPrimary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 22,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  icon: const Icon(Icons.send_rounded, size: 16),
                  label: Text(copy.contactSubmitBtn.resolveCode(lang)),
                ),
              ],
            ),
          ],
        ),
      ),
    );

    return KeyedSubtree(
      key: ScrollAnchorHelper.contactKey,
      child: BentoContentConstraints(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 64),
          child: desktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 5, child: left),
                    const SizedBox(width: 28),
                    Expanded(flex: 7, child: form),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    left,
                    const SizedBox(height: 24),
                    form,
                  ],
                ),
        ),
      ),
    );
  }
}

class _ContactSocialLink extends StatelessWidget {
  const _ContactSocialLink({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Semantics(
      button: true,
      label: label,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Material(
          color: colors.bgCanvas,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: colors.borderSubtle),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FaIcon(icon, size: 14, color: colors.textPrimary),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: AppFonts.mono(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final int maxLines;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppFonts.mono(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: colors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          validator: validator,
          style: TextStyle(color: colors.textPrimary, fontSize: 14),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: colors.textSecondary.withValues(alpha: 0.7)),
            filled: true,
            fillColor: colors.bgCanvas,
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.borderSubtle),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.borderSubtle),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.accentPrimary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.accentPrimary.withValues(alpha: 0.6)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: colors.accentPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
