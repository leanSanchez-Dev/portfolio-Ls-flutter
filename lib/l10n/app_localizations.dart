import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Leonardo Sanchez - Portfolio'**
  String get appTitle;

  /// A greeting
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Casual greeting
  ///
  /// In en, this message translates to:
  /// **'Hi there!'**
  String get hiThere;

  /// Introduction text
  ///
  /// In en, this message translates to:
  /// **'I\'m Leonardo'**
  String get intro;

  /// Professional role title
  ///
  /// In en, this message translates to:
  /// **'ADSI Technologist · Full Stack & Mobile'**
  String get roleTitle;

  /// Introduction description
  ///
  /// In en, this message translates to:
  /// **'Passionate about creating exceptional mobile and web experiences with modern technologies. Specialized in Flutter development with solid experience in Angular and native Android.'**
  String get introDescription;

  /// Contact button text
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contactMe;

  /// View projects button text
  ///
  /// In en, this message translates to:
  /// **'View Projects'**
  String get viewProjects;

  /// About section title
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get aboutTitle;

  /// About section description
  ///
  /// In en, this message translates to:
  /// **'Flutter developer with {years}+ years of experience creating mobile and web applications. Passionate about clean code, exceptional user experience, and staying up-to-date with the latest technologies.'**
  String aboutDescription(String years);

  /// Skills section title
  ///
  /// In en, this message translates to:
  /// **'Skills & Expertise'**
  String get skillsTitle;

  /// Programming languages category
  ///
  /// In en, this message translates to:
  /// **'Programming Languages'**
  String get programmingLanguages;

  /// Frameworks and libraries category
  ///
  /// In en, this message translates to:
  /// **'Frameworks & Libraries'**
  String get frameworksLibraries;

  /// Tools and design category
  ///
  /// In en, this message translates to:
  /// **'Tools & Design'**
  String get toolsDesign;

  /// Core competencies section title
  ///
  /// In en, this message translates to:
  /// **'Core Competencies'**
  String get coreCompetencies;

  /// Flutter developer role
  ///
  /// In en, this message translates to:
  /// **'Flutter Developer'**
  String get flutterDeveloper;

  /// UX/UI design skill
  ///
  /// In en, this message translates to:
  /// **'UX / UI Design'**
  String get uxUiDesign;

  /// App developer role
  ///
  /// In en, this message translates to:
  /// **'App Developer'**
  String get appDeveloper;

  /// Frontend developer role
  ///
  /// In en, this message translates to:
  /// **'Frontend Developer'**
  String get frontendDeveloper;

  /// Work experience section title
  ///
  /// In en, this message translates to:
  /// **'Work Experience'**
  String get workExperienceTitle;

  /// Current position indicator
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get current;

  /// Projects section title
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsTitle;

  /// Projects section description
  ///
  /// In en, this message translates to:
  /// **'Explore some of my most recent work and contributions to the development community.'**
  String get projectsDescription;

  /// View on GitHub button text
  ///
  /// In en, this message translates to:
  /// **'View on GitHub'**
  String get viewOnGitHub;

  /// Contact information section title
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInfo;

  /// LinkedIn social network
  ///
  /// In en, this message translates to:
  /// **'LinkedIn'**
  String get linkedin;

  /// Email contact method
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// GitHub platform
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// GitLab platform
  ///
  /// In en, this message translates to:
  /// **'GitLab'**
  String get gitlab;

  /// Technologies section
  ///
  /// In en, this message translates to:
  /// **'Technologies'**
  String get technologies;

  /// Responsibilities section
  ///
  /// In en, this message translates to:
  /// **'Responsibilities'**
  String get responsibilities;

  /// Projects section
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// Language selector
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// Spanish language
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get spanish;

  /// English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Skills and expertise section title
  ///
  /// In en, this message translates to:
  /// **'SKILLS & EXPERTISE'**
  String get skillsExpertiseTitle;

  /// Technical skills subtitle
  ///
  /// In en, this message translates to:
  /// **'Technical Skills'**
  String get technicalSkills;

  /// Technical skills description
  ///
  /// In en, this message translates to:
  /// **'Here are the technologies and tools I work with to bring ideas to life.'**
  String get technicalSkillsDescription;

  /// About me detailed description
  ///
  /// In en, this message translates to:
  /// **'Information Systems Analysis and Development Technologist (ADSI) with experience in mobile and full-stack software development. I have built mobile apps (Flutter, Android, iOS) and enterprise web platforms with Angular, Next.js/React and backends in Java/Spring Boot and Supabase. I specialize in modern architectures (microfrontends, hexagonal/CQRS, PWA) and solutions that optimize operational processes. I work with Scrum agile methodology, with a proactive, methodical approach and a strong ethical commitment to product quality and teams.'**
  String get aboutMeDescription;

  /// My full name
  ///
  /// In en, this message translates to:
  /// **'Leonardo Sanchez'**
  String get myName;

  /// My email address
  ///
  /// In en, this message translates to:
  /// **'Leansanchez14@gmail.com'**
  String get myEmail;

  /// GitHub username
  ///
  /// In en, this message translates to:
  /// **'LeanSanchez-dev'**
  String get githubUsername;

  /// Featured projects section title
  ///
  /// In en, this message translates to:
  /// **'Featured Projects'**
  String get featuredProjects;

  /// Featured projects section description
  ///
  /// In en, this message translates to:
  /// **'Explore some of my recent work and personal projects'**
  String get featuredProjectsDescription;

  /// Currently working indicator
  ///
  /// In en, this message translates to:
  /// **'Currently'**
  String get currently;

  /// Projects section label
  ///
  /// In en, this message translates to:
  /// **'Projects:'**
  String get projectsLabel;

  /// Responsibilities section label
  ///
  /// In en, this message translates to:
  /// **'Responsibilities:'**
  String get responsibilitiesLabel;

  /// Technologies section label
  ///
  /// In en, this message translates to:
  /// **'Technologies:'**
  String get technologiesLabel;

  /// Skills navigation item
  ///
  /// In en, this message translates to:
  /// **'Skills'**
  String get skillsNav;

  /// Experience navigation item
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experienceNav;

  /// Projects navigation item
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projectsNav;

  /// GitHub stats navigation item
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get githubNav;

  /// Music / Spotify navigation item
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get musicNav;

  /// Label of the desktop navigation overflow menu
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get moreNav;

  /// Contact navigation item
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactNav;

  /// Tooltip for switching to light mode
  ///
  /// In en, this message translates to:
  /// **'Switch to Light Mode'**
  String get switchToLightMode;

  /// Tooltip for switching to dark mode
  ///
  /// In en, this message translates to:
  /// **'Switch to Dark Mode'**
  String get switchToDarkMode;

  /// Light mode label
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// Dark mode label
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// GitHub stats section title
  ///
  /// In en, this message translates to:
  /// **'GitHub Stats'**
  String get githubStatsTitle;

  /// GitHub stats section description
  ///
  /// In en, this message translates to:
  /// **'A real-time look at my activity and the languages I use the most on GitHub.'**
  String get githubStatsDescription;

  /// Spotify / music section title
  ///
  /// In en, this message translates to:
  /// **'Music While I Code'**
  String get musicTitle;

  /// Spotify / music section description
  ///
  /// In en, this message translates to:
  /// **'The soundtrack that keeps me company on every line of code.'**
  String get musicDescription;

  /// Label for the projects technology filter
  ///
  /// In en, this message translates to:
  /// **'Filter by technology'**
  String get projectsFilterLabel;

  /// Filter option that shows every project
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filterAll;

  /// Empty state shown when the technology filter returns no projects
  ///
  /// In en, this message translates to:
  /// **'No projects with this technology yet.'**
  String get noProjectsForFilter;

  /// Button that removes the active technology filter
  ///
  /// In en, this message translates to:
  /// **'Clear filter'**
  String get clearFilter;

  /// Fallback message shown when the GitHub stats card fails to load
  ///
  /// In en, this message translates to:
  /// **'GitHub stats aren\'t available right now.'**
  String get githubStatsUnavailable;

  /// Link that opens the playlist on the Spotify website
  ///
  /// In en, this message translates to:
  /// **'Open in Spotify'**
  String get openInSpotify;

  /// Accessible label for the carousel back arrow
  ///
  /// In en, this message translates to:
  /// **'Previous project'**
  String get previousProject;

  /// Accessible label for the carousel forward arrow
  ///
  /// In en, this message translates to:
  /// **'Next project'**
  String get nextProject;

  /// Primary label for the CV download button
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get cvDownloadLabel;

  /// Loading label while the CV PDF is being generated
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get cvDownloading;

  /// SnackBar shown after a successful CV download
  ///
  /// In en, this message translates to:
  /// **'CV downloaded successfully'**
  String get cvDownloadSuccess;

  /// SnackBar shown when CV download fails
  ///
  /// In en, this message translates to:
  /// **'Error downloading CV'**
  String get cvDownloadError;

  /// Button label that opens the CV preview screen
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get cvPreviewLabel;

  /// Button label that downloads the Harvard CV PDF
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get cvDownloadPdfLabel;

  /// SnackBar shown when navigating to CV preview
  ///
  /// In en, this message translates to:
  /// **'Opening CV preview'**
  String get cvPreviewOpening;

  /// SnackBar shown when CV preview fails to open
  ///
  /// In en, this message translates to:
  /// **'Error opening CV preview'**
  String get cvPreviewError;

  /// Title on the floating CV download card
  ///
  /// In en, this message translates to:
  /// **'My Resume'**
  String get cvFloatingTitle;

  /// Subtitle on the floating CV download card
  ///
  /// In en, this message translates to:
  /// **'Download my full CV'**
  String get cvFloatingSubtitle;

  /// Compact download label on the floating CV card
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get cvFloatingDownload;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
