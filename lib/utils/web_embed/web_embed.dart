/// Fachada de elementos DOM embebidos (`HtmlElementView`).
///
/// `dart:ui_web`, `dart:js_interop` y `package:web` no existen en la VM de
/// Dart, así que importarlos directamente rompería `flutter test`. Esta
/// librería re-exporta la implementación web solo cuando el target la soporta
/// y, en cualquier otro caso, un stub que compila y pinta un placeholder.
///
/// Ambas implementaciones exponen la misma API pública:
/// [HtmlImageEmbed] y [HtmlIframeEmbed].
library;

export 'web_embed_stub.dart' if (dart.library.js_interop) 'web_embed_web.dart';
