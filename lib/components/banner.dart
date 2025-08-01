import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerInf extends StatefulWidget {
  const BannerInf({super.key});

  @override
  State<BannerInf> createState() => _BannerInfState();
}

class _BannerInfState extends State<BannerInf> with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _controller.forward();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _buttonController.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 800),
      child: AnimatedFadeSlide(
        child: Card(
          elevation: 0,
          color: Theme.of(context).cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
            side: BorderSide(
              color: Theme.of(context).dividerColor.withOpacity(0.1),
              width: 1,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).primaryColor.withOpacity(0.05),
                  Theme.of(context).cardColor,
                  Theme.of(context).primaryColor.withOpacity(0.02),
                ],
              ),
            ),
            padding: const EdgeInsets.all(48),
            child: Column(
              children: [
                _buildHeader(),
                const SizedBox(height: 40),
                _buildContent(),
                const SizedBox(height: 40),
                _buildActions(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.5, end: 1.0).animate(
            CurvedAnimation(
              parent: _controller,
              curve: Curves.elasticOut,
            ),
          ),
          child: FadeTransition(
            opacity: _controller,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                FontAwesomeIcons.rocket,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildContent() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          )),
          child: FadeTransition(
            opacity: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(
                parent: _controller,
                curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
              ),
            ),
            child: Column(
              children: [
                TypewriterText(
                  text: "Let's Build Something Amazing!",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Ready to bring your ideas to life? Let\'s collaborate and create exceptional mobile experiences together.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActions() {
    return AnimatedBuilder(
      animation: _buttonController,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: _buttonController,
              curve: Curves.elasticOut,
            ),
          ),
          child: FadeTransition(
            opacity: _buttonController,
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 16,
              runSpacing: 16,
              children: [
                _buildPrimaryButton(),
                _buildSecondaryButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPrimaryButton() {
    return AnimatedHoverContainer(
      hoverScale: 1.05,
      hoverElevation: 20,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: Theme.of(context).brightness == Brightness.dark
                ? [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ]
                : [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.8),
                  ],
          ),
          borderRadius: BorderRadius.circular(16),
          border: Theme.of(context).brightness == Brightness.dark
              ? Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Theme.of(context).primaryColor.withOpacity(0.4)
                  : Theme.of(context).primaryColor.withOpacity(0.3),
              blurRadius: Theme.of(context).brightness == Brightness.dark ? 16 : 12,
              spreadRadius: Theme.of(context).brightness == Brightness.dark ? 2 : 0,
              offset: const Offset(0, 6),
            ),
            if (Theme.of(context).brightness == Brightness.dark)
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: _contactMe,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          icon: const Icon(
            FontAwesomeIcons.envelope,
            color: Colors.white,
            size: 16,
          ),
          label: Text(
            'Contact Me',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              shadows: Theme.of(context).brightness == Brightness.dark
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return AnimatedHoverContainer(
      hoverScale: 1.05,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? AppColors.darkCardBackground.withOpacity(0.8)
              : Colors.transparent,
          border: Border.all(
            color: Theme.of(context).brightness == Brightness.dark
                ? Theme.of(context).primaryColor.withOpacity(0.6)
                : Theme.of(context).primaryColor.withOpacity(0.3),
            width: Theme.of(context).brightness == Brightness.dark ? 2.5 : 2,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: Theme.of(context).brightness == Brightness.dark
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: ElevatedButton.icon(
          onPressed: _viewProjects,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          icon: Icon(
            FontAwesomeIcons.folderOpen,
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Theme.of(context).primaryColor,
            size: 16,
          ),
          label: Text(
            'View Projects',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Theme.of(context).primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              shadows: Theme.of(context).brightness == Brightness.dark
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _contactMe() async {
    const email = 'mailto:Leansanchez14@gmail.com';
    await launchUrl(Uri.parse(email));
  }

  void _viewProjects() {
    // Scroll to projects section
    // This could be improved by using a callback or navigation
  }
}
