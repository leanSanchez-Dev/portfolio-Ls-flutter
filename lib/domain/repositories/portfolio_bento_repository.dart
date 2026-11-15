import 'package:portfolio_ls/domain/models/portfolio_bento.dart';

/// Contrato de contenido Bento. La UI solo habla con el provider.
abstract class PortfolioBentoRepository {
  /// Snapshot síncrono del copy, tech stack y proyectos.
  PortfolioBentoData getData();
}
