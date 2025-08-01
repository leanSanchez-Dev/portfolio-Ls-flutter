// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Leonardo Sanchez - Portafolio';

  @override
  String get hello => 'Hola';

  @override
  String get hiThere => '¡Hola!';

  @override
  String get intro => 'Soy Leonardo';

  @override
  String get roleTitle => 'Desarrollador Flutter & Especialista Frontend';

  @override
  String get introDescription =>
      'Apasionado por crear experiencias móviles y web excepcionales con tecnologías modernas. Especializado en desarrollo Flutter con sólida experiencia en Angular y Android nativo.';

  @override
  String get contactMe => 'Contáctame';

  @override
  String get viewProjects => 'Ver Proyectos';

  @override
  String get aboutTitle => 'Acerca de Mí';

  @override
  String aboutDescription(String years) {
    return 'Desarrollador Flutter con $years+ años de experiencia creando aplicaciones móviles y web. Apasionado por el código limpio, la experiencia de usuario excepcional y mantenerme actualizado con las últimas tecnologías.';
  }

  @override
  String get skillsTitle => 'Habilidades y Experiencia';

  @override
  String get programmingLanguages => 'Lenguajes de Programación';

  @override
  String get frameworksLibraries => 'Frameworks y Librerías';

  @override
  String get toolsDesign => 'Herramientas y Diseño';

  @override
  String get coreCompetencies => 'Competencias Principales';

  @override
  String get flutterDeveloper => 'Desarrollador Flutter';

  @override
  String get uxUiDesign => 'Diseño UX / UI';

  @override
  String get appDeveloper => 'Desarrollador de Apps';

  @override
  String get frontendDeveloper => 'Desarrollador Frontend';

  @override
  String get workExperienceTitle => 'Experiencia Laboral';

  @override
  String get current => 'Actual';

  @override
  String get projectsTitle => 'Proyectos';

  @override
  String get projectsDescription =>
      'Explora algunos de mis trabajos más recientes y contribuciones a la comunidad de desarrollo.';

  @override
  String get viewOnGitHub => 'Ver en GitHub';

  @override
  String get contactInfo => 'Información de Contacto';

  @override
  String get linkedin => 'LinkedIn';

  @override
  String get email => 'Correo';

  @override
  String get github => 'GitHub';

  @override
  String get gitlab => 'GitLab';

  @override
  String get technologies => 'Tecnologías';

  @override
  String get responsibilities => 'Responsabilidades';

  @override
  String get projects => 'Proyectos';

  @override
  String get language => 'Idioma';

  @override
  String get spanish => 'Español';

  @override
  String get english => 'Inglés';
}
