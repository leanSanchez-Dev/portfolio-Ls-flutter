/// Entidad de dominio de un proyecto del portafolio.
///
/// Inmutable y sin dependencias de Flutter ni de infraestructura.
/// Los datos crudos viven en `lib/data/datasources/projects_local_datasource.dart`.
class Project {
  const Project({
    required this.project,
    required this.empresa,
    required this.tecnologias,
    required this.url,
  });

  final String project;
  final String empresa;

  /// Tecnologías del proyecto. La primera es la principal.
  final List<String> tecnologias;

  /// Ruta del asset de portada.
  final String url;

  /// Tecnología principal del proyecto (la primera de [tecnologias]).
  ///
  /// La UI la usa para el badge destacado de la tarjeta.
  String get tecnologiaPrincipal =>
      tecnologias.isEmpty ? '' : tecnologias.first;

  /// Alias retrocompatible del antiguo campo `tag` (string único).
  String get tag => tecnologiaPrincipal;

  /// `true` si el proyecto usa [tecnologia] (comparación case-insensitive).
  bool usaTecnologia(String tecnologia) => tecnologias
      .any((t) => t.toLowerCase() == tecnologia.toLowerCase());

  /// Acepta de forma tolerante ambos formatos:
  /// - legacy: `{"tag": "Flutter"}`
  /// - actual: `{"tecnologias": ["Flutter", "Firebase"]}`
  ///
  /// Si vienen los dos, `tecnologias` manda y `tag` se conserva como principal
  /// solo si no está ya incluido.
  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      project: json['project'] as String? ?? '',
      empresa: json['empresa'] as String? ?? '',
      tecnologias: _parseTecnologias(json),
      url: json['url'] as String? ?? '',
    );
  }

  static List<String> _parseTecnologias(Map<String, dynamic> json) {
    final tecnologias = <String>[];

    final tag = json['tag'];
    if (tag is String && tag.trim().isNotEmpty) {
      tecnologias.add(tag.trim());
    }

    final raw = json['tecnologias'];
    if (raw is Iterable) {
      for (final item in raw) {
        if (item is! String) continue;
        final tecnologia = item.trim();
        if (tecnologia.isEmpty) continue;
        final yaExiste = tecnologias
            .any((t) => t.toLowerCase() == tecnologia.toLowerCase());
        if (!yaExiste) tecnologias.add(tecnologia);
      }
    }

    return List.unmodifiable(tecnologias);
  }

  Project copyWith({
    String? project,
    String? empresa,
    List<String>? tecnologias,
    String? url,
  }) {
    return Project(
      project: project ?? this.project,
      empresa: empresa ?? this.empresa,
      tecnologias: tecnologias ?? this.tecnologias,
      url: url ?? this.url,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Project &&
        other.project == project &&
        other.empresa == empresa &&
        other.url == url &&
        _listEquals(other.tecnologias, tecnologias);
  }

  @override
  int get hashCode => Object.hash(
        project,
        empresa,
        url,
        Object.hashAll(tecnologias),
      );

  @override
  String toString() =>
      'Project(project: $project, empresa: $empresa, tecnologias: $tecnologias)';

  static bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
