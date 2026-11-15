import 'package:portfolio_ls/data/datasources/portfolio_bento_local_datasource.dart';
import 'package:portfolio_ls/domain/models/portfolio_bento.dart';
import 'package:portfolio_ls/domain/repositories/portfolio_bento_repository.dart';

/// Implementación local tipada (sin parseo JSON).
class PortfolioBentoRepositoryImpl implements PortfolioBentoRepository {
  const PortfolioBentoRepositoryImpl(this._dataSource);

  final PortfolioBentoLocalDataSource _dataSource;

  @override
  PortfolioBentoData getData() => _dataSource.fetch();
}
