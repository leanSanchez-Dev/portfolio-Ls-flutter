import 'package:flutter/foundation.dart';
import 'package:portfolio_ls/domain/models/portfolio_bento.dart';
import 'package:portfolio_ls/domain/repositories/portfolio_bento_repository.dart';

/// Estado de filtros + snapshot Bento.
///
/// ESD hablaba de un `PortfolioController` unificado; en este repo preferimos
/// providers separados existentes ([ThemeProvider], [LanguageProvider]) + este
/// provider de feature. ThemeMode/Locale **no** viven aquí.
///
/// Fuente local síncrona: no se modela loading/error. Carga explícita vía
/// [load] (sin I/O en el constructor).
class PortfolioBentoProvider extends ChangeNotifier {
  PortfolioBentoProvider(this._repository);

  final PortfolioBentoRepository _repository;

  PortfolioBentoData? _data;
  TechCategory _techFilter = TechCategory.all;
  BentoProjectFilter _projectFilter = BentoProjectFilter.all;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  PortfolioBentoData get data {
    assert(_isLoaded && _data != null, 'Call load() before reading data');
    return _data!;
  }

  /// Snapshot nullable para UI que aún no llamó [load].
  PortfolioBentoData? get dataOrNull => _data;

  TechCategory get techFilter => _techFilter;
  BentoProjectFilter get projectFilter => _projectFilter;

  List<TechItem> get filteredTech {
    final snapshot = _data;
    if (snapshot == null) return const [];
    return snapshot.techItemsFor(_techFilter);
  }

  List<ProjectItem> get filteredProjects {
    final snapshot = _data;
    if (snapshot == null) return const [];
    return snapshot.projectsFor(_projectFilter);
  }

  /// Experiencias laborales tipadas (orden cronológico descendente).
  List<ExperienceItem> get experiences {
    final snapshot = _data;
    if (snapshot == null) return const [];
    return snapshot.experiences;
  }

  /// Carga explícita. Idempotente salvo [force].
  void load({bool force = false}) {
    if (_isLoaded && !force) return;
    _data = _repository.getData();
    _isLoaded = true;
    notifyListeners();
  }

  void setTechFilter(TechCategory filter) {
    if (_techFilter == filter) return;
    _techFilter = filter;
    notifyListeners();
  }

  void setProjectFilter(BentoProjectFilter filter) {
    if (_projectFilter == filter) return;
    _projectFilter = filter;
    notifyListeners();
  }
}
