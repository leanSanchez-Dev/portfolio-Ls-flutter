import 'package:flutter/material.dart';

// Clase simple para reemplazar AnimatedHoverContainer temporalmente
class AnimatedHoverContainer extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const AnimatedHoverContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    return child; // Por ahora solo retorna el child sin animación
  }
}

// Clase simple para reemplazar AnimatedFadeSlide temporalmente
class AnimatedFadeSlide extends StatelessWidget {
  final Widget child;
  final Duration duration;
  final Offset? offset;

  const AnimatedFadeSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.offset,
  });

  @override
  Widget build(BuildContext context) {
    return child; // Por ahora solo retorna el child sin animación
  }
}

// Widget de texto simple que funciona correctamente
class TypewriterText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Duration duration;
  final Duration delay;

  const TypewriterText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(milliseconds: 30),
    this.delay = Duration.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}

// Widget SafeKeyboardHandler mejorado
class SafeKeyboardHandler extends StatefulWidget {
  final Widget child;

  const SafeKeyboardHandler({
    super.key,
    required this.child,
  });

  @override
  State<SafeKeyboardHandler> createState() => _SafeKeyboardHandlerState();
}

class _SafeKeyboardHandlerState extends State<SafeKeyboardHandler> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
