class Experience {
  final String cargo;
  final String empresa;
  final String fechaInicio;
  final String fechaFin;
  final String descripcion;
  final List<String>? proyectos;
  final List<String>? responsabilidades;
  final List<String>? tecnologias;

  Experience({
    required this.cargo,
    required this.empresa,
    required this.fechaInicio,
    required this.fechaFin,
    required this.descripcion,
    this.proyectos,
    this.responsabilidades,
    this.tecnologias,
  });

  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      cargo: json['cargo'],
      empresa: json['empresa'],
      fechaInicio: json['fecha_inicio'],
      fechaFin: json['fecha_fin'],
      descripcion: json['descripcion'],
      proyectos: json['proyectos'] != null 
          ? List<String>.from(json['proyectos']) 
          : null,
      responsabilidades: json['responsabilidades'] != null 
          ? List<String>.from(json['responsabilidades']) 
          : null,
      tecnologias: json['tecnologias'] != null 
          ? List<String>.from(json['tecnologias']) 
          : null,
    );
  }
}

List<Map<String, dynamic>> jsonStr = [
  {
    "cargo": "Desarrollador FullStack Flutter",
    "empresa": "CODESA S.A.",
    "fecha_inicio": "May 2024",
    "fecha_fin": "Actualmente",
    "descripcion": "Desarrollador Full Stack especializado en Flutter y Angular",
    "responsabilidades": [
      "Resolución de bugs en aplicaciones desarrolladas en Flutter y Angular",
      "Desarrollo e integración de funcionalidades en Flutter y Android nativo para impresión en impresoras térmicas POS",
      "Implementación de comunicación entre Angular y Flutter mediante FlutterChannel y JavascriptChannel",
      "Asegurar rendimiento eficiente y correcta configuración del hardware"
    ],
    "tecnologias": ["Flutter", "Angular", "Android Nativo", "JavaScript", "Dart"]
  },
  {
    "cargo": "Desarrollador Frontend Flutter",
    "empresa": "TCS - Bancolombia",
    "fecha_inicio": "Nov 2022",
    "fecha_fin": "Ene 2024",
    "descripcion": "Desarrollador frontend del sistema de diseño de Bancolombia",
    "proyectos": [
      "Sistema de Diseño Bancolombia - Desarrollo de componentes reutilizables"
    ],
    "responsabilidades": [
      "Desarrollo de widgets (átomos, moléculas, organismos, templates y páginas) según la asignación de HU",
      "Implementación de Atomic Design",
      "Soporte de incidentes del Sistema de diseño",
      "Unit Test, Widget Test y Golden Test"
    ],
    "tecnologias": ["Flutter", "Dart", "Atomic Design", "Testing"]
  },
  {
    "cargo": "Desarrollador Mobile Flutter",
    "empresa": "RedCap S.A.S",
    "fecha_inicio": "Jun 2022",
    "fecha_fin": "Oct 2022",
    "descripcion": "Desarrollo inicial de aplicación móvil para casa de apuestas",
    "proyectos": [
      "Aplicación móvil para casa de apuestas"
    ],
    "responsabilidades": [
      "Implementación de APIs REST proporcionadas por el back-end",
      "Cumplimiento con los lineamientos de UX/UI del equipo de diseño",
      "Publicar en TestFlight para test interno de la app"
    ],
    "tecnologias": ["Flutter", "Dart", "REST APIs", "TestFlight"]
  },
  {
    "cargo": "Desarrollador Frontend Mobile",
    "empresa": "Adomi App (Startup)",
    "fecha_inicio": "Abr 2021",
    "fecha_fin": "May 2022",
    "descripcion": "Desarrollo de tres aplicaciones móviles para startup de delivery",
    "proyectos": [
      "Adomi Pedidos - App para clientes",
      "Adomi Aliados - App para restaurantes",
      "Adomi Drivers - App para repartidores"
    ],
    "responsabilidades": [
      "Implementación de las APIs para el funcionamiento de las aplicaciones",
      "Refactorización del diseño de las aplicaciones para mejorar la UX/UI",
      "Implementación de Google Maps y ubicación en tiempo real",
      "Integración de Deep links, Push Notifications y Analytics",
      "Integración de pasarela de pago"
    ],
    "tecnologias": ["Flutter", "Swift", "Kotlin", "Google Maps", "Push Notifications", "Analytics", "Payment Gateway"]
  },
  {
    "cargo": "Desarrollador Mobile Flutter",
    "empresa": "Comunix S.A.S",
    "fecha_inicio": "Ago 2020",
    "fecha_fin": "Nov 2020",
    "descripcion": "Desarrollo de aplicaciones móviles para entidades públicas y navegación",
    "proyectos": [
      "Indeportes Cauca (Android Studio) - Gestión de escenarios deportivos",
      "Navipuntos (Flutter) - Información y navegación a puntos de interés"
    ],
    "responsabilidades": [
      "Desarrollo completo de las aplicaciones móviles (front-end y back-end)",
      "Implementación de APIs en PHP para Navipuntos",
      "Desarrollar puzzles para app Navipuntos",
      "Seguimiento de los lineamientos de UX/UI proporcionados por el equipo de diseño"
    ],
    "tecnologias": ["Flutter", "Android Studio", "PHP", "Dart", "Java"]
  },
  {
    "cargo": "Desarrollador Mobile Android",
    "empresa": "Comunix S.A.S",
    "fecha_inicio": "Nov 2019",
    "fecha_fin": "Dic 2019",
    "descripcion": "Desarrollo frontend móvil en Java Android",
    "tecnologias": ["Java", "Android Studio"]
  },
  {
    "cargo": "Aprendiz SENA - Soporte Técnico",
    "empresa": "Banco Mundo Mujer",
    "fecha_inicio": "Abr 2019",
    "fecha_fin": "Oct 2019",
    "descripcion": "Soporte técnico y mantenimiento de sistemas",
    "responsabilidades": [
      "Soporte técnico a usuarios",
      "Mantenimiento de equipos de cómputo",
      "Resolución de incidencias técnicas"
    ]
  }
];
