import 'package:flutter/material.dart';

/// Placeholder de [HtmlImageEmbed] para targets sin DOM (VM, tests, móvil).
///
/// No dispara [onError]: en VM no hay carga real que pueda fallar, así que el
/// widget padre conserva su estado "cargando/ok" y muestra este marcador.
class HtmlImageEmbed extends StatelessWidget {
  const HtmlImageEmbed({
    super.key,
    required this.src,
    required this.alt,
    required this.naturalWidth,
    required this.naturalHeight,
    this.onError,
    this.onLoad,
  });

  final Uri src;
  final String alt;
  final int naturalWidth;
  final int naturalHeight;
  final VoidCallback? onError;
  final VoidCallback? onLoad;

  @override
  Widget build(BuildContext context) {
    return _EmbedPlaceholder(label: alt, icon: Icons.insert_chart_outlined);
  }
}

/// Placeholder de [HtmlIframeEmbed] para targets sin DOM.
class HtmlIframeEmbed extends StatelessWidget {
  const HtmlIframeEmbed({
    super.key,
    required this.src,
    required this.title,
    this.allow,
    this.allowFullscreen = false,
    this.borderRadius = 12,
  });

  final Uri src;
  final String title;
  final String? allow;
  final bool allowFullscreen;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return _EmbedPlaceholder(
      label: title,
      icon: Icons.play_circle_outline,
      borderRadius: borderRadius,
    );
  }
}

class _EmbedPlaceholder extends StatelessWidget {
  const _EmbedPlaceholder({
    required this.label,
    required this.icon,
    this.borderRadius = 12,
  });

  final String label;
  final IconData icon;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: label,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: theme.dividerColor.withValues(alpha: 0.3),
          ),
        ),
        child: Icon(
          icon,
          size: 32,
          color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
        ),
      ),
    );
  }
}
