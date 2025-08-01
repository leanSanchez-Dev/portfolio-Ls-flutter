import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/utils/social_row.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> with TickerProviderStateMixin {
  bool _isFirstImage = true;
  late AnimationController _profileController;
  late AnimationController _contentController;

  @override
  void initState() {
    super.initState();
    _profileController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _contentController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    if (mounted) {
      _profileController.forward();
    }
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _contentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _profileController.dispose();
    _contentController.dispose();
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
                ? 450
                : 380,
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
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProfileSection(),
                const SizedBox(height: 32),
                _buildBioSection(),
                const SizedBox(height: 24),
                _buildSkillChips(),
                const SizedBox(height: 32),
                _buildContactSection(),
                const SizedBox(height: 24),
                const SocialRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return AnimatedBuilder(
      animation: _profileController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _profileController,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.8, end: 1.0).animate(
              CurvedAnimation(
                parent: _profileController,
                curve: Curves.elasticOut,
              ),
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor.withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedSwitcher(
                          switchInCurve: Curves.easeInOut,
                          switchOutCurve: Curves.easeInOut,
                          duration: const Duration(milliseconds: 800),
                          child: _isFirstImage
                              ? Image.asset(
                                  'assets/dev_bg.png',
                                  key: const ValueKey<String>('dev_bg'),
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/ls_bg.png',
                                  key: const ValueKey<String>('ls_bg'),
                                  height: 160,
                                  width: 160,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      bottom: 8,
                      child: AnimatedHoverContainer(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: IconButton(
                            onPressed: _toggleImage,
                            icon: const Icon(
                              FontAwesomeIcons.cameraRotate,
                              color: Colors.white,
                              size: 16,
                            ),
                            iconSize: 16,
                            padding: const EdgeInsets.all(8),
                            constraints: const BoxConstraints(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                TypewriterText(
                  text: AppLocalizations.of(context)!.myName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.getChipBackground(context),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.getBorderStrong(context),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.roleTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.getChipText(context),
                          fontWeight: FontWeight.w600,
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

  Widget _buildBioSection() {
    return AnimatedBuilder(
      animation: _contentController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _contentController,
            curve: Curves.easeOut,
          )),
          child: FadeTransition(
            opacity: _contentController,
            child: Text(
              AppLocalizations.of(context)!.aboutMeDescription,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillChips() {
    final skills = [
      AppLocalizations.of(context)!.flutterDeveloper,
      AppLocalizations.of(context)!.uxUiDesign,
      AppLocalizations.of(context)!.appDeveloper,
      AppLocalizations.of(context)!.frontendDeveloper,
    ];

    return StaggeredList(
      children: skills.map((skill) => _buildSkillChip(skill)).toList(),
    );
  }

  Widget _buildSkillChip(String skill) {
    return AnimatedHoverContainer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: AppColors.getChipBackground(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.getBorderStrong(context),
          ),
        ),
        child: Text(
          skill,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.getChipText(context),
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Column(
      children: [
        Container(
          height: 1,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.transparent,
                Theme.of(context).dividerColor.withOpacity(0.3),
                Colors.transparent,
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        _buildContactItem(
          AppLocalizations.of(context)!.linkedin,
          AppLocalizations.of(context)!.myName,
          FontAwesomeIcons.linkedinIn,
          () => _launchUrl('https://www.linkedin.com/in/leansanchez-dev/'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          AppLocalizations.of(context)!.email,
          AppLocalizations.of(context)!.myEmail,
          FontAwesomeIcons.envelope,
          () => _launchUrl('mailto:Leansanchez14@gmail.com'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          AppLocalizations.of(context)!.github,
          AppLocalizations.of(context)!.githubUsername,
          FontAwesomeIcons.github,
          () => _launchUrl('https://github.com/leanSanchez-Dev'),
        ),
        const SizedBox(height: 16),
        _buildContactItem(
          'GitLab',
          'LeanSanchez-dev',
          FontAwesomeIcons.gitlab,
          () => _launchUrl('https://gitlab.com/leansanchez-dev/'),
        ),
      ],
    );
  }

  Widget _buildContactItem(String title, String subtitle, IconData icon, VoidCallback onTap) {
    return AnimatedHoverContainer(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.getHoverBackground(context),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.getBorder(context),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.getIconBackground(context),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.getIconColor(context),
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          ),
                    ),
                  ],
                ),
              ),
              Icon(
                FontAwesomeIcons.externalLinkAlt,
                size: 12,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  Future<void> _launchUrl(String url) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: '_blank',
    );
  }
}
