import 'package:portfolio_ls/domain/models/portfolio_bento.dart';

/// Datasource local tipado del portafolio Bento (ESD + contenido legacy).
///
/// Si mañana los datos pasan a JSON/Firestore, solo cambia esta clase.
abstract class PortfolioBentoDataSource {
  PortfolioBentoData fetch();
}

class PortfolioBentoLocalDataSource implements PortfolioBentoDataSource {
  const PortfolioBentoLocalDataSource();

  @override
  PortfolioBentoData fetch() => _bentoData;
}

LocalizedText _t(String es, String en) => LocalizedText(es: es, en: en);

LocalizedText _resp(String es, String en) => LocalizedText(es: es, en: en);

final PortfolioBentoData _bentoData = PortfolioBentoData(
  copy: _uiCopy,
  techStack: _techStack,
  projects: _projects,
  experiences: _experiences,
  contactEmail: 'Leansanchez14@gmail.com',
  brandName: 'lean.dev',
  developerName: 'Leonardo Sánchez',
  profileImageAsset: 'assets/dev_bg.png',
  profileImageAltAsset: 'assets/ls_bg.png',
  githubUrl: 'https://github.com/leanSanchez-Dev',
  linkedInUrl: 'https://www.linkedin.com/in/leansanchez-dev/',
);

final BentoUiCopy _uiCopy = BentoUiCopy(
  navHome: _t('Inicio', 'Home'),
  navSkills: _t('Habilidades', 'Skills'),
  navProjects: _t('Proyectos', 'Projects'),
  navExperience: _t('Experiencia', 'Experience'),
  navContact: _t('Contacto', 'Contact'),
  heroBadge: _t('Disponible para nuevos retos', 'Available for new challenges'),
  heroGreeting: _t('Hola, soy', "Hi, I'm"),
  heroSubtitle: _t(
    'Tecnólogo ADSI · Full Stack & Mobile',
    'ADSI Technologist · Full Stack & Mobile',
  ),
  // Acerca de mí (CV) — versión completa.
  heroDescription: _t(
    'Tecnólogo en Análisis y Desarrollo de Sistemas de Información (ADSI) con experiencia en desarrollo de software mobile y full stack. He construido aplicaciones móviles (Flutter, Android, iOS) y plataformas web empresariales con Angular, Next.js/React y backends en Java/Spring Boot y Supabase. Me especializo en arquitecturas modernas (microfrontends, hexagonal/CQRS, PWA) y en soluciones que optimizan procesos operativos. Trabajo con metodología ágil Scrum, con enfoque proactivo, metódico y alto compromiso ético con la calidad del producto y los equipos.',
    'Information Systems Analysis and Development Technologist (ADSI) with experience in mobile and full-stack software development. I have built mobile apps (Flutter, Android, iOS) and enterprise web platforms with Angular, Next.js/React and backends in Java/Spring Boot and Supabase. I specialize in modern architectures (microfrontends, hexagonal/CQRS, PWA) and solutions that optimize operational processes. I work with Scrum agile methodology, with a proactive, methodical approach and a strong ethical commitment to product quality and teams.',
  ),
  heroDescriptionHighlight: _t(
    'microfrontends, hexagonal/CQRS, PWA',
    'microfrontends, hexagonal/CQRS, PWA',
  ),
  heroCtaPrimary: _t('Ver Proyectos', 'View Projects'),
  heroCtaSecondary: _t('Contactar', 'Get in Touch'),
  heroLocationLabel: _t('Ubicación', 'Location'),
  heroRemoteReady: _t('Remoto Global · Latam', 'Global Remote · Latam'),
  heroExpYears: _t('6+ Años Exp.', '6+ Years Exp.'),
  skillsEyebrow: _t('Capacidades & Arquitectura', 'Capabilities & Architecture'),
  skillsTitle: _t('Qué hago & Stack Tecnológico', 'What I Do & Tech Stack'),
  // Versión corta del acerca de mí (espacio limitado / skills intro).
  skillsSubtitle: _t(
    'Tecnólogo ADSI con experiencia full stack y mobile. Desarrollo plataformas web con Angular, Next.js/React y Java/Spring Boot/Supabase, además de apps Flutter. Enfocado en arquitecturas escalables, calidad de código y entrega ágil bajo Scrum.',
    'ADSI Technologist with full-stack and mobile experience. I build web platforms with Angular, Next.js/React and Java/Spring Boot/Supabase, plus Flutter apps. Focused on scalable architectures, code quality, and agile delivery under Scrum.',
  ),
  skillsMobileTitle: _t('Desarrollo Mobile', 'Mobile Development'),
  skillsMobileDesc: _t(
    'Aplicaciones nativas multiplataforma en iOS y Android con experiencias fluidas a 60/120fps, persistencia offline-first y gestión de versiones con FVM.',
    'Cross-platform native iOS & Android apps with smooth 60/120fps interfaces, offline-first persistence, and multi-SDK version control via FVM.',
  ),
  skillsFrontendTitle: _t('Ingeniería Frontend', 'Frontend Engineering'),
  skillsFrontendDesc: _t(
    'Microfrontends Angular (Nx, Module Federation, NgRx), Next.js 15 / React 19, sistemas de diseño (PrimeNG, Material, Tailwind) y PWAs con Serwist.',
    'Angular microfrontends (Nx, Module Federation, NgRx), Next.js 15 / React 19, design systems (PrimeNG, Material, Tailwind), and PWAs with Serwist.',
  ),
  skillsBackendTitle: _t('Backend & Cloud', 'Backend & Cloud'),
  skillsBackendDesc: _t(
    'APIs REST con Java 17/21 y Spring Boot 3, JWT, RabbitMQ, Oracle/PostgreSQL, Supabase (RLS, Edge Functions) y pipelines GitLab CI/CD con Docker.',
    'REST APIs with Java 17/21 and Spring Boot 3, JWT, RabbitMQ, Oracle/PostgreSQL, Supabase (RLS, Edge Functions), and GitLab CI/CD pipelines with Docker.',
  ),
  skillsMatrixTitle: _t('Ecosistema de Herramientas', 'Tooling Ecosystem'),
  skillsMatrixHint: _t(
    'Filtra por dominio técnico para explorar mi stack diario',
    'Filter by technical domain to explore my daily stack',
  ),
  skillsTabAll: _t('Todos', 'All'),
  skillsTabMobile: _t('Mobile', 'Mobile'),
  skillsTabFrontend: _t('Frontend', 'Frontend'),
  skillsTabBackend: _t('Backend & Cloud', 'Backend & Cloud'),
  projectsEyebrow: _t('Portafolio Seleccionado', 'Selected Work'),
  projectsTitle: _t('Proyectos Destacados', 'Featured Projects'),
  projectsSubtitle: _t(
    'Haz clic en cualquier proyecto para explorar la arquitectura, los retos resueltos y las decisiones técnicas.',
    'Click any project card to inspect its system architecture, solved challenges, and technical decisions.',
  ),
  projectsFilterAll: _t('Todos', 'All'),
  projectsCaseStudy: _t('Caso', 'Case'),
  expEyebrow: _t('Trayectoria', 'Career Trajectory'),
  expTitle: _t('6+ Años Construyendo Software', '6+ Years Building Software'),
  expSubtitle: _t(
    'Desde soporte técnico y Android nativo hasta Full-Stack con Angular/Spring, Next.js/Supabase y Flutter en fintech y delivery.',
    'From technical support and native Android to Full-Stack with Angular/Spring, Next.js/Supabase, and Flutter in fintech and delivery.',
  ),
  contactEyebrow: _t('Contacto Directo', 'Direct Contact'),
  contactTitle: _t('Trabajemos juntos', "Let's work together"),
  contactSubtitle: _t(
    '¿Tienes un proyecto web, una app móvil en mente o buscas un ingeniero para potenciar tu equipo? Escríbeme y conversemos.',
    "Have a web platform, mobile app in mind, or looking for an engineer to strengthen your team? Send a message and let's talk.",
  ),
  contactDirectEmailLabel: _t('Correo directo', 'Direct email'),
  contactCopyBtn: _t('Copiar correo', 'Copy email'),
  contactCopiedBtn: _t('¡Copiado!', 'Copied!'),
  contactFormName: _t('Nombre', 'Name'),
  contactFormNamePh: _t('Ej. Camila Torres', 'e.g. Alex Rivera'),
  contactFormEmail: _t('Correo electrónico', 'Email address'),
  contactFormEmailPh: _t('camila@empresa.com', 'alex@company.com'),
  contactFormMessage: _t('Mensaje', 'Message'),
  contactFormMessagePh: _t(
    'Cuéntame sobre los objetivos, alcance y tiempos de tu proyecto...',
    'Tell me about your project goals, scope, and timeline...',
  ),
  contactResponseTime: _t(
    'Tiempo de respuesta habitual: < 24h',
    'Typical response time: < 24h',
  ),
  contactSubmitBtn: _t('Enviar Mensaje', 'Send Message'),
  footerRights: _t(
    'Todos los derechos reservados.',
    'All rights reserved.',
  ),
  footerBuiltWith: _t(
    'Diseñado & desarrollado con arquitectura Bento · Popayán, Colombia',
    'Designed & engineered with Bento architecture · Popayán, Colombia',
  ),
  modalProblemTitle: _t(
    '01 // El Reto & Problema',
    '01 // Challenge & Problem',
  ),
  modalSolutionTitle: _t(
    '02 // Arquitectura & Solución',
    '02 // Architecture & Solution',
  ),
  modalImpactTitle: _t(
    '03 // Impacto & Resultados',
    '03 // Impact & Key Results',
  ),
  modalStackTitle: _t('Stack Tecnológico', 'Tech Stack'),
  modalDemoBtn: _t('Explorar Demo', 'Explore Demo'),
  modalRepoBtn: _t('Código / Arquitectura', 'Code / Architecture'),
  modalCloseBtn: _t('Cerrar', 'Close'),
  toastEmailCopied: _t(
    'Correo Leansanchez14@gmail.com copiado al portapapeles.',
    'Email Leansanchez14@gmail.com copied to clipboard.',
  ),
  toastFormInvalid: _t(
    'Por favor completa tu nombre, un correo válido y tu mensaje.',
    'Please enter your name, a valid email, and a message.',
  ),
  toastFormSuccess: _t(
    '¡Mensaje enviado con éxito! Leonardo te responderá pronto.',
    'Message sent successfully! Leonardo will reply shortly.',
  ),
  toastDemoPreview: _t(
    'Abriendo entorno de vista previa del proyecto...',
    'Launching interactive project preview...',
  ),
  toastRepoPreview: _t(
    'Diagrama de arquitectura y repositorio listos para revisión.',
    'Architecture blueprint and repository ready for inspection.',
  ),
);

/// Stack compacto alineado al CV (línea sugerida).
const List<TechItem> _techStack = [
  TechItem(name: 'Flutter', category: TechCategory.mobile, tag: 'UI SDK'),
  TechItem(name: 'Kotlin', category: TechCategory.mobile, tag: 'Android'),
  TechItem(name: 'Swift', category: TechCategory.mobile, tag: 'iOS'),
  TechItem(name: 'Angular', category: TechCategory.frontend, tag: 'Framework'),
  TechItem(name: 'Next.js', category: TechCategory.frontend, tag: 'React SSR'),
  TechItem(name: 'React', category: TechCategory.frontend, tag: 'UI Library'),
  TechItem(
    name: 'TypeScript',
    category: TechCategory.frontend,
    tag: 'Strict Types',
  ),
  TechItem(name: 'NgRx', category: TechCategory.frontend, tag: 'State'),
  TechItem(
    name: 'Tailwind',
    category: TechCategory.frontend,
    tag: 'Design System',
  ),
  TechItem(name: 'PWA', category: TechCategory.frontend, tag: 'Offline Web'),
  TechItem(name: 'Java', category: TechCategory.backend, tag: 'Enterprise'),
  TechItem(
    name: 'Spring Boot',
    category: TechCategory.backend,
    tag: 'Microservices',
  ),
  TechItem(
    name: 'Supabase',
    category: TechCategory.backend,
    tag: 'BaaS / Auth',
  ),
  TechItem(
    name: 'PostgreSQL',
    category: TechCategory.backend,
    tag: 'Relational DB',
  ),
  TechItem(name: 'Oracle', category: TechCategory.backend, tag: 'Enterprise DB'),
  TechItem(name: 'JWT', category: TechCategory.backend, tag: 'Security'),
  TechItem(name: 'Docker', category: TechCategory.backend, tag: 'Containers'),
  TechItem(
    name: 'GitLab CI/CD',
    category: TechCategory.backend,
    tag: 'Pipelines',
  ),
];

/// Orden: 6 ESD (sin imageAsset) + 7 legacy con slides.
final List<ProjectItem> _projects = [
  // ——— ESD ———
  ProjectItem(
    id: BentoProjectId.fundacer,
    title: 'FUNDASER',
    company: 'FUNDASER',
    categoryLabel: 'Full-Stack / Web · PWA',
    yearLabel: '2025',
    filterCategory: BentoProjectFilter.fullstack,
    stack: const [
      'Next.js 15',
      'React 19',
      'TypeScript',
      'Supabase',
      'PostgreSQL',
      'Tailwind',
      'Shadcn',
      'PWA',
      'Serwist',
    ],
    cardTags: const ['Next.js 15', 'Supabase', 'PWA', 'Serwist'],
    description: _t(
      'Plataforma integral para operador ICBF (internado 24/7): portal, turnos, asistencia PWA, pre-nómina y bóveda documental con Next.js 15, React 19, TypeScript y Supabase (PostgreSQL, RLS, Edge Functions).',
      'End-to-end platform for an ICBF operator (24/7 residential care): portal, shifts, PWA attendance, pre-payroll, and document vault with Next.js 15, React 19, TypeScript, and Supabase (PostgreSQL, RLS, Edge Functions).',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Un operador ICBF de internado 24/7 gestionaba portal institucional, turnos, asistencia, pre-nómina y documentación en herramientas fragmentadas, con riesgo de incumplimiento normativo y poca trazabilidad en campo.',
        solution:
            'Se construyó de punta a punta una plataforma Next.js 15 / React 19 con auth RBAC, CMS, motor de turnos, marcación GPS/QR offline (PWA Serwist), liquidación horaria, certificados QR y esquema PostgreSQL con RLS orientado al cumplimiento ICBF vía Supabase Edge Functions.',
        impact:
            'Operación unificada (portal, asistencia offline, pre-nómina y bóveda documental) con controles RLS alineados a cumplimiento ICBF y entrega instalable sin tiendas de aplicaciones.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'An ICBF 24/7 residential-care operator managed institutional portal, shifts, attendance, pre-payroll, and documents across fragmented tools, risking compliance gaps and weak field traceability.',
        solution:
            'Built end-to-end a Next.js 15 / React 19 platform with RBAC auth, CMS, shift engine, offline GPS/QR check-in (PWA Serwist), hourly settlement, QR certificates, and a PostgreSQL RLS schema oriented to ICBF compliance via Supabase Edge Functions.',
        impact:
            'Unified operations (portal, offline attendance, pre-payroll, and document vault) with RLS controls aligned to ICBF compliance and an installable delivery path with zero app-store friction.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.quipuxCobro,
    title: 'Quipux · Cobro Coactivo',
    company: 'Sunset Software House — Cliente Quipux',
    categoryLabel: 'Full-Stack / Web · Enterprise',
    yearLabel: '2025 — 2026',
    filterCategory: BentoProjectFilter.fullstack,
    stack: const [
      'Angular 19',
      'Nx',
      'Module Federation',
      'NgRx',
      'PrimeNG',
      'Java 21',
      'Spring Boot 3',
      'Oracle',
      'JWT',
      'RabbitMQ',
      'Docker',
      'GitLab CI/CD',
    ],
    cardTags: const ['Angular 19', 'Nx', 'Spring Boot 3', 'Oracle'],
    description: _t(
      'Backoffice de cobro coactivo con microfrontends Angular 19 (Nx, Module Federation, NgRx, PrimeNG) y backend Java 21 / Spring Boot 3 (QITS, Jersey, Oracle, JWT, RabbitMQ).',
      'Coercive-collection backoffice with Angular 19 microfrontends (Nx, Module Federation, NgRx, PrimeNG) and a Java 21 / Spring Boot 3 backend (QITS, Jersey, Oracle, JWT, RabbitMQ).',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'El backoffice de cobro coactivo requería módulos desacoplados (cartera, títulos judiciales, reportes y notificaciones) con APIs seguras y despliegue continuo en un entorno enterprise Oracle.',
        solution:
            'Arquitectura de microfrontends Angular 19 con Nx y Module Federation, estado NgRx y PrimeNG, conectada a servicios Java 21 / Spring Boot 3 (QITS, Jersey) con JWT, RabbitMQ, Docker y pipelines GitLab CI/CD.',
        impact:
            'Entrega modular de cartera, títulos, reportes y notificaciones con APIs REST securizadas y pipelines reproducibles para el cliente Quipux.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'The coercive-collection backoffice needed decoupled modules (portfolio, judicial titles, reports, and notifications) with secured APIs and continuous delivery in an enterprise Oracle environment.',
        solution:
            'Angular 19 microfrontend architecture with Nx and Module Federation, NgRx state and PrimeNG, connected to Java 21 / Spring Boot 3 services (QITS, Jersey) with JWT, RabbitMQ, Docker, and GitLab CI/CD pipelines.',
        impact:
            'Modular delivery of portfolio, titles, reports, and notifications with secured REST APIs and reproducible pipelines for the Quipux client.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.fisioterapp,
    title: 'Fisioterapp',
    company: 'Sunset Software House — Fisioterapp',
    categoryLabel: 'Full-Stack / Web · SaaS',
    yearLabel: '2025 — 2026',
    filterCategory: BentoProjectFilter.fullstack,
    stack: const [
      'Angular 21',
      'Material',
      'Tailwind',
      'Signals',
      'Java 17',
      'Spring Boot 3',
      'PostgreSQL',
      'JWT',
      'WebSocket',
      'DigitalOcean Spaces',
    ],
    cardTags: const ['Angular 21', 'Spring Boot 3', 'PostgreSQL', 'SaaS'],
    description: _t(
      'Plataforma SaaS multitenant para clínicas de fisioterapia — Angular 21 (Material, Tailwind, Signals) + Spring Boot 3 / Java 17 (hexagonal + CQRS, PostgreSQL, JWT).',
      'Multitenant SaaS platform for physiotherapy clinics — Angular 21 (Material, Tailwind, Signals) + Spring Boot 3 / Java 17 (hexagonal + CQRS, PostgreSQL, JWT).',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Clínicas de fisioterapia necesitaban un SaaS multitenant para pacientes, agenda, historia clínica y reportes, con tiempo real, correo y almacenamiento de evidencias en la nube.',
        solution:
            'Frontend Angular 21 con Material, Tailwind y Signals; backend Spring Boot 3 / Java 17 hexagonal + CQRS sobre PostgreSQL con JWT, WebSocket, correo y DigitalOcean Spaces.',
        impact:
            'Producto SaaS listo para operación clínica diaria con APIs REST securizadas, sincronización en tiempo real y almacenamiento de archivos por tenant.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Physiotherapy clinics needed a multitenant SaaS for patients, scheduling, clinical history, and reports, with realtime updates, email, and cloud evidence storage.',
        solution:
            'Angular 21 frontend with Material, Tailwind, and Signals; Spring Boot 3 / Java 17 hexagonal + CQRS backend on PostgreSQL with JWT, WebSocket, email, and DigitalOcean Spaces.',
        impact:
            'SaaS product ready for daily clinic operations with secured REST APIs, realtime sync, and per-tenant file storage.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.angular,
    title: 'Enterprise Angular Platform',
    categoryLabel: 'Full-Stack / Web · Enterprise',
    yearLabel: '2024 — 2025',
    filterCategory: BentoProjectFilter.fullstack,
    stack: const [
      'Angular',
      'TypeScript',
      'RxJS',
      'Java',
      'Spring Boot',
      'REST APIs',
    ],
    cardTags: const ['Angular', 'TypeScript', 'RxJS', 'Java'],
    description: _t(
      'Arquitectura frontend modular y librería de componentes UI de alto rendimiento integrada con microservicios Java para flujos operativos críticos.',
      'Modular frontend architecture and high-performance UI component system integrated with Java microservices for mission-critical workflows.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Una plataforma corporativa monolítica presentaba tiempos elevados de carga inicial, acoplamiento entre módulos de negocio e inconsistencias visuales entre múltiples equipos de desarrollo.',
        solution:
            'Se refactorizó hacia una arquitectura modular en Angular con carga diferida (Lazy Loading), estado reactivo basado en RxJS, un sistema de componentes UI reutilizables y contratos tipados conectados a microservicios en Java/Spring Boot.',
        impact:
            'Disminución del 42% en el Time-to-Interactive (TTI) y aceleración de 2x en la entrega de nuevas vistas empresariales gracias al sistema de diseño compartido.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'A monolithic corporate platform suffered from slow initial bundle loads, tight coupling across business domains, and UI inconsistencies across multiple feature squads.',
        solution:
            'Re-architected into a modular Angular workspace with route-level lazy loading, reactive RxJS state pipelines, a shared UI component library, and strongly typed contracts backed by Java/Spring Boot microservices.',
        impact:
            'Reduced Time-to-Interactive (TTI) by 42% and doubled feature delivery velocity through reusable design-system primitives.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.flutter,
    title: 'Flutter Cross-Platform Suite',
    categoryLabel: 'Mobile · Cross-Platform',
    yearLabel: '2024',
    filterCategory: BentoProjectFilter.mobile,
    stack: const [
      'Flutter',
      'Dart',
      'FVM',
      'BLoC',
      'Clean Architecture',
      'Firebase',
    ],
    cardTags: const ['Flutter', 'Dart', 'BLoC', 'Firebase'],
    description: _t(
      'Aplicación móvil multiplataforma con arquitectura offline-first, sincronización inteligente en segundo plano, autenticación biométrica y estado reactivo con BLoC.',
      'Cross-platform mobile application featuring offline-first local storage, background sync workers, biometric auth, and reactive BLoC state.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Los usuarios en zonas con conectividad intermitente perdían registros críticos al sincronizar formularios y evidencias multimedia en tiempo real.',
        solution:
            'Implementación de Clean Architecture en Flutter con gestión de versiones vía FVM, patrón BLoC para flujo unidireccional de datos, base de datos local SQLite con cola de sincronización automática e integración con Firebase Cloud Messaging.',
        impact:
            'Cero pérdida de datos en escenarios sin conexión, fluidez constante a 60fps en iOS y Android, y un 99.6% de sesiones libres de fallos.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Field users operating in low-connectivity areas risked losing critical form records and media evidence during real-time sync attempts.',
        solution:
            'Implemented Clean Architecture in Flutter managed via FVM, BLoC unidirectional state management, local SQLite storage with an automatic background sync queue, and Firebase Cloud Messaging.',
        impact:
            'Zero data loss in offline scenarios, consistent 60fps performance across iOS and Android, and a 99.6% crash-free session rate.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.smarttv,
    title: 'Smart TV Launcher UI',
    categoryLabel: 'UI / Arquitectura · 10-Foot Experience',
    yearLabel: '2025',
    filterCategory: BentoProjectFilter.ui,
    stack: const [
      'Liquid Glass UI',
      'Monokai Pro',
      'JetBrains Mono',
      'Spatial Navigation',
      'Flutter / Web',
    ],
    cardTags: const ['Liquid Glass', 'Monokai Pro', 'Flutter / Web'],
    description: _t(
      'Interfaz experimental de alto contraste para pantallas de gran formato con estética Liquid Glass, paleta Monokai Pro, navegación espacial D-Pad y tipografía JetBrains Mono.',
      'High-contrast experimental 10-foot interface with Liquid Glass translucency, Monokai Pro color tokens, spatial D-Pad focus, and JetBrains Mono.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Los launchers tradicionales para Smart TV suelen saturar la pantalla con baja legibilidad a 3 metros de distancia y transiciones de foco poco claras al navegar con control remoto (D-Pad).',
        solution:
            'Diseño de una interfaz experimental de 10 pies basada en paneles translúcidos Liquid Glass, tokens cromáticos de alto contraste inspirados en Monokai Pro, telemetría tipográfica en JetBrains Mono y un motor de foco espacial direccional.',
        impact:
            'Navegación instantánea mediante teclado/D-Pad con feedback visual inequívoco y una estética editorial nocturna optimizada para paneles OLED.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Traditional Smart TV launchers often clutter the viewport with poor legibility at a 10-foot viewing distance and ambiguous focus states when navigating via D-Pad remote.',
        solution:
            'Crafted an experimental 10-foot interface combining translucent Liquid Glass surfaces, high-contrast Monokai Pro color tokens, JetBrains Mono telemetry typography, and a spatial directional focus engine.',
        impact:
            'Instantaneous keyboard/D-Pad navigation with unmistakable focus rings and a nocturnal OLED-friendly aesthetic.',
      ),
    },
  ),

  // ——— Legacy carousel (7) ———
  ProjectItem(
    id: BentoProjectId.bodecom,
    title: 'Bodecom',
    company: 'Comunix S.A.S',
    categoryLabel: 'Mobile · Flutter',
    yearLabel: '2020',
    filterCategory: BentoProjectFilter.mobile,
    imageAsset: 'assets/slide/bodecom.jpeg',
    stack: const ['Flutter', 'Dart', 'REST APIs', 'Firebase'],
    cardTags: const ['Flutter', 'Dart', 'Firebase'],
    description: _t(
      'Aplicación móvil Flutter para gestión operativa de bodega e inventarios, integrada con APIs REST y Firebase en Comunix S.A.S.',
      'Flutter mobile app for warehouse and inventory operations, integrated with REST APIs and Firebase at Comunix S.A.S.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Los procesos de bodega e inventario dependían de flujos manuales y herramientas poco adaptadas a operación móvil en campo.',
        solution:
            'Desarrollo de Bodecom en Flutter con consumo de APIs REST y Firebase para sincronizar operaciones de inventario desde dispositivos Android/iOS.',
        impact:
            'Digitalización del flujo de bodega en Comunix con una app multiplataforma mantenible sobre Dart/Flutter.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Warehouse and inventory processes relied on manual workflows and tools poorly suited to mobile field operations.',
        solution:
            'Built Bodecom in Flutter with REST API and Firebase integration to sync inventory operations from Android/iOS devices.',
        impact:
            'Digitized Comunix warehouse workflows with a maintainable cross-platform Dart/Flutter app.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.navipuntos,
    title: 'navipuntos',
    company: 'Comunix S.A.S',
    categoryLabel: 'Mobile · Android',
    yearLabel: '2020',
    filterCategory: BentoProjectFilter.mobile,
    imageAsset: 'assets/slide/navi.jpeg',
    stack: const ['Java', 'Android Studio', 'REST APIs'],
    cardTags: const ['Java', 'Android Studio', 'REST APIs'],
    description: _t(
      'Aplicación para navegación y puntos de interés con puzzles interactivos, APIs REST y lineamientos UX/UI del equipo de diseño (Comunix).',
      'App for navigation and points of interest with interactive puzzles, REST APIs, and UX/UI guidelines from the design team (Comunix).',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Se necesitaba una app móvil que ofreciera información y navegación a puntos de interés, incluyendo componentes lúdicos (puzzles) para engagement.',
        solution:
            'Implementación frontend Android (Java) con consumo de APIs REST y puzzles interactivos, alineada a los lineamientos UX/UI de Comunix.',
        impact:
            'Entrega de Navipuntos como producto de navegación a puntos de interés con experiencia interactiva y backend PHP asociado en el mismo ciclo Comunix.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'A mobile app was needed to provide information and navigation to points of interest, including playful puzzle components for engagement.',
        solution:
            'Implemented an Android (Java) frontend consuming REST APIs with interactive puzzles, following Comunix UX/UI guidelines.',
        impact:
            'Shipped Navipuntos as a points-of-interest navigation product with an interactive experience and related PHP APIs in the same Comunix cycle.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.neat,
    title: 'Neat',
    company: 'RedCap S.A.S',
    categoryLabel: 'Mobile · Flutter',
    yearLabel: '2022',
    filterCategory: BentoProjectFilter.mobile,
    imageAsset: 'assets/slide/neat.jpeg',
    stack: const ['Flutter', 'Dart', 'REST APIs'],
    cardTags: const ['Flutter', 'Dart', 'REST APIs'],
    description: _t(
      'Desarrollo inicial de aplicación móvil Flutter para casa de apuestas (RedCap), con APIs REST, cumplimiento UX/UI y distribución interna vía TestFlight.',
      'Initial Flutter mobile app development for a betting house (RedCap), with REST APIs, UX/UI compliance, and internal distribution via TestFlight.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'RedCap requería el arranque de una app móvil para casa de apuestas con integración a APIs del back-end y validación interna en iOS.',
        solution:
            'Desarrollo Flutter consumiendo APIs REST, respetando lineamientos UX/UI del equipo de diseño y publicando builds en TestFlight para pruebas internas.',
        impact:
            'Base móvil lista para iteración de producto, con canal de prueba interno iOS y contratos REST estabilizados en el frontend.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'RedCap needed to kick off a betting-house mobile app with backend API integration and internal iOS validation.',
        solution:
            'Built a Flutter client consuming REST APIs, following design-team UX/UI guidelines, and publishing builds to TestFlight for internal testing.',
        impact:
            'Established a mobile foundation for product iteration, with an iOS internal test channel and stabilized REST contracts on the frontend.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.adomiPedidos,
    title: 'Adomi Pedidos',
    company: 'Adomi APP',
    categoryLabel: 'Mobile · Flutter',
    yearLabel: '2021 — 2022',
    filterCategory: BentoProjectFilter.mobile,
    imageAsset: 'assets/slide/pedidos.jpeg',
    stack: const ['Flutter', 'Dart', 'Google Maps', 'REST APIs'],
    cardTags: const ['Flutter', 'Google Maps', 'REST APIs'],
    description: _t(
      'App para clientes de la plataforma de delivery Adomi: pedidos, mapas, ubicación en tiempo real e integración con APIs y pasarela de pago.',
      'Customer app for the Adomi delivery platform: orders, maps, real-time location, and integration with APIs and a payment gateway.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'La startup Adomi necesitaba una app de pedidos para clientes con mapas, ubicación en tiempo real y flujo de pago confiable.',
        solution:
            'Frontend Flutter con Google Maps, APIs REST, deep links, push notifications, analytics e integración de pasarela de pago; refactor de UX/UI.',
        impact:
            'App de clientes publicada en App Store y Play Store como parte del ecosistema Adomi (Pedidos / Aliados / Drivers).',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Startup Adomi needed a customer ordering app with maps, real-time location, and a reliable payment flow.',
        solution:
            'Flutter frontend with Google Maps, REST APIs, deep links, push notifications, analytics, and payment-gateway integration; UX/UI refactor.',
        impact:
            'Customer app published on the App Store and Play Store as part of the Adomi ecosystem (Orders / Allies / Drivers).',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.adomiAliados,
    title: 'Adomi Aliados',
    company: 'Adomi APP',
    categoryLabel: 'Mobile · Flutter',
    yearLabel: '2021 — 2022',
    filterCategory: BentoProjectFilter.mobile,
    imageAsset: 'assets/slide/aliados.jpeg',
    stack: const ['Flutter', 'Dart', 'REST APIs', 'Firebase'],
    cardTags: const ['Flutter', 'Firebase', 'REST APIs'],
    description: _t(
      'App para restaurantes aliados de Adomi: operación de pedidos, integración REST/Firebase y mejoras de UX/UI en el ecosistema de delivery.',
      'App for Adomi partner restaurants: order operations, REST/Firebase integration, and UX/UI improvements across the delivery ecosystem.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Los restaurantes aliados requerían una app dedicada para gestionar pedidos y operar dentro del ecosistema Adomi.',
        solution:
            'Desarrollo Flutter (Aliados) con APIs REST, Firebase, notificaciones y refactor de diseño para mejorar la experiencia del aliado comercial.',
        impact:
            'Segunda app del trío Adomi publicada en tiendas, habilitando el canal restaurantes del marketplace de delivery.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Partner restaurants needed a dedicated app to manage orders and operate inside the Adomi ecosystem.',
        solution:
            'Flutter (Allies) development with REST APIs, Firebase, notifications, and a design refactor to improve the partner experience.',
        impact:
            'Second Adomi app published on the stores, enabling the restaurant channel of the delivery marketplace.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.gesport,
    title: 'Gesport',
    company: 'Comunix S.A.S',
    categoryLabel: 'Mobile · Android',
    yearLabel: '2020',
    filterCategory: BentoProjectFilter.mobile,
    imageAsset: 'assets/slide/gessport.jpeg',
    stack: const ['Java', 'Android Studio', 'PHP'],
    cardTags: const ['Java', 'Android Studio', 'PHP'],
    description: _t(
      'Aplicación Android (Indeportes Cauca / Gesport) para gestionar escenarios deportivos, con frontend Java y APIs PHP en Comunix.',
      'Android app (Indeportes Cauca / Gesport) to manage sports venues, with a Java frontend and PHP APIs at Comunix.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Indeportes Cauca necesitaba digitalizar la gestión de escenarios deportivos del departamento con una app móvil.',
        solution:
            'Desarrollo completo móvil (frontend Java/Android Studio y backend PHP) siguiendo lineamientos UX/UI del equipo de diseño de Comunix.',
        impact:
            'Herramienta operativa para administración de escenarios deportivos entregada como producto Gesport / Indeportes Cauca.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'Indeportes Cauca needed to digitize sports-venue management across the department with a mobile app.',
        solution:
            'Full mobile delivery (Java/Android Studio frontend and PHP backend) following Comunix design-team UX/UI guidelines.',
        impact:
            'Operational tool for sports-venue administration delivered as the Gesport / Indeportes Cauca product.',
      ),
    },
  ),
  ProjectItem(
    id: BentoProjectId.portfolio,
    title: 'Portfolio',
    company: 'LeanSanchez-Dev',
    categoryLabel: 'Full-Stack / Web · Flutter',
    yearLabel: '2024+',
    filterCategory: BentoProjectFilter.fullstack,
    imageAsset: 'assets/slide/portafolio.jpeg',
    liveUrl: 'https://portfolio-lean-dev.web.app',
    repoUrl: 'https://github.com/leanSanchez-Dev',
    stack: const ['Flutter', 'Dart', 'Flutter Web', 'Firebase'],
    cardTags: const ['Flutter Web', 'Firebase', 'Dart'],
    description: _t(
      'Portafolio web desarrollado con Flutter para mostrar proyectos y habilidades profesionales, desplegado en Firebase Hosting.',
      'Web portfolio built with Flutter to showcase projects and professional skills, deployed on Firebase Hosting.',
    ),
    caseStudy: const {
      PortfolioLanguage.es: CaseStudyContent(
        problem:
            'Se necesitaba una vitrina personal responsive que unificara proyectos, experiencia y contacto sin depender de un CMS externo.',
        solution:
            'Portafolio Flutter Web con hosting en Firebase, assets propios y estructura de contenido local tipada (lean.dev).',
        impact:
            'Sitio live en https://portfolio-lean-dev.web.app con código en GitHub (leanSanchez-Dev) como carta de presentación profesional.',
      ),
      PortfolioLanguage.en: CaseStudyContent(
        problem:
            'A responsive personal showcase was needed to unify projects, experience, and contact without relying on an external CMS.',
        solution:
            'Flutter Web portfolio on Firebase Hosting with owned assets and typed local content structure (lean.dev).',
        impact:
            'Live site at https://portfolio-lean-dev.web.app with GitHub (leanSanchez-Dev) as a professional calling card.',
      ),
    },
  ),
];

/// Orden cronológico descendente: Sunset (actual) → FUNDASER → CODESA cerrado → legacy.
final List<ExperienceItem> _experiences = [
  ExperienceItem(
    role: _t(
      'Desarrollador Full Stack',
      'Full Stack Developer',
    ),
    company: 'Sunset Software House',
    period: _t('Dic 2025 — Actualmente', 'Dec 2025 — Currently'),
    description: _t(
      'Desarrollo de productos Full Stack Angular/Java para clientes de Sunset; actualmente Fisioterapp.',
      'Building Full Stack Angular/Java products for Sunset clients; currently Fisioterapp.',
    ),
    technologies: const [
      'Angular 21',
      'Spring Boot 3',
      'Java 17',
      'PostgreSQL',
      'Nx',
      'Module Federation',
      'JWT',
      'Docker',
      'GitLab CI/CD',
    ],
    isCurrent: true,
    responsibilities: [
      _resp(
        'Entrega Full Stack en productos Angular y Spring Boot para clientes de Sunset',
        'Full Stack delivery on Angular and Spring Boot products for Sunset clients',
      ),
    ],
    engagements: [
      ExperienceEngagement(
        title: _t('Fisioterapp', 'Fisioterapp'),
        period: _t('Dic 2025 — Actualmente', 'Dec 2025 — Currently'),
        isActive: true,
        description: _t(
          'Plataforma SaaS multitenant clínicas fisioterapia — Angular 21 (Material, Tailwind, Signals) + Spring Boot 3 / Java 17 (hexagonal + CQRS, PostgreSQL, JWT).',
          'Multitenant SaaS platform for physiotherapy clinics — Angular 21 (Material, Tailwind, Signals) + Spring Boot 3 / Java 17 (hexagonal + CQRS, PostgreSQL, JWT).',
        ),
        technologies: const [
          'Angular 21',
          'Material',
          'Tailwind',
          'Signals',
          'Java 17',
          'Spring Boot 3',
          'PostgreSQL',
          'JWT',
          'WebSocket',
          'DigitalOcean Spaces',
        ],
        responsibilities: [
          _resp(
            'Pacientes, agenda, historia clínica y reportes',
            'Patients, scheduling, clinical history, and reports',
          ),
          _resp(
            'APIs REST securizadas',
            'Secured REST APIs',
          ),
          _resp(
            'WebSocket, correo y DigitalOcean Spaces',
            'WebSocket, email, and DigitalOcean Spaces',
          ),
        ],
      ),
      ExperienceEngagement(
        title: _t('Cliente Quipux', 'Quipux Client'),
        period: _t('Dic 2025 — Sep 2026', 'Dec 2025 — Sep 2026'),
        isActive: false,
        description: _t(
          'Backoffice de cobro coactivo con microfrontends Angular 19 (Nx, Module Federation, NgRx, PrimeNG) y backend Java 21 / Spring Boot 3 (QITS, Jersey, Oracle, JWT, RabbitMQ).',
          'Coercive-collection backoffice with Angular 19 microfrontends (Nx, Module Federation, NgRx, PrimeNG) and a Java 21 / Spring Boot 3 backend (QITS, Jersey, Oracle, JWT, RabbitMQ).',
        ),
        technologies: const [
          'Angular 19',
          'Nx',
          'Module Federation',
          'NgRx',
          'PrimeNG',
          'Java 21',
          'Spring Boot 3',
          'Oracle',
          'JWT',
          'RabbitMQ',
          'Docker',
          'GitLab CI/CD',
        ],
        responsibilities: [
          _resp(
            'Módulos de cartera, títulos judiciales, reportes y notificaciones',
            'Portfolio, judicial titles, reports, and notifications modules',
          ),
          _resp(
            'APIs REST y seguridad JWT',
            'REST APIs and JWT security',
          ),
          _resp(
            'Pipelines GitLab CI/CD y Docker',
            'GitLab CI/CD pipelines and Docker',
          ),
        ],
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador Full Stack',
      'Full Stack Developer',
    ),
    company: 'FUNDASER — Proyecto independiente',
    period: _t('2026', '2026'),
    description: _t(
      'Plataforma integral operador ICBF (internado 24/7): portal, turnos, asistencia PWA, pre-nómina, bóveda documental. Next.js 15, React 19, TypeScript, Supabase (PostgreSQL, RLS, Edge Functions), Tailwind/Shadcn, PWA Serwist.',
      'End-to-end platform for an ICBF operator (24/7 residential care): portal, shifts, PWA attendance, pre-payroll, document vault. Next.js 15, React 19, TypeScript, Supabase (PostgreSQL, RLS, Edge Functions), Tailwind/Shadcn, PWA Serwist.',
    ),
    technologies: const [
      'Next.js 15',
      'React 19',
      'TypeScript',
      'Supabase',
      'PostgreSQL',
      'Tailwind',
      'Shadcn',
      'PWA',
      'Serwist',
    ],
    isCurrent: false,
    responsibilities: [
      _resp(
        'Entrega end-to-end: auth RBAC, CMS, motor de turnos, marcación GPS/QR offline, liquidación horaria y certificados QR',
        'End-to-end delivery: RBAC auth, CMS, shift engine, offline GPS/QR check-in, hourly settlement, and QR certificates',
      ),
      _resp(
        'Esquema RLS orientado al cumplimiento ICBF',
        'RLS schema oriented to ICBF compliance',
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador FullStack Flutter',
      'FullStack Flutter Developer',
    ),
    company: 'CODESA S.A.',
    period: _t('May 2024 — Nov 2025', 'May 2024 — Nov 2025'),
    description: _t(
      'Desarrollador Full Stack especializado en Flutter y Angular',
      'Full Stack Developer specialized in Flutter and Angular',
    ),
    technologies: const [
      'Flutter',
      'Angular',
      'Android Nativo',
      'JavaScript',
      'Dart',
    ],
    isCurrent: false,
    responsibilities: [
      _resp(
        'Resolución de bugs en aplicaciones desarrolladas en Flutter y Angular',
        'Bug resolution in applications developed in Flutter and Angular',
      ),
      _resp(
        'Desarrollo e integración de funcionalidades en Flutter y Android nativo para impresión en impresoras térmicas POS',
        'Development and integration of functionalities in Flutter and native Android for thermal POS printer printing',
      ),
      _resp(
        'Implementación de comunicación entre Angular y Flutter mediante FlutterChannel y JavascriptChannel',
        'Implementation of communication between Angular and Flutter using FlutterChannel and JavascriptChannel',
      ),
      _resp(
        'Asegurar rendimiento eficiente y correcta configuración del hardware',
        'Ensure efficient performance and correct hardware configuration',
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador Frontend Flutter',
      'Frontend Flutter Developer',
    ),
    company: 'TCS - Bancolombia',
    period: _t('Nov 2022 — Ene 2024', 'Nov 2022 — Jan 2024'),
    description: _t(
      'Desarrollador frontend del sistema de diseño de Bancolombia',
      "Frontend developer of Bancolombia's design system",
    ),
    technologies: const ['Flutter', 'Dart', 'Atomic Design', 'Testing'],
    responsibilities: [
      _resp(
        'Desarrollo de widgets (átomos, moléculas, organismos, templates y páginas) según la asignación de HU',
        'Development of widgets (atoms, molecules, organisms, templates and pages) according to User Story assignment',
      ),
      _resp(
        'Implementación de Atomic Design',
        'Implementation of Atomic Design',
      ),
      _resp(
        'Soporte de incidentes del Sistema de diseño',
        'Design System incident support',
      ),
      _resp(
        'Unit Test, Widget Test y Golden Test',
        'Unit Test, Widget Test and Golden Test',
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador Mobile Flutter',
      'Mobile Flutter Developer',
    ),
    company: 'RedCap S.A.S',
    period: _t('Jun 2022 — Oct 2022', 'Jun 2022 — Oct 2022'),
    description: _t(
      'Desarrollo inicial de aplicación móvil para casa de apuestas',
      'Initial development of mobile application for betting house',
    ),
    technologies: const ['Flutter', 'Dart', 'REST APIs', 'TestFlight'],
    responsibilities: [
      _resp(
        'Implementación de APIs REST proporcionadas por el back-end',
        'Implementation of REST APIs provided by the back-end',
      ),
      _resp(
        'Cumplimiento con los lineamientos de UX/UI del equipo de diseño',
        'Compliance with UX/UI guidelines from the design team',
      ),
      _resp(
        'Publicar en TestFlight para test interno de la app',
        'Publish to TestFlight for internal app testing',
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador Frontend Mobile',
      'Mobile Frontend Developer',
    ),
    company: 'Adomi App (Startup)',
    period: _t('Abr 2021 — May 2022', 'Apr 2021 — May 2022'),
    description: _t(
      'Desarrollo de tres aplicaciones móviles para startup de delivery',
      'Development of three mobile applications for delivery startup',
    ),
    technologies: const [
      'Flutter',
      'Swift',
      'Kotlin',
      'Google Maps',
      'Push Notifications',
      'Analytics',
      'Payment Gateway',
    ],
    responsibilities: [
      _resp(
        'Implementación de las APIs para el funcionamiento de las aplicaciones',
        'Implementation of APIs for application functionality',
      ),
      _resp(
        'Refactorización del diseño de las aplicaciones para mejorar la UX/UI',
        'Refactoring of application design to improve UX/UI',
      ),
      _resp(
        'Implementación de Google Maps y ubicación en tiempo real',
        'Implementation of Google Maps and real-time location',
      ),
      _resp(
        'Integración de Deep links, Push Notifications y Analytics',
        'Integration of Deep links, Push Notifications and Analytics',
      ),
      _resp(
        'Integración de pasarela de pago',
        'Payment gateway integration',
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador Mobile Flutter',
      'Mobile Flutter Developer',
    ),
    company: 'Comunix S.A.S',
    period: _t('Ago 2020 — Nov 2020', 'Aug 2020 — Nov 2020'),
    description: _t(
      'Desarrollo de aplicaciones móviles para entidades públicas y navegación',
      'Development of mobile applications for public entities and navigation',
    ),
    technologies: const [
      'Flutter',
      'Android Studio',
      'PHP',
      'Dart',
      'Java',
    ],
    responsibilities: [
      _resp(
        'Desarrollo completo de las aplicaciones móviles (front-end y back-end)',
        'Complete development of mobile applications (front-end and back-end)',
      ),
      _resp(
        'Implementación de APIs en PHP para Navipuntos',
        'Implementation of PHP APIs for Navipuntos',
      ),
      _resp(
        'Desarrollar puzzles para app Navipuntos',
        'Develop puzzles for Navipuntos app',
      ),
      _resp(
        'Seguimiento de los lineamientos de UX/UI proporcionados por el equipo de diseño',
        'Follow UX/UI guidelines provided by the design team',
      ),
    ],
  ),
  ExperienceItem(
    role: _t(
      'Desarrollador Mobile Android',
      'Mobile Android Developer',
    ),
    company: 'Comunix S.A.S',
    period: _t('Nov 2019 — Dic 2019', 'Nov 2019 — Dec 2019'),
    description: _t(
      'Desarrollo frontend móvil en Java Android',
      'Mobile frontend development in Java Android',
    ),
    technologies: const ['Java', 'Android Studio'],
    responsibilities: const [],
  ),
  ExperienceItem(
    role: _t(
      'Aprendiz SENA - Soporte Técnico',
      'SENA Apprentice - Technical Support',
    ),
    company: 'Banco Mundo Mujer',
    period: _t('Abr 2019 — Oct 2019', 'Apr 2019 — Oct 2019'),
    description: _t(
      'Soporte técnico y mantenimiento de sistemas',
      'Technical support and systems maintenance',
    ),
    technologies: const [],
    responsibilities: [
      _resp(
        'Soporte técnico a usuarios',
        'Technical support to users',
      ),
      _resp(
        'Mantenimiento de equipos de cómputo',
        'Computer equipment maintenance',
      ),
      _resp(
        'Resolución de incidencias técnicas',
        'Technical incident resolution',
      ),
    ],
  ),
];
