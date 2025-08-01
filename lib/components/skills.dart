import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  double _validationWidth() {
    return MediaQuery.of(context).size.width < 900
        ? MediaQuery.of(context).size.width * 0.9
        : MediaQuery.of(context).size.width < 1600
            ? MediaQuery.of(context).size.width * 0.28
            : MediaQuery.of(context).size.width * 0.25;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          // Section Header
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 100),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.skillsExpertiseTitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  AppLocalizations.of(context)!.technicalSkills,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Text(
                    AppLocalizations.of(context)!.technicalSkillsDescription,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 50),

          // Skills Grid
          Wrap(
            spacing: 30,
            runSpacing: 30,
            alignment: WrapAlignment.center,
            children: [
              // Programming Languages
              AnimatedFadeSlide(
                delay: const Duration(milliseconds: 200),
                child: _buildSkillCard(
                  title: AppLocalizations.of(context)!.programmingLanguages,
                  icon: FontAwesomeIcons.code,
                  skills: [
                    SkillData('Dart', 0.9, const Color(0xFF0175C2)),
                    SkillData('JavaScript', 0.85, const Color(0xFFF7DF1E)),
                    SkillData('Java', 0.8, const Color(0xFFED8B00)),
                    SkillData('Kotlin', 0.75, const Color(0xFF7F52FF)),
                    SkillData('Python', 0.7, const Color(0xFF3776AB)),
                  ],
                ),
              ),

              // Frameworks & Libraries
              AnimatedFadeSlide(
                delay: const Duration(milliseconds: 300),
                child: _buildSkillCard(
                  title: AppLocalizations.of(context)!.frameworksLibraries,
                  icon: FontAwesomeIcons.layerGroup,
                  skills: [
                    SkillData('Flutter', 0.95, const Color(0xFF02569B)),
                    SkillData('React Native', 0.8, const Color(0xFF61DAFB)),
                    SkillData('Django', 0.75, const Color(0xFF092E20)),
                    SkillData('Node.js', 0.7, const Color(0xFF339933)),
                    SkillData('Express.js', 0.7, const Color(0xFF000000)),
                  ],
                ),
              ),

              // Tools & Design
              AnimatedFadeSlide(
                delay: const Duration(milliseconds: 400),
                child: _buildSkillCard(
                  title: AppLocalizations.of(context)!.toolsDesign,
                  icon: FontAwesomeIcons.tools,
                  skills: [
                    SkillData('Figma', 0.9, const Color(0xFFF24E1E)),
                    SkillData('Git', 0.85, const Color(0xFFF05032)),
                    SkillData('Adobe XD', 0.8, const Color(0xFFFF61F6)),
                    SkillData('Firebase', 0.8, const Color(0xFFFFCA28)),
                    SkillData('VS Code', 0.9, const Color(0xFF007ACC)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 60),

          // Additional Skills Section
          AnimatedFadeSlide(
            delay: const Duration(milliseconds: 500),
            child: Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 800),
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).primaryColor.withOpacity(0.1),
                    Theme.of(context).primaryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.lightbulb,
                    color: Theme.of(context).primaryColor,
                    size: 32,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    AppLocalizations.of(context)!.coreCompetencies,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      'Mobile Development',
                      'Web Development',
                      'UI/UX Design',
                      'API Integration',
                      'Database Design',
                      'Agile Methodology',
                      'Team Leadership',
                      'Problem Solving',
                    ].map((skill) => _buildCompetencyChip(skill)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard({
    required String title,
    required IconData icon,
    required List<SkillData> skills,
  }) {
    return AnimatedHoverContainer(
      hoverScale: 1.02,
      hoverElevation: 15,
      hoverShadowColor: Theme.of(context).primaryColor,
      child: Container(
        width: _validationWidth(),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.getCardBackground(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.getBorderStrong(context),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.black.withOpacity(0.4)
                  : Theme.of(context).primaryColor.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.getIconBackground(context),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.getBorderStrong(context),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    icon,
                    color: AppColors.getIconColor(context),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Skills List
            ...skills.asMap().entries.map((entry) {
              int index = entry.key;
              SkillData skill = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: AnimatedCircularProgress(
                  progress: skill.level,
                  label: skill.name,
                  color: skill.color,
                  delay: Duration(milliseconds: 100 * (index + 1)),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCompetencyChip(String skill) {
    return AnimatedHoverContainer(
      hoverScale: 1.05,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.getChipBackground(context),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.getBorderStrong(context),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).brightness == Brightness.dark 
                  ? Colors.black.withOpacity(0.3)
                  : Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 8,
              spreadRadius: 0,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          skill,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.getChipText(context),
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

class SkillData {
  final String name;
  final double level;
  final Color color;

  SkillData(this.name, this.level, this.color);
}
