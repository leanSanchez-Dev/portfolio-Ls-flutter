import 'package:flutter/foundation.dart';
import 'package:portfolio_ls/domain/repositories/projects_repository.dart';
import 'package:portfolio_ls/models/projects.dart';

/// Estado del listado de proyectos y su filtro por tecnología.
///
/// Decisión de diseño: la fuente de datos es local y **síncrona**, así que no
/// se modela `loading/error` (sería estado mágico sin flujo real que lo
/// produzca). Lo que sí se respeta de la skill es no hacer side effects en el
/// constructor: la carga es explícita vía [load], y [isLoaded] indica si ya
/// ocurrió. Si en el futuro los proyectos vienen de red, aquí se sustituye por
/// un estado unificado async.
///
/// La lista filtrada se **precalcula** en cada cambio de selección; la UI
/// nunca filtra dentro de `build`.
class ProjectsProvider extends ChangeNotifier {
  ProjectsProvider(this._repository);

  final ProjectsRepository _repository;

  List<Project> _projects = const [];
  List<Project> _filteredProjects = const [];
  List<String> _technologies = const [];
  String? _selectedTechnology;
  bool _isLoaded = false;

  /// Todos los proyectos.
  List<Project> get projects => _projects;

  /// Proyectos que cumplen el filtro actual (ya calculados).
  List<Project> get filteredProjects => _filteredProjects;

  /// Tecnologías disponibles, ordenadas y sin duplicados.
  ///
  /// No incluye la opción "todas": esa es [allTechnologies] (`null`), cuya
  /// etiqueta la pone la UI desde ARB (`filterAll`).
  List<String> get technologies => _technologies;

  /// Tecnología seleccionada; `null` significa "todas".
  String? get selectedTechnology => _selectedTechnology;

  /// Valor sentinela de la opción "todas".
  static const String? allTechnologies = null;

  bool get isLoaded => _isLoaded;

  /// `true` cuando hay filtro activo y ningún proyecto lo cumple.
  /// La UI muestra el mensaje vacío (`noProjectsForFilter`).
  bool get isEmptyResult => _isLoaded && _filteredProjects.isEmpty;

  bool get hasActiveFilter => _selectedTechnology != null;

  /// `true` si [tecnologia] es la selección actual (`null` = "todas").
  bool isSelected(String? tecnologia) => _selectedTechnology == tecnologia;

  /// Carga explícita. Idempotente salvo que se pida [force].
  void load({bool force = false}) {
    if (_isLoaded && !force) return;
    _projects = _repository.getProjects();
    _technologies = _repository.getTechnologies();
    if (_selectedTechnology != null &&
        !_technologies.contains(_selectedTechnology)) {
      _selectedTechnology = null;
    }
    _filteredProjects = _applyFilter();
    _isLoaded = true;
    notifyListeners();
  }

  /// Selecciona una tecnología. `null` equivale a quitar el filtro.
  void selectTechnology(String? tecnologia) {
    if (_selectedTechnology == tecnologia) return;
    _selectedTechnology = tecnologia;
    _filteredProjects = _applyFilter();
    notifyListeners();
  }

  /// Vuelve a mostrar todos los proyectos.
  void clearFilter() => selectTechnology(null);

  List<Project> _applyFilter() {
    final tecnologia = _selectedTechnology;
    if (tecnologia == null) return _projects;
    return _projects
        .where((project) => project.usaTecnologia(tecnologia))
        .toList(growable: false);
  }
}
