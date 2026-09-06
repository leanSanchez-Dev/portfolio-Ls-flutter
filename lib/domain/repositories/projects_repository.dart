import 'package:portfolio_ls/models/projects.dart';

/// Contrato de acceso a proyectos. La presentación nunca habla con el
/// datasource: solo con el provider, que a su vez usa esta interfaz.
abstract class ProjectsRepository {
  /// Proyectos publicados, ya mapeados a entidades de dominio.
  List<Project> getProjects();

  /// Tecnologías presentes en los proyectos, sin duplicados y ordenadas
  /// alfabéticamente. Se deriva de los datos, no se mantiene a mano.
  List<String> getTechnologies();
}
