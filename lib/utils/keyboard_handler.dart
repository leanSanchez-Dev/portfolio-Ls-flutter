import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Wrapper para manejo seguro de eventos de teclado
/// Ayuda a prevenir errores de KeyUpEvent en Flutter web
class SafeKeyboardHandler extends StatefulWidget {
  final Widget child;
  final bool interceptKeyboardEvents;
    
  const SafeKeyboardHandler({
    super.key,
    required this.child,
    this.interceptKeyboardEvents = true,
  });

  @override
  State<SafeKeyboardHandler> createState() => _SafeKeyboardHandlerState();
}

class _SafeKeyboardHandlerState extends State<SafeKeyboardHandler> {
  final Set<LogicalKeyboardKey> _pressedKeys = <LogicalKeyboardKey>{};

  @override
  Widget build(BuildContext context) {
    if (!widget.interceptKeyboardEvents) {
      return widget.child;
    }

    return Focus(
      autofocus: false,
      onKeyEvent: _handleKeyEvent,
      child: widget.child,
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    try {
      // Manejo seguro de eventos de teclado
      if (event is KeyDownEvent) {
        _pressedKeys.add(event.logicalKey);
      } else if (event is KeyUpEvent) {
        _pressedKeys.remove(event.logicalKey);
      }
      
      // Permitir que el evento continue su propagación normal
      return KeyEventResult.ignored;
    } catch (e) {
      // Capturar cualquier error de manejo de teclado y continuar
      debugPrint('Keyboard event error caught: $e');
      return KeyEventResult.ignored;
    }
  }
}

/// Mixin para widgets que necesitan manejo seguro de teclado
mixin SafeKeyboardMixin<T extends StatefulWidget> on State<T> {
  final Set<LogicalKeyboardKey> _pressedKeys = <LogicalKeyboardKey>{};

  /// Wrapper seguro para verificar si una tecla está presionada
  bool isKeyPressed(LogicalKeyboardKey key) {
    try {
      return HardwareKeyboard.instance.isLogicalKeyPressed(key);
    } catch (e) {
      // Si hay error, usar nuestro tracking local
      return _pressedKeys.contains(key);
    }
  }

  /// Manejo seguro de eventos de teclado
  KeyEventResult handleKeyEventSafely(FocusNode node, KeyEvent event) {
    try {
      if (event is KeyDownEvent) {
        _pressedKeys.add(event.logicalKey);
        return onKeyDown(event);
      } else if (event is KeyUpEvent) {
        _pressedKeys.remove(event.logicalKey);
        return onKeyUp(event);
      } else if (event is KeyRepeatEvent) {
        return onKeyRepeat(event);
      }
      return KeyEventResult.ignored;
    } catch (e) {
      debugPrint('Safe keyboard handling error: $e');
      return KeyEventResult.ignored;
    }
  }

  /// Override estos métodos en tu widget
  KeyEventResult onKeyDown(KeyDownEvent event) => KeyEventResult.ignored;
  KeyEventResult onKeyUp(KeyUpEvent event) => KeyEventResult.ignored;
  KeyEventResult onKeyRepeat(KeyRepeatEvent event) => KeyEventResult.ignored;
}

/// Utilidad para detectar plataforma web de forma segura
class PlatformUtils {
  static bool get isWeb {
    try {
      return identical(0, 0.0) == false; // Técnica para detectar web
    } catch (e) {
      return false;
    }
  }

  static bool get isDesktop {
    try {
      return !isWeb && (
        Theme.of(NavigationService.navigatorKey.currentContext!).platform == TargetPlatform.windows ||
        Theme.of(NavigationService.navigatorKey.currentContext!).platform == TargetPlatform.macOS ||
        Theme.of(NavigationService.navigatorKey.currentContext!).platform == TargetPlatform.linux
      );
    } catch (e) {
      return false;
    }
  }
}

/// Servicio de navegación global para acceso al contexto
class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static NavigatorState? get navigator => navigatorKey.currentState;
  static BuildContext? get context => navigatorKey.currentContext;
}
