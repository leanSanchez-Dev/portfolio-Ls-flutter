import 'package:flutter/foundation.dart';

/// Presupuesto de montajes por URL para recursos embebidos de terceros.
///
/// Un flag local en el `State` de la tarjeta no basta: el `State` se puede
/// destruir y recrear (reciclado de listas, cambio de idioma, navegación), y
/// cada recreación volvería a montar el `<img>` y a pedir la URL. Un servicio
/// de terceros caído (`github-readme-stats` responde 429/503 con frecuencia)
/// no puede convertirse en un bucle de peticiones desde el portafolio.
///
/// Este registro vive **fuera del árbol de widgets**, así que sobrevive a esa
/// recreación y es la única fuente de verdad sobre si una URL puede volver a
/// intentarse. No implementa reintentos: [maxAttempts] es un tope duro y un
/// fallo lo agota de inmediato.
class EmbedLoadBudget {
  const EmbedLoadBudget._();

  /// Tope duro de montajes por URL en toda la sesión.
  ///
  /// Dos, no uno: deja margen a que un primer montaje se cancele antes de
  /// resolverse (el usuario pasa de largo mientras carga) sin degradar la
  /// tarjeta a fallback para siempre. Un `error` real agota el presupuesto en
  /// el primer intento, así que el caso 503 nunca llega a pedir dos veces.
  static const int maxAttempts = 2;

  static final Map<String, int> _attempts = <String, int>{};
  static final Set<String> _failed = <String>{};
  static final Set<String> _loaded = <String>{};

  static String _key(Uri src) => src.toString();

  /// `true` si la URL todavía puede montarse.
  static bool canAttempt(Uri src) {
    final key = _key(src);
    if (_failed.contains(key)) return false;
    // Ya cargó una vez: remontarla sale de la caché del navegador.
    if (_loaded.contains(key)) return true;
    return (_attempts[key] ?? 0) < maxAttempts;
  }

  /// Contabiliza un montaje que va a provocar una petición de red.
  static void recordAttempt(Uri src) {
    final key = _key(src);
    _attempts[key] = (_attempts[key] ?? 0) + 1;
  }

  /// El recurso falló: se agota el presupuesto para esa URL.
  static void recordFailure(Uri src) => _failed.add(_key(src));

  /// El recurso cargó: los siguientes montajes ya no cuestan red.
  static void recordSuccess(Uri src) => _loaded.add(_key(src));

  static bool hasFailed(Uri src) => _failed.contains(_key(src));

  @visibleForTesting
  static int attemptsFor(Uri src) => _attempts[_key(src)] ?? 0;

  @visibleForTesting
  static void resetForTesting() {
    _attempts.clear();
    _failed.clear();
    _loaded.clear();
  }
}
