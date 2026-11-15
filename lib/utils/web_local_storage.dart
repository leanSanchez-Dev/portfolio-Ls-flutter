/// Fachada de localStorage para Flutter Web.
///
/// En VM/móvil resuelve al stub; en web (incl. Wasm) a `package:web`.
library;

export 'web_local_storage/web_local_storage_stub.dart'
    if (dart.library.js_interop) 'web_local_storage/web_local_storage_web.dart';
