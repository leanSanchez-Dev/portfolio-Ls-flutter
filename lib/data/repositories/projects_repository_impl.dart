import 'package:portfolio_ls/data/datasources/projects_local_datasource.dart';
import 'package:portfolio_ls/domain/repositories/projects_repository.dart';
import 'package:portfolio_ls/models/projects.dart';

/// Implementación que mapea el JSON crudo del datasource a entidades de
/// dominio. Es el único punto del código que parsea proyectos.
class ProjectsRepositoryImpl implements ProjectsRepository {
  const ProjectsRepositoryImpl(this._dataSource);

  final ProjectsDataSource _dataSource;

  @override
  List<Project> getProjects() =>
      _dataSource.fetchProjects().map(Project.fromJson).toList(growable: false);

  @override
  List<String> getTechnologies() {
    final tecnologias = <String, String>{};
    for (final project in getProjects()) {
      for (final tecnologia in project.tecnologias) {
        tecnologias.putIfAbsent(tecnologia.toLowerCase(), () => tecnologia);
      }
    }
    final ordenadas = tecnologias.values.toList()
      ..sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));
    return List.unmodifiable(ordenadas);
  }
}
