import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// `true` si el usuario pidió reducir movimiento (SO o lector de pantalla).
///
/// Se consulta siempre antes de animar; en ese caso el contenido se muestra
/// en su estado final, nunca oculto.
bool prefersReducedMotion(BuildContext context) {
  final media = MediaQuery.maybeOf(context);
  if (media == null) return false;
  return media.disableAnimations || media.accessibleNavigation;
}

/// Dispara una sola vez cuando el widget entra en el viewport del scroll.
///
/// No añade dependencias: escucha la [ScrollPosition] del [Scrollable] más
/// cercano y compara la posición global del propio render box con la altura de
/// pantalla. El listener se **desengancha en cuanto revela**, así que no queda
/// trabajo por frame en idle ni hace falta throttling adicional.
///
/// Se usa para dos cosas:
/// - animar secciones al entrar en pantalla (ver [RevealAnimation]);
/// - **diferir el montaje de contenido pesado** (platform views, precarga de
///   imágenes) hasta que la sección sea visible.
class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.builder,
    this.onRevealed,
    this.thresholdFraction = 0.1,
  });

  /// Construye el contenido; `revealed` indica si ya entró en viewport.
  final Widget Function(BuildContext context, bool revealed) builder;

  /// Efecto lateral opcional al revelarse (arrancar controladores, precargar).
  final VoidCallback? onRevealed;

  /// Porción de la altura de pantalla que debe haber recorrido el borde
  /// superior del widget para considerarse visible.
  final double thresholdFraction;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _revealed = false;
  ScrollPosition? _position;

  @override
  void initState() {
    super.initState();
    // Cubre el caso "ya visible en el primer viewport" (sin scroll del usuario).
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_revealed) return;
    final position = Scrollable.maybeOf(context)?.position;
    if (identical(position, _position)) return;
    _detach();
    _position = position;
    _position?.addListener(_check);
  }

  @override
  void dispose() {
    _detach();
    super.dispose();
  }

  void _detach() {
    _position?.removeListener(_check);
    _position = null;
  }

  void _check() {
    if (_revealed || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;
    final screenHeight = MediaQuery.of(context).size.height;
    final top = renderObject.localToGlobal(Offset.zero).dy;
    if (top > screenHeight * (1 - widget.thresholdFraction)) return;
    _reveal();
  }

  void _reveal() {
    _detach();
    // La notificación de scroll puede llegar durante la fase de layout/build.
    if (SchedulerBinding.instance.schedulerPhase ==
        SchedulerPhase.persistentCallbacks) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _apply());
    } else {
      _apply();
    }
  }

  void _apply() {
    if (!mounted || _revealed) return;
    setState(() => _revealed = true);
    widget.onRevealed?.call();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _revealed);
}

/// Aparición progresiva (fade + slide) al entrar en el viewport.
///
/// Usa `flutter_animate` con `target`, no con autoplay: la animación no corre
/// al construir, sino cuando [RevealOnScroll] marca el widget como visible.
/// Con *reduced motion* activo devuelve el hijo tal cual, sin envolverlo.
class RevealAnimation extends StatelessWidget {
  const RevealAnimation({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 450),
    this.slideBegin = 0.12,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  /// Desplazamiento inicial en fracción de la altura del hijo.
  final double slideBegin;

  @override
  Widget build(BuildContext context) {
    if (prefersReducedMotion(context)) return child;
    return RevealOnScroll(
      builder: (context, revealed) => Animate(
        target: revealed ? 1 : 0,
        effects: [
          FadeEffect(delay: delay, duration: duration, begin: 0, end: 1),
          SlideEffect(
            delay: delay,
            duration: duration,
            begin: Offset(0, slideBegin),
            end: Offset.zero,
            curve: Curves.easeOutCubic,
          ),
        ],
        child: child,
      ),
    );
  }
}
