import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/domain/config/external_integrations.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:portfolio_ls/providers/theme_provider.dart';
import 'package:portfolio_ls/utils/embed_load_budget.dart';
import 'package:portfolio_ls/utils/reveal_on_scroll.dart';
import 'package:portfolio_ls/utils/theme_data.dart';
import 'package:portfolio_ls/utils/web_embed/web_embed.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// Sección de estadísticas de GitHub.
///
/// Las URLs vienen siempre de [GitHubStatsConfig]; aquí no se compone ninguna.
/// Las tarjetas son `<img>` del DOM (platform view), así que necesitan altura
/// acotada explícita: se usa [AspectRatio] con las medidas nativas de
/// github-readme-stats.
class GitHubStats extends StatelessWidget {
  const GitHubStats({super.key});

  /// Medidas por defecto de github-readme-stats.
  static const int _statsWidth = 495;
  static const int _statsHeight = 195;
  static const int _langsWidth = 300;
  static const int _langsHeight = 200;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Único punto donde la sección observa el tema: el resto es estático.
    final isDarkMode = context.select<ThemeProvider, bool>((t) => t.isDarkMode);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          RevealAnimation(
            child: _Header(
              title: l10n.githubStatsTitle,
              description: l10n.githubStatsDescription,
            ),
          ),
          const SizedBox(height: 32),
          RevealAnimation(
            delay: const Duration(milliseconds: 120),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 24,
              runSpacing: 24,
              children: [
                _StatsCard(
                  src: GitHubStatsConfig.statsUri(isDarkMode: isDarkMode),
                  alt: '${l10n.githubStatsTitle} — '
                      '${GitHubStatsConfig.username}',
                  naturalWidth: _statsWidth,
                  naturalHeight: _statsHeight,
                ),
                _StatsCard(
                  src:
                      GitHubStatsConfig.topLanguagesUri(isDarkMode: isDarkMode),
                  alt: '${l10n.technologies} — '
                      '${GitHubStatsConfig.username}',
                  naturalWidth: _langsWidth,
                  naturalHeight: _langsHeight,
                ),
              ],
            ),
          ),
        ],
      ),
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
                FontAwesomeIcons.github,
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

/// Tarjeta con el `<img>` remoto, su placeholder y su fallback.
///
/// `github-readme-stats` es una instancia pública compartida que responde 429
/// o 503 con frecuencia; por eso el evento `error` del `<img>` conmuta a un
/// aviso con enlace al perfil en vez de dejar un hueco vacío.
///
/// El veredicto se guarda en [EmbedLoadBudget], no en este `State`: así
/// sobrevive a que el widget se destruya y recree, y ninguna circunstancia
/// puede convertir un tercero caído en un bucle de peticiones.
class _StatsCard extends StatefulWidget {
  const _StatsCard({
    required this.src,
    required this.alt,
    required this.naturalWidth,
    required this.naturalHeight,
  });

  final Uri src;
  final String alt;
  final int naturalWidth;
  final int naturalHeight;

  @override
  State<_StatsCard> createState() => _StatsCardState();
}

class _StatsCardState extends State<_StatsCard> {
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    // El veredicto de intentos anteriores no vive en este `State`: si la URL
    // ya agotó su presupuesto se arranca directamente en fallback, sin montar
    // la platform view ni pedir nada.
    _failed = !EmbedLoadBudget.canAttempt(widget.src);
  }

  @override
  void didUpdateWidget(_StatsCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src == widget.src) return;
    // Cambió el tema: `HtmlImageEmbed` muta el `src` in-place y el navegador
    // vuelve a pedir la imagen, así que la URL nueva consume su propio
    // presupuesto en vez de heredar el de la anterior.
    final allowed = EmbedLoadBudget.canAttempt(widget.src);
    // Si la tarjeta venía en fallback, el `RevealOnScroll` se monta de cero y
    // será `_onRevealed` quien contabilice el intento; contarlo aquí también
    // lo cobraría dos veces.
    if (allowed && !_failed) EmbedLoadBudget.recordAttempt(widget.src);
    _failed = !allowed;
  }

  void _onRevealed() => EmbedLoadBudget.recordAttempt(widget.src);

  void _onError() {
    // Se registra antes de cualquier `mounted`: el fallo es de la URL, no de
    // esta instancia, y debe sobrevivir a ella.
    EmbedLoadBudget.recordFailure(widget.src);
    if (!mounted || _failed) return;
    setState(() => _failed = true);
  }

  void _onLoad() => EmbedLoadBudget.recordSuccess(widget.src);

  Future<void> _openProfile() async {
    await launchUrl(
      GitHubStatsConfig.profileUri,
      webOnlyWindowName: '_blank',
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final available = MediaQuery.of(context).size.width - 40;
    final width = widget.naturalWidth.toDouble().clamp(0.0, available);

    return SizedBox(
      width: width,
      child: AspectRatio(
        aspectRatio: widget.naturalWidth / widget.naturalHeight,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.getCardBackground(context),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.getBorderStrong(context)),
          ),
          child: _failed
              ? _Fallback(onOpenProfile: _openProfile)
              : RevealOnScroll(
                  // No se monta la platform view hasta que la sección
                  // es visible: fuera del primer viewport no cuesta nada.
                  onRevealed: _onRevealed,
                  builder: (context, revealed) => revealed
                      ? HtmlImageEmbed(
                          src: widget.src,
                          alt: widget.alt,
                          naturalWidth: widget.naturalWidth,
                          naturalHeight: widget.naturalHeight,
                          onError: _onError,
                          onLoad: _onLoad,
                        )
                      : const SizedBox.expand(),
                ),
        ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.onOpenProfile});

  final Future<void> Function() onOpenProfile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.circleExclamation,
              size: 20,
              color: AppColors.getTextSecondary(context),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                l10n.githubStatsUnavailable,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.getTextSecondary(context),
                    ),
              ),
            ),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onOpenProfile,
              icon: const Icon(FontAwesomeIcons.github, size: 14),
              label: Text(l10n.viewOnGitHub),
            ),
          ],
        ),
      ),
    );
  }
}
