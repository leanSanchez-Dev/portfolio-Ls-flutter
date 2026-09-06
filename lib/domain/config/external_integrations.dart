/// Configuración de integraciones web externas (GitHub Stats y Spotify).
///
/// Construir estas URLs es lógica, no presentación: la UI solo pide la URL ya
/// formada. Todos los parámetros se codifican con [Uri], nunca concatenando
/// strings.
library;

/// Tarjeta de estadísticas de GitHub (github-readme-stats).
class GitHubStatsConfig {
  const GitHubStatsConfig._();

  static const String host = 'github-readme-stats.vercel.app';
  static const String path = '/api';

  /// Usuario de GitHub del portafolio.
  static const String username = 'LeanSanchez-dev';

  /// Temas elegidos para combinar con la paleta del portafolio:
  /// - claro: `buefy` (fondo blanco, títulos azul/índigo ≈ `AppColors.lightPrimary`).
  /// - oscuro: `tokyonight` (fondo azul noche, títulos azul ≈ `AppColors.darkPrimary`).
  static const String lightTheme = 'buefy';
  static const String darkTheme = 'tokyonight';

  /// URL de la tarjeta de estadísticas para el modo actual del portafolio.
  ///
  /// [isDarkMode] proviene de `ThemeProvider.isDarkMode`.
  static Uri statsUri({required bool isDarkMode}) {
    return Uri.https(host, path, {
      'username': username,
      'show_icons': 'true',
      'hide_border': 'true',
      'theme': isDarkMode ? darkTheme : lightTheme,
    });
  }

  /// Tarjeta de lenguajes más usados, mismo criterio de tema.
  static Uri topLanguagesUri({required bool isDarkMode}) {
    return Uri.https(host, '/api/top-langs', {
      'username': username,
      'layout': 'compact',
      'hide_border': 'true',
      'theme': isDarkMode ? darkTheme : lightTheme,
    });
  }

  /// Perfil público de GitHub (para el botón "Ver en GitHub").
  static Uri get profileUri => Uri.https('github.com', '/$username');
}

/// Reproductor embebido de Spotify.
class SpotifyConfig {
  const SpotifyConfig._();

  /// 👉 PUNTO ÚNICO DE CONFIGURACIÓN de la playlist del portafolio.
  ///
  /// Playlist **definitiva** del usuario, tomada de su código de inserción
  /// oficial de Spotify. Para cambiarla: abre la playlist en Spotify →
  /// Compartir → Copiar enlace, y toma el ID de
  /// `https://open.spotify.com/playlist/<ID>?si=...`.
  ///
  /// Archivo: `lib/domain/config/external_integrations.dart` (esta línea).
  static const String playlistId = '56eiDCIVUNvnAqT1ypAL0B';

  static const String host = 'open.spotify.com';

  /// Token de sesión de compartición (`si`) incluido en el enlace original.
  ///
  /// No es un secreto ni identifica al visitante: es el token de atribución de
  /// la sesión desde la que se copió el enlace. Se conserva porque forma parte
  /// del código de inserción proporcionado.
  static const String shareToken = '4893a7aa6dc14e15';

  /// Tema del reproductor embebido.
  ///
  /// El generador de Spotify solo emite `theme=0`, que corresponde a la
  /// variante oscura del reproductor. No existe un valor alternativo
  /// documentado, por lo que la URL es fija y **no** depende del tema del
  /// portafolio.
  static const String theme = '0';

  /// URL del iframe embebido de la playlist.
  static Uri embedUri() {
    return Uri.https(host, '/embed/playlist/$playlistId', {
      'utm_source': 'generator',
      'theme': theme,
      'si': shareToken,
    });
  }

  /// Enlace para abrir la playlist en Spotify.
  static Uri get playlistUri => Uri.https(host, '/playlist/$playlistId');
}
