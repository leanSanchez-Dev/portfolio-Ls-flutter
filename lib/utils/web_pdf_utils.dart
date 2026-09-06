/// Fachada de [WebPdfUtils].
///
/// El import directo de `dart:html` que vivía aquí impedía compilar cualquier
/// test de widget que alcanzara la sección de CV (`flutter test` corre en la
/// VM de Dart). Esta librería añade la indirección condicional: en VM y móvil
/// resuelve al stub, en web a la implementación DOM.
///
/// La condición es `dart.library.js_interop` (no `dart.library.html`) para
/// alinearse con `utils/web_embed/` y seguir resolviendo a la implementación
/// web cuando se compile a Wasm, donde `dart:html` no existe.
library;

export 'web_pdf/web_pdf_utils_stub.dart'
    if (dart.library.js_interop) 'web_pdf/web_pdf_utils_web.dart';
