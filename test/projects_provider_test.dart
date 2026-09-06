import 'package:flutter_test/flutter_test.dart';
import 'package:portfolio_ls/data/datasources/projects_local_datasource.dart';
import 'package:portfolio_ls/data/repositories/projects_repository_impl.dart';
import 'package:portfolio_ls/domain/config/external_integrations.dart';
import 'package:portfolio_ls/models/projects.dart';
import 'package:portfolio_ls/providers/projects_provider.dart';

class _FakeDataSource implements ProjectsDataSource {
  _FakeDataSource(this._raw);
  final List<Map<String, dynamic>> _raw;

  @override
  List<Map<String, dynamic>> fetchProjects() => _raw;
}

void main() {
  group('Project.fromJson', () {
    test('acepta el formato legacy con tag string', () {
      final project = Project.fromJson({
        'project': 'Legacy',
        'empresa': 'ACME',
        'tag': 'Flutter',
        'url': 'assets/slide/legacy.jpeg',
      });

      expect(project.tecnologias, ['Flutter']);
      expect(project.tecnologiaPrincipal, 'Flutter');
      expect(project.tag, 'Flutter');
    });

    test('acepta lista de tecnologias y evita duplicados con tag', () {
      final project = Project.fromJson({
        'project': 'Mixto',
        'empresa': 'ACME',
        'tag': 'Flutter',
        'tecnologias': ['flutter', 'Firebase'],
        'url': 'x.jpeg',
      });

      expect(project.tecnologias, ['Flutter', 'Firebase']);
    });

    test('no lanza con datos incompletos o mal tipados', () {
      final project = Project.fromJson({'tecnologias': 'no-es-lista'});

      expect(project.project, '');
      expect(project.tecnologias, isEmpty);
      expect(project.tecnologiaPrincipal, '');
    });
  });

  group('ProjectsProvider', () {
    ProjectsProvider buildProvider() => ProjectsProvider(
          ProjectsRepositoryImpl(
            _FakeDataSource([
              {
                'project': 'Uno',
                'empresa': 'ACME',
                'tecnologias': ['Flutter', 'Dart'],
                'url': 'a.jpeg',
              },
              {
                'project': 'Dos',
                'empresa': 'ACME',
                'tecnologias': ['Java'],
                'url': 'b.jpeg',
              },
            ]),
          ),
        );

    test('no carga nada hasta llamar a load()', () {
      final provider = buildProvider();

      expect(provider.isLoaded, isFalse);
      expect(provider.projects, isEmpty);

      provider.load();

      expect(provider.isLoaded, isTrue);
      expect(provider.projects, hasLength(2));
      expect(provider.filteredProjects, hasLength(2));
    });

    test('expone tecnologias ordenadas sin duplicados', () {
      final provider = buildProvider()..load();

      expect(provider.technologies, ['Dart', 'Flutter', 'Java']);
    });

    test('filtra y limpia el filtro notificando cambios', () {
      final provider = buildProvider()..load();
      var notificaciones = 0;
      provider.addListener(() => notificaciones++);

      provider.selectTechnology('Flutter');
      expect(provider.filteredProjects.single.project, 'Uno');
      expect(provider.hasActiveFilter, isTrue);
      expect(provider.isSelected('Flutter'), isTrue);

      provider.selectTechnology('Flutter');
      expect(notificaciones, 1, reason: 'seleccionar lo mismo no notifica');

      provider.clearFilter();
      expect(provider.filteredProjects, hasLength(2));
      expect(provider.hasActiveFilter, isFalse);
      expect(notificaciones, 2);
    });

    test('isEmptyResult cuando ningun proyecto cumple el filtro', () {
      final provider = buildProvider()..load();

      provider.selectTechnology('Kotlin');

      expect(provider.filteredProjects, isEmpty);
      expect(provider.isEmptyResult, isTrue);
    });
  });

  group('Integraciones externas', () {
    test('GitHub stats cambia de tema segun el modo', () {
      final claro = GitHubStatsConfig.statsUri(isDarkMode: false);
      final oscuro = GitHubStatsConfig.statsUri(isDarkMode: true);

      expect(claro.queryParameters['theme'], GitHubStatsConfig.lightTheme);
      expect(oscuro.queryParameters['theme'], GitHubStatsConfig.darkTheme);
      expect(claro.queryParameters['username'], GitHubStatsConfig.username);
      expect(claro.scheme, 'https');
    });

    test('Spotify embebe la playlist configurada', () {
      final uri = SpotifyConfig.embedUri();

      expect(uri.scheme, 'https');
      expect(uri.host, SpotifyConfig.host);
      expect(SpotifyConfig.playlistId, '56eiDCIVUNvnAqT1ypAL0B');
      expect(uri.path, '/embed/playlist/${SpotifyConfig.playlistId}');
      expect(uri.queryParameters['utm_source'], 'generator');
      expect(uri.queryParameters['theme'], '0');
      expect(uri.queryParameters['si'], SpotifyConfig.shareToken);
    });

    test('Spotify expone una URL de embed estable', () {
      expect(SpotifyConfig.embedUri(), SpotifyConfig.embedUri());
      expect(
        SpotifyConfig.playlistUri.path,
        '/playlist/${SpotifyConfig.playlistId}',
      );
    });
  });

  test('el datasource local expone los 7 proyectos del portafolio', () {
    const repository = ProjectsRepositoryImpl(ProjectsLocalDataSource());

    expect(repository.getProjects(), hasLength(7));
    expect(
      repository.getProjects().every((p) => p.tecnologias.isNotEmpty),
      isTrue,
    );
  });
}
