import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/domain/config/external_integrations.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:portfolio_ls/utils/reveal_on_scroll.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:portfolio_ls/utils/web_embed/web_embed.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sección "Música mientras programo" con el reproductor embebido de Spotify.
///
/// El iframe se monta siempre, sin click-to-load: es el código de inserción
/// oficial que pidió el usuario. Conserva `loading="lazy"` porque la sección
/// vive muy por debajo del fold y así no compite con el primer paint.
///
/// Implicación de privacidad asumida a petición del usuario: todo visitante
/// contacta a Spotify y recibe sus cookies de terceros sin interacción previa.
class MusicSection extends StatelessWidget {
  const MusicSection({super.key});

  /// Variante compacta del embed (solo barra de reproducción). Es la altura
  /// del snippet oficial y se usa en todos los breakpoints: evita la lista de
  /// pistas y, con ella, un scroll propio dentro del scroll de la página.
  static const double _playerHeight = 152;

  Future<void> _openInSpotify() async {
    await launchUrl(
      SpotifyConfig.playlistUri,
      webOnlyWindowName: '_blank',
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          RevealAnimation(
            child: _Header(
              title: l10n.musicTitle,
              description: l10n.musicDescription,
            ),
          ),
          const SizedBox(height: 32),
          RevealAnimation(
            delay: const Duration(milliseconds: 120),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    // La platform view no auto-dimensiona: altura explícita.
                    height: _playerHeight,
                    // El iframe se monta al entrar la sección en pantalla, no
                    // al construirse el árbol. Sigue sin haber click-to-load:
                    // el reproductor se carga solo, sin pedir permiso. Es el
                    // mismo momento en que se montaba cuando las secciones
                    // eran hijas de un `SliverList`, y evita que el arranque
                    // de la página compita con Spotify por el ancho de banda.
                    child: RevealOnScroll(
                      builder: (context, revealed) => revealed
                          ? HtmlIframeEmbed(
                              src: SpotifyConfig.embedUri(),
                              title: l10n.musicTitle,
                              // `allow` del snippet oficial de Spotify.
                              // Conceder `autoplay` habilita el permiso, no lo
                              // ejerce: el embed no arranca sin interacción
                              // del usuario.
                              allow:
                                  'autoplay; clipboard-write; encrypted-media; '
                                  'fullscreen; picture-in-picture',
                              borderRadius: 12,
                            )
                          : const _PlayerPlaceholder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton.icon(
                    onPressed: _openInSpotify,
                    icon: const Icon(FontAwesomeIcons.spotify, size: 14),
                    label: Text(l10n.openInSpotify),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Hueco del reproductor antes de montarse.
///
/// Ocupa exactamente la altura final del iframe, así que revelarlo no desplaza
/// nada de la página.
class _PlayerPlaceholder extends StatelessWidget {
  const _PlayerPlaceholder();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.getCardBackground(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.getBorderStrong(context)),
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.getIconBackground(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                FontAwesomeIcons.headphones,
                color: AppColors.getIconColor(context),
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                title,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 620),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: AppColors.getTextSecondary(context),
            ),
          ),
        ),
      ],
    );
  }
}
