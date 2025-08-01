import 'package:flutter/material.dart';

class Experience {
  final String cargo;
  final String empresa;
  final String fechaInicio;
  final String fechaFin;
  final String descripcion;
  final List<String>? proyectos;
  final List<String>? responsabilidades;
  final List<String>? tecnologias;
  
  // Versiones en inglés
  final String? cargoEn;
  final String? fechaInicioEn;
  final String? fechaFinEn;
  final String? descripcionEn;
  final List<String>? proyectosEn;
  final List<String>? responsabilidadesEn;

  Experience({
    required this.cargo,
    required this.empresa,
    required this.fechaInicio,
    required this.fechaFin,
    required this.descripcion,
    this.proyectos,
    this.responsabilidades,
    this.tecnologias,
    this.cargoEn,
    this.fechaInicioEn,
    this.fechaFinEn,
    this.descripcionEn,
    this.proyectosEn,
    this.responsabilidadesEn,
  });

  // Métodos para obtener texto localizado
  String getLocalizedCargo(Locale locale) {
    return locale.languageCode == 'en' && cargoEn != null ? cargoEn! : cargo;
  }
  
  String getLocalizedFechaInicio(Locale locale) {
    return locale.languageCode == 'en' && fechaInicioEn != null ? fechaInicioEn! : fechaInicio;
  }
  
  String getLocalizedFechaFin(Locale locale) {
    return locale.languageCode == 'en' && fechaFinEn != null ? fechaFinEn! : fechaFin;
  }
  
  String getLocalizedDescripcion(Locale locale) {
    return locale.languageCode == 'en' && descripcionEn != null ? descripcionEn! : descripcion;
  }
  
  List<String>? getLocalizedProyectos(Locale locale) {
    return locale.languageCode == 'en' && proyectosEn != null ? proyectosEn : proyectos;
  }
  
  List<String>? getLocalizedResponsabilidades(Locale locale) {
    return locale.languageCode == 'en' && responsabilidadesEn != null ? responsabilidadesEn : responsabilidades;
  }

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
      cargoEn: json['cargo_en'],
      fechaInicioEn: json['fecha_inicio_en'],
      fechaFinEn: json['fecha_fin_en'],
      descripcionEn: json['descripcion_en'],
      proyectosEn: json['proyectos_en'] != null 
          ? List<String>.from(json['proyectos_en']) 
          : null,
      responsabilidadesEn: json['responsabilidades_en'] != null 
          ? List<String>.from(json['responsabilidades_en']) 
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
    "cargo_en": "FullStack Flutter Developer",
    "fecha_inicio_en": "May 2024",
    "fecha_fin_en": "Currently",
    "descripcion_en": "Full Stack Developer specialized in Flutter and Angular",
    "responsabilidades": [
      "Resolución de bugs en aplicaciones desarrolladas en Flutter y Angular",
      "Desarrollo e integración de funcionalidades en Flutter y Android nativo para impresión en impresoras térmicas POS",
      "Implementación de comunicación entre Angular y Flutter mediante FlutterChannel y JavascriptChannel",
      "Asegurar rendimiento eficiente y correcta configuración del hardware"
    ],
    "responsabilidades_en": [
      "Bug resolution in applications developed in Flutter and Angular",
      "Development and integration of functionalities in Flutter and native Android for thermal POS printer printing",
      "Implementation of communication between Angular and Flutter using FlutterChannel and JavascriptChannel",
      "Ensure efficient performance and correct hardware configuration"
    ],
    "tecnologias": ["Flutter", "Angular", "Android Nativo", "JavaScript", "Dart"]
  },
  {
    "cargo": "Desarrollador Frontend Flutter",
    "empresa": "TCS - Bancolombia",
    "fecha_inicio": "Nov 2022",
    "fecha_fin": "Ene 2024",
    "descripcion": "Desarrollador frontend del sistema de diseño de Bancolombia",
    "cargo_en": "Frontend Flutter Developer",
    "fecha_inicio_en": "Nov 2022",
    "fecha_fin_en": "Jan 2024",
    "descripcion_en": "Frontend developer of Bancolombia's design system",
    "proyectos": [
      "Sistema de Diseño Bancolombia - Desarrollo de componentes reutilizables"
    ],
    "proyectos_en": [
      "Bancolombia Design System - Development of reusable components"
    ],
    "responsabilidades": [
      "Desarrollo de widgets (átomos, moléculas, organismos, templates y páginas) según la asignación de HU",
      "Implementación de Atomic Design",
      "Soporte de incidentes del Sistema de diseño",
      "Unit Test, Widget Test y Golden Test"
    ],
    "responsabilidades_en": [
      "Development of widgets (atoms, molecules, organisms, templates and pages) according to User Story assignment",
      "Implementation of Atomic Design",
      "Design System incident support",
      "Unit Test, Widget Test and Golden Test"
    ],
    "tecnologias": ["Flutter", "Dart", "Atomic Design", "Testing"]
  },
  {
    "cargo": "Desarrollador Mobile Flutter",
    "empresa": "RedCap S.A.S",
    "fecha_inicio": "Jun 2022",
    "fecha_fin": "Oct 2022",
    "descripcion": "Desarrollo inicial de aplicación móvil para casa de apuestas",
    "cargo_en": "Mobile Flutter Developer",
    "fecha_inicio_en": "Jun 2022",
    "fecha_fin_en": "Oct 2022",
    "descripcion_en": "Initial development of mobile application for betting house",
    "proyectos": [
      "Aplicación móvil para casa de apuestas"
    ],
    "proyectos_en": [
      "Mobile application for betting house"
    ],
    "responsabilidades": [
      "Implementación de APIs REST proporcionadas por el back-end",
      "Cumplimiento con los lineamientos de UX/UI del equipo de diseño",
      "Publicar en TestFlight para test interno de la app"
    ],
    "responsabilidades_en": [
      "Implementation of REST APIs provided by the back-end",
      "Compliance with UX/UI guidelines from the design team",
      "Publish to TestFlight for internal app testing"
    ],
    "tecnologias": ["Flutter", "Dart", "REST APIs", "TestFlight"]
  },
  {
    "cargo": "Desarrollador Frontend Mobile",
    "empresa": "Adomi App (Startup)",
    "fecha_inicio": "Abr 2021",
    "fecha_fin": "May 2022",
    "descripcion": "Desarrollo de tres aplicaciones móviles para startup de delivery",
    "cargo_en": "Mobile Frontend Developer",
    "fecha_inicio_en": "Apr 2021",
    "fecha_fin_en": "May 2022",
    "descripcion_en": "Development of three mobile applications for delivery startup",
    "proyectos": [
      "Adomi Pedidos - App para clientes",
      "Adomi Aliados - App para restaurantes",
      "Adomi Drivers - App para repartidores"
    ],
    "proyectos_en": [
      "Adomi Pedidos - Customer app",
      "Adomi Aliados - Restaurant app",
      "Adomi Drivers - Delivery drivers app"
    ],
    "responsabilidades": [
      "Implementación de las APIs para el funcionamiento de las aplicaciones",
      "Refactorización del diseño de las aplicaciones para mejorar la UX/UI",
      "Implementación de Google Maps y ubicación en tiempo real",
      "Integración de Deep links, Push Notifications y Analytics",
      "Integración de pasarela de pago"
    ],
    "responsabilidades_en": [
      "Implementation of APIs for application functionality",
      "Refactoring of application design to improve UX/UI",
      "Implementation of Google Maps and real-time location",
      "Integration of Deep links, Push Notifications and Analytics",
      "Payment gateway integration"
    ],
    "tecnologias": ["Flutter", "Swift", "Kotlin", "Google Maps", "Push Notifications", "Analytics", "Payment Gateway"]
  },
  {
    "cargo": "Desarrollador Mobile Flutter",
    "empresa": "Comunix S.A.S",
    "fecha_inicio": "Ago 2020",
    "fecha_fin": "Nov 2020",
    "descripcion": "Desarrollo de aplicaciones móviles para entidades públicas y navegación",
    "cargo_en": "Mobile Flutter Developer",
    "fecha_inicio_en": "Aug 2020",
    "fecha_fin_en": "Nov 2020",
    "descripcion_en": "Development of mobile applications for public entities and navigation",
    "proyectos": [
      "Indeportes Cauca (Android Studio) - Gestión de escenarios deportivos",
      "Navipuntos (Flutter) - Información y navegación a puntos de interés"
    ],
    "proyectos_en": [
      "Indeportes Cauca (Android Studio) - Sports venue management",
      "Navipuntos (Flutter) - Information and navigation to points of interest"
    ],
    "responsabilidades": [
      "Desarrollo completo de las aplicaciones móviles (front-end y back-end)",
      "Implementación de APIs en PHP para Navipuntos",
      "Desarrollar puzzles para app Navipuntos",
      "Seguimiento de los lineamientos de UX/UI proporcionados por el equipo de diseño"
    ],
    "responsabilidades_en": [
      "Complete development of mobile applications (front-end and back-end)",
      "Implementation of PHP APIs for Navipuntos",
      "Develop puzzles for Navipuntos app",
      "Follow UX/UI guidelines provided by the design team"
    ],
    "tecnologias": ["Flutter", "Android Studio", "PHP", "Dart", "Java"]
  },
  {
    "cargo": "Desarrollador Mobile Android",
    "empresa": "Comunix S.A.S",
    "fecha_inicio": "Nov 2019",
    "fecha_fin": "Dic 2019",
    "descripcion": "Desarrollo frontend móvil en Java Android",
    "cargo_en": "Mobile Android Developer",
    "fecha_inicio_en": "Nov 2019",
    "fecha_fin_en": "Dec 2019",
    "descripcion_en": "Mobile frontend development in Java Android",
    "tecnologias": ["Java", "Android Studio"]
  },
  {
    "cargo": "Aprendiz SENA - Soporte Técnico",
    "empresa": "Banco Mundo Mujer",
    "fecha_inicio": "Abr 2019",
    "fecha_fin": "Oct 2019",
    "descripcion": "Soporte técnico y mantenimiento de sistemas",
    "cargo_en": "SENA Apprentice - Technical Support",
    "fecha_inicio_en": "Apr 2019",
    "fecha_fin_en": "Oct 2019",
    "descripcion_en": "Technical support and systems maintenance",
    "responsabilidades": [
      "Soporte técnico a usuarios",
      "Mantenimiento de equipos de cómputo",
      "Resolución de incidencias técnicas"
    ],
    "responsabilidades_en": [
      "Technical support to users",
      "Computer equipment maintenance",
      "Technical incident resolution"
    ]
  }
];
