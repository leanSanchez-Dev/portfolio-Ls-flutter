import 'package:web/web.dart' as web;

/// Persistencia web vía `window.localStorage` (`package:web`).
String? readLocalStorage(String key) {
  try {
    final value = web.window.localStorage.getItem(key);
    if (value == null || value.isEmpty) return null;
    return value;
  } catch (_) {
    return null;
  }
}

void writeLocalStorage(String key, String value) {
  try {
    web.window.localStorage.setItem(key, value);
  } catch (_) {
    // Private mode / iframe restrictions — ignore.
  }
}
