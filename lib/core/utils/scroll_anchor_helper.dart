import 'package:flutter/material.dart';

/// GlobalKeys + smooth scroll for Bento section anchors.
class ScrollAnchorHelper {
  ScrollAnchorHelper._();

  static final GlobalKey homeKey = GlobalKey(debugLabel: 'bento_home');
  static final GlobalKey skillsKey = GlobalKey(debugLabel: 'bento_skills');
  static final GlobalKey projectsKey = GlobalKey(debugLabel: 'bento_projects');
  static final GlobalKey experienceKey =
      GlobalKey(debugLabel: 'bento_experience');
  static final GlobalKey contactKey = GlobalKey(debugLabel: 'bento_contact');

  static const Duration duration = Duration(milliseconds: 550);
  static const Curve curve = Curves.easeOutCubic;

  static Future<void> scrollTo(GlobalKey key) async {
    final context = key.currentContext;
    if (context == null) return;
    await Scrollable.ensureVisible(
      context,
      duration: duration,
      curve: curve,
      alignment: 0.08,
    );
  }

  static Future<void> scrollToHome() => scrollTo(homeKey);
  static Future<void> scrollToSkills() => scrollTo(skillsKey);
  static Future<void> scrollToProjects() => scrollTo(projectsKey);
  static Future<void> scrollToExperience() => scrollTo(experienceKey);
  static Future<void> scrollToContact() => scrollTo(contactKey);
}
