import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

/// Imagen remota renderizada como `<img>` real del DOM.
///
/// Decisión de implementación: se usa [HtmlElementView.fromTagName] en vez de
/// `ui_web.platformViewRegistry.registerViewFactory`. Motivos:
///
/// 1. El registry lanza si se registra dos veces el mismo `viewType`, así que
///    obligaría a inventar identificadores únicos y una guarda de idempotencia.
/// 2. Derivar el `viewType` de la URL (que cambia con el tema claro/oscuro)
///    fugaría una factory por cada combinación tema × tarjeta, y además
///    destruiría y recrearía la platform view en cada toggle.
/// 3. `fromTagName` crea el elemento por instancia y expone `onElementCreated`,
///    lo que permite **mutar `src` in-place** cuando cambia el tema: la platform
///    view sobrevive, el navegador solo re-descarga la imagen.
///
/// Es decir, es la opción (a) del brief —`viewType` estable + mutación del
/// `src`— pero sin escribir el registry a mano.
class HtmlImageEmbed extends StatefulWidget {
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

  /// Dimensiones intrínsecas declaradas en el `<img>` para evitar CLS.
  final int naturalWidth;
  final int naturalHeight;

  final VoidCallback? onError;
  final VoidCallback? onLoad;

  @override
  State<HtmlImageEmbed> createState() => _HtmlImageEmbedState();
}

class _HtmlImageEmbedState extends State<HtmlImageEmbed> {
  web.HTMLImageElement? _element;

  @override
  void didUpdateWidget(HtmlImageEmbed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src) {
      // El tema cambió: se reaprovecha el mismo elemento y platform view.
      _element?.src = widget.src.toString();
    }
    if (oldWidget.alt != widget.alt) {
      _element?.alt = widget.alt;
    }
  }

  void _onElementCreated(Object element) {
    final img = element as web.HTMLImageElement;
    _element = img;

    img
      ..src = widget.src.toString()
      ..alt = widget.alt
      ..width = widget.naturalWidth
      ..height = widget.naturalHeight
      // Recurso de terceros: no filtrar la URL del portafolio.
      ..referrerPolicy = 'no-referrer'
      ..loading = 'lazy'
      ..decoding = 'async';

    img.style
      ..width = '100%'
      ..height = '100%'
      ..objectFit = 'contain'
      ..border = 'none';

    final onError = widget.onError;
    if (onError != null) {
      img.addEventListener('error', ((web.Event _) => onError()).toJS);
    }
    final onLoad = widget.onLoad;
    if (onLoad != null) {
      img.addEventListener('load', ((web.Event _) => onLoad()).toJS);
    }
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView.fromTagName(
      tagName: 'img',
      onElementCreated: _onElementCreated,
    );
  }
}

/// `<iframe>` embebido (reproductor de Spotify).
///
/// No se usa el atributo `sandbox`: rompe EME/DRM del reproductor y no aporta
/// aislamiento real frente a un origen cruzado que ya está separado por el
/// navegador. La política de permisos se pasa explícita vía [allow].
class HtmlIframeEmbed extends StatefulWidget {
  const HtmlIframeEmbed({
    super.key,
    required this.src,
    required this.title,
    this.allow,
    this.allowFullscreen = false,
    this.borderRadius = 12,
  });

  final Uri src;

  /// Título accesible del iframe (lectores de pantalla).
  final String title;

  final String? allow;

  /// Atributo `allowfullscreen`. Solo concede el permiso; el contenido
  /// embebido decide si lo usa y siempre requiere gesto del usuario.
  ///
  /// Se ignora si [allow] ya incluye el token `fullscreen`: poner los dos es
  /// redundante y Chrome lo avisa por consola.
  final bool allowFullscreen;

  final double borderRadius;

  @override
  State<HtmlIframeEmbed> createState() => _HtmlIframeEmbedState();
}

class _HtmlIframeEmbedState extends State<HtmlIframeEmbed> {
  web.HTMLIFrameElement? _element;

  @override
  void didUpdateWidget(HtmlIframeEmbed oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.src != widget.src) {
      _element?.src = widget.src.toString();
    }
  }

  void _onElementCreated(Object element) {
    final iframe = element as web.HTMLIFrameElement;
    _element = iframe;

    iframe
      ..src = widget.src.toString()
      ..title = widget.title
      ..loading = 'lazy'
      ..referrerPolicy = 'strict-origin-when-cross-origin';

    final allow = widget.allow;
    if (allow != null) iframe.allow = allow;

    // `allowfullscreen` y el token `fullscreen` de `allow` conceden lo mismo.
    // Con los dos puestos Chrome avisa por consola de que `allow` tiene
    // precedencia, así que el atributo solo se pone cuando `allow` no cubre ya
    // el permiso.
    if (widget.allowFullscreen && !(allow?.contains('fullscreen') ?? false)) {
      iframe.allowFullscreen = true;
    }

    iframe.style
      ..width = '100%'
      ..height = '100%'
      ..border = 'none'
      // `ClipRRect` no recorta nodos DOM: el radio se aplica en CSS.
      ..borderRadius = '${widget.borderRadius}px';
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView.fromTagName(
      tagName: 'iframe',
      onElementCreated: _onElementCreated,
    );
  }
}
