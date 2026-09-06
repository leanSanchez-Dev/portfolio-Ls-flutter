/// Datasource local de proyectos.
///
/// Hoy los datos son una lista en memoria; si mañana pasan a un asset JSON o a
/// Firestore, solo cambia esta clase (o se añade otra implementación) sin tocar
/// dominio ni presentación.
abstract class ProjectsDataSource {
  /// Devuelve los proyectos en formato crudo (JSON-like).
  List<Map<String, dynamic>> fetchProjects();
}

class ProjectsLocalDataSource implements ProjectsDataSource {
  const ProjectsLocalDataSource();

  @override
  List<Map<String, dynamic>> fetchProjects() => jsonPj;
}

/// Datos crudos de los proyectos del portafolio.
///
/// `tecnologias[0]` es la tecnología principal (la que la UI muestra como badge
/// destacado) y coincide con el antiguo campo `tag`.
const List<Map<String, dynamic>> jsonPj = [
  {
    "project": "Bodecom",
    "empresa": "Comunix S.A.S",
    "tecnologias": ["Flutter", "Dart", "REST APIs", "Firebase"],
    "url": "assets/slide/bodecom.jpeg",
  },
  {
    "project": "navipuntos",
    "empresa": "Comunix S.A.S",
    "tecnologias": ["Java", "Android Studio", "REST APIs"],
    "url": "assets/slide/navi.jpeg",
  },
  {
    "project": "Neat",
    "empresa": "RedCap S.A.S",
    "tecnologias": ["Flutter", "Dart", "REST APIs"],
    "url": "assets/slide/neat.jpeg",
  },
  {
    "project": "Adomi Pedidos",
    "empresa": "Adomi APP",
    "tecnologias": ["Flutter", "Dart", "Google Maps", "REST APIs"],
    "url": "assets/slide/pedidos.jpeg",
  },
  {
    "project": "Adomi Aliados",
    "empresa": "Adomi APP",
    "tecnologias": ["Flutter", "Dart", "REST APIs", "Firebase"],
    "url": "assets/slide/aliados.jpeg",
  },
  {
    "project": "Gesport",
    "empresa": "Comunix S.A.S",
    "tecnologias": ["Java", "Android Studio", "PHP"],
    "url": "assets/slide/gessport.jpeg",
  },
  {
    "project": "Portfolio",
    "empresa": "LeanSanchez-Dev",
    "tecnologias": ["Flutter", "Dart", "Flutter Web", "Firebase"],
    "url": "assets/slide/portafolio.jpeg",
  },
];
