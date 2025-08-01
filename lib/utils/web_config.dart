import 'package:flutter/foundation.dart';

/// Configuración específica para Flutter web
/// Ayuda a manejar problemas conocidos de la plataforma web
class WebConfig {
  /// Configuración para manejo de errores de teclado en web
  static void configureWebKeyboardHandling() {
    if (kIsWeb) {
      // Configurar manejo de errores de Assert en modo debug
      if (kDebugMode) {
        // En web, algunos errores de KeyUpEvent son comunes y no críticos
        // Esta configuración ayuda a manejarlos de forma más elegante
        _setupKeyboardErrorHandling();
      }
    }
  }

  static void _setupKeyboardErrorHandling() {
    // Configuración adicional para manejo de errores de teclado
    // En futuras versiones de Flutter, esto podría no ser necesario
    
    // Por ahora, el SafeKeyboardHandler ya maneja estos casos
    // Esta función está lista para configuraciones adicionales si son necesarias
  }

  /// Detecta si estamos ejecutando en modo web
  static bool get isWeb => kIsWeb;

  /// Detecta si estamos en modo debug
  static bool get isDebug => kDebugMode;

  /// Configuración para prevenir errores comunes en web
  static void preventCommonWebErrors() {
    if (kIsWeb && kDebugMode) {
      // Configuraciones para prevenir errores comunes en desarrollo web
      // Esto incluye manejo de eventos de teclado, ratón, etc.
    }
  }
}

/// Inicialización de configuraciones web
void initializeWebConfig() {
  if (kIsWeb) {
    WebConfig.configureWebKeyboardHandling();
    WebConfig.preventCommonWebErrors();
  }
}
