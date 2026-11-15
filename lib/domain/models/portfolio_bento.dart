import 'package:flutter/foundation.dart';

/// Idioma del contenido Bento (ES default).
enum PortfolioLanguage {
  es,
  en;

  static PortfolioLanguage fromCode(String code) {
    return code == 'en' ? PortfolioLanguage.en : PortfolioLanguage.es;
  }

  String get code => name;
}

/// Filtro del tech stack matrix (ESD).
enum TechCategory {
  all,
  mobile,
  frontend,
  backend;

  /// Categorías reales de ítems (sin `all`).
  bool get isFilterable => this != TechCategory.all;
}

/// IDs de case studies del Bento (ESD + legacy carousel).
enum BentoProjectId {
  // ESD featured
  fundacer,
  quipuxCobro,
  fisioterapp,
  angular,
  flutter,
  smarttv,
  // Legacy carousel
  bodecom,
  navipuntos,
  neat,
  adomiPedidos,
  adomiAliados,
  gesport,
  portfolio,
}

/// Categoría de filtro de tarjetas de proyecto (data-category ESD).
enum BentoProjectFilter {
  all,
  fullstack,
  mobile,
  ui,
}

/// Texto bilingüe ES/EN.
@immutable
class LocalizedText {
  const LocalizedText({required this.es, required this.en});

  final String es;
  final String en;

  String resolve(PortfolioLanguage language) {
    return language == PortfolioLanguage.en ? en : es;
  }

  String resolveCode(String languageCode) {
    return resolve(PortfolioLanguage.fromCode(languageCode));
  }
}

/// Ítem del matrix de herramientas.
@immutable
class TechItem {
  const TechItem({
    required this.name,
    required this.category,
    required this.tag,
  }) : assert(category != TechCategory.all);

  final String name;
  final TechCategory category;
  final String tag;
}

/// Contenido del modal caso de estudio (un idioma).
@immutable
class CaseStudyContent {
  const CaseStudyContent({
    required this.problem,
    required this.solution,
    required this.impact,
  });

  final String problem;
  final String solution;
  final String impact;
}

/// Proyecto Bento + case study bilingüe.
@immutable
class ProjectItem {
  const ProjectItem({
    required this.id,
    required this.title,
    required this.categoryLabel,
    required this.yearLabel,
    required this.filterCategory,
    required this.stack,
    required this.cardTags,
    required this.description,
    required this.caseStudy,
    this.liveUrl,
    this.repoUrl,
    this.imageAsset,
    this.company,
  });

  final BentoProjectId id;
  final String title;

  /// Etiqueta de categoría mostrada en card/modal (como en ESD).
  final String categoryLabel;
  final String yearLabel;

  /// `data-category` del HTML (sin `all`).
  final BentoProjectFilter filterCategory;
  final List<String> stack;

  /// Tags cortos visibles en la card.
  final List<String> cardTags;
  final LocalizedText description;
  final Map<PortfolioLanguage, CaseStudyContent> caseStudy;

  /// URL pública de demo/live (opcional; HTML ESD no fija URLs reales).
  final String? liveUrl;

  /// URL de repositorio / arquitectura (opcional).
  final String? repoUrl;

  /// Path de asset de slide (legacy carousel). Null → mockup UI ESD.
  final String? imageAsset;

  /// Empresa / cliente asociado (legacy).
  final String? company;

  /// True si el proyecto usa slide de asset en lugar de mockup sintético.
  bool get hasSlideImage => imageAsset != null && imageAsset!.isNotEmpty;

  CaseStudyContent caseStudyFor(PortfolioLanguage language) {
    return caseStudy[language] ?? caseStudy[PortfolioLanguage.es]!;
  }
}

/// Cliente / producto dentro de una experiencia (p. ej. Fisioterapp bajo Sunset).
@immutable
class ExperienceEngagement {
  const ExperienceEngagement({
    required this.title,
    required this.description,
    required this.technologies,
    required this.responsibilities,
    this.period,
    this.isActive = false,
  });

  final LocalizedText title;
  final LocalizedText? period;
  final LocalizedText description;
  final List<String> technologies;
  final List<LocalizedText> responsibilities;
  final bool isActive;
}

/// Experiencia laboral tipada (migrada desde `experience.dart` jsonStr).
@immutable
class ExperienceItem {
  const ExperienceItem({
    required this.role,
    required this.company,
    required this.period,
    required this.description,
    required this.technologies,
    required this.responsibilities,
    this.isCurrent = false,
    this.engagements = const [],
  });

  final LocalizedText role;
  final String company;

  /// Periodo ya formateado, p. ej. "May 2024 — Actualmente".
  final LocalizedText period;
  final LocalizedText description;
  final List<String> technologies;

  /// Cada ítem es bilingüe (una responsabilidad ES/EN).
  final List<LocalizedText> responsibilities;
  final bool isCurrent;

  /// Clientes/productos anidados. Si no está vacío, el detalle vive aquí.
  final List<ExperienceEngagement> engagements;
}

/// Copy UI de secciones Bento (nav/hero/skills/projects/exp/contact/modal/toast).
///
/// **Decisión i18n:** el copy largo y de secciones del rediseño Bento vive aquí
/// (datasource tipado), no en ARB. ARB (`app_*.arb`) se reserva para la UI
/// legacy (CV, music, GitHub, filtros antiguos). La UI Bento resuelve con
/// [LanguageProvider.currentLocale] + [LocalizedText.resolveCode].
@immutable
class BentoUiCopy {
  const BentoUiCopy({
    required this.navHome,
    required this.navSkills,
    required this.navProjects,
    required this.navExperience,
    required this.navContact,
    required this.heroBadge,
    required this.heroGreeting,
    required this.heroSubtitle,
    required this.heroDescription,
    required this.heroDescriptionHighlight,
    required this.heroCtaPrimary,
    required this.heroCtaSecondary,
    required this.heroLocationLabel,
    required this.heroRemoteReady,
    required this.heroExpYears,
    required this.skillsEyebrow,
    required this.skillsTitle,
    required this.skillsSubtitle,
    required this.skillsMobileTitle,
    required this.skillsMobileDesc,
    required this.skillsFrontendTitle,
    required this.skillsFrontendDesc,
    required this.skillsBackendTitle,
    required this.skillsBackendDesc,
    required this.skillsMatrixTitle,
    required this.skillsMatrixHint,
    required this.skillsTabAll,
    required this.skillsTabMobile,
    required this.skillsTabFrontend,
    required this.skillsTabBackend,
    required this.projectsEyebrow,
    required this.projectsTitle,
    required this.projectsSubtitle,
    required this.projectsFilterAll,
    required this.projectsCaseStudy,
    required this.expEyebrow,
    required this.expTitle,
    required this.expSubtitle,
    required this.contactEyebrow,
    required this.contactTitle,
    required this.contactSubtitle,
    required this.contactDirectEmailLabel,
    required this.contactCopyBtn,
    required this.contactCopiedBtn,
    required this.contactFormName,
    required this.contactFormNamePh,
    required this.contactFormEmail,
    required this.contactFormEmailPh,
    required this.contactFormMessage,
    required this.contactFormMessagePh,
    required this.contactResponseTime,
    required this.contactSubmitBtn,
    required this.footerRights,
    required this.footerBuiltWith,
    required this.modalProblemTitle,
    required this.modalSolutionTitle,
    required this.modalImpactTitle,
    required this.modalStackTitle,
    required this.modalDemoBtn,
    required this.modalRepoBtn,
    required this.modalCloseBtn,
    required this.toastEmailCopied,
    required this.toastFormInvalid,
    required this.toastFormSuccess,
    required this.toastDemoPreview,
    required this.toastRepoPreview,
  });

  final LocalizedText navHome;
  final LocalizedText navSkills;
  final LocalizedText navProjects;
  final LocalizedText navExperience;
  final LocalizedText navContact;
  final LocalizedText heroBadge;
  final LocalizedText heroGreeting;
  final LocalizedText heroSubtitle;

  /// Descripción hero sin el highlight tipográfico.
  final LocalizedText heroDescription;

  /// Fragmento enfatizado dentro de [heroDescription] (Flutter, Angular y Java).
  final LocalizedText heroDescriptionHighlight;
  final LocalizedText heroCtaPrimary;
  final LocalizedText heroCtaSecondary;
  final LocalizedText heroLocationLabel;
  final LocalizedText heroRemoteReady;
  final LocalizedText heroExpYears;
  final LocalizedText skillsEyebrow;
  final LocalizedText skillsTitle;
  final LocalizedText skillsSubtitle;
  final LocalizedText skillsMobileTitle;
  final LocalizedText skillsMobileDesc;
  final LocalizedText skillsFrontendTitle;
  final LocalizedText skillsFrontendDesc;
  final LocalizedText skillsBackendTitle;
  final LocalizedText skillsBackendDesc;
  final LocalizedText skillsMatrixTitle;
  final LocalizedText skillsMatrixHint;
  final LocalizedText skillsTabAll;
  final LocalizedText skillsTabMobile;
  final LocalizedText skillsTabFrontend;
  final LocalizedText skillsTabBackend;
  final LocalizedText projectsEyebrow;
  final LocalizedText projectsTitle;
  final LocalizedText projectsSubtitle;
  final LocalizedText projectsFilterAll;
  final LocalizedText projectsCaseStudy;
  final LocalizedText expEyebrow;
  final LocalizedText expTitle;
  final LocalizedText expSubtitle;
  final LocalizedText contactEyebrow;
  final LocalizedText contactTitle;
  final LocalizedText contactSubtitle;
  final LocalizedText contactDirectEmailLabel;
  final LocalizedText contactCopyBtn;
  final LocalizedText contactCopiedBtn;
  final LocalizedText contactFormName;
  final LocalizedText contactFormNamePh;
  final LocalizedText contactFormEmail;
  final LocalizedText contactFormEmailPh;
  final LocalizedText contactFormMessage;
  final LocalizedText contactFormMessagePh;
  final LocalizedText contactResponseTime;
  final LocalizedText contactSubmitBtn;
  final LocalizedText footerRights;
  final LocalizedText footerBuiltWith;
  final LocalizedText modalProblemTitle;
  final LocalizedText modalSolutionTitle;
  final LocalizedText modalImpactTitle;
  final LocalizedText modalStackTitle;
  final LocalizedText modalDemoBtn;
  final LocalizedText modalRepoBtn;
  final LocalizedText modalCloseBtn;
  final LocalizedText toastEmailCopied;
  final LocalizedText toastFormInvalid;
  final LocalizedText toastFormSuccess;
  final LocalizedText toastDemoPreview;
  final LocalizedText toastRepoPreview;
}

/// Snapshot completo del contenido Bento (síncrono / local).
@immutable
class PortfolioBentoData {
  const PortfolioBentoData({
    required this.copy,
    required this.techStack,
    required this.projects,
    required this.experiences,
    this.contactEmail = 'Leansanchez14@gmail.com',
    this.brandName = 'lean.dev',
    this.developerName = 'Leonardo Sánchez',
    this.profileImageAsset = 'assets/dev_bg.png',
    this.profileImageAltAsset = 'assets/ls_bg.png',
    this.githubUrl = 'https://github.com/leanSanchez-Dev',
    this.linkedInUrl = 'https://www.linkedin.com/in/leansanchez-dev/',
  });

  final BentoUiCopy copy;
  final List<TechItem> techStack;
  final List<ProjectItem> projects;
  final List<ExperienceItem> experiences;
  final String contactEmail;
  final String brandName;
  final String developerName;
  final String? profileImageAsset;
  final String? profileImageAltAsset;
  final String githubUrl;
  final String linkedInUrl;

  ProjectItem? projectById(BentoProjectId id) {
    for (final project in projects) {
      if (project.id == id) return project;
    }
    return null;
  }

  List<TechItem> techItemsFor(TechCategory filter) {
    if (filter == TechCategory.all) return techStack;
    return techStack
        .where((item) => item.category == filter)
        .toList(growable: false);
  }

  List<ProjectItem> projectsFor(BentoProjectFilter filter) {
    if (filter == BentoProjectFilter.all) return projects;
    return projects
        .where((p) => p.filterCategory == filter)
        .toList(growable: false);
  }

  /// Proyectos legacy (con slide asset), excluye ESD sin imagen.
  List<ProjectItem> get legacyProjects => projects
      .where((p) => p.hasSlideImage)
      .toList(growable: false);
}
