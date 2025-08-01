import 'package:flutter/material.dart';

// Widget para animaciones de entrada con fade y slide
class AnimatedFadeSlide extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset offset;
  final Curve curve;

  const AnimatedFadeSlide({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.offset = const Offset(0, 30),
    this.curve = Curves.easeOutCubic,
  });

  @override
  State<AnimatedFadeSlide> createState() => _AnimatedFadeSlideState();
}

class _AnimatedFadeSlideState extends State<AnimatedFadeSlide>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _slideAnimation = Tween<Offset>(
      begin: widget.offset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    // Start animation with delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: Transform.translate(
            offset: _slideAnimation.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

// Widget para animaciones al hacer hover
class AnimatedHoverContainer extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double hoverScale;
  final Color? hoverShadowColor;
  final double hoverElevation;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const AnimatedHoverContainer({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.hoverScale = 1.02,
    this.hoverShadowColor,
    this.hoverElevation = 8,
    this.borderRadius,
    this.padding,
    this.margin,
  });

  @override
  State<AnimatedHoverContainer> createState() => _AnimatedHoverContainerState();
}

class _AnimatedHoverContainerState extends State<AnimatedHoverContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius = widget.borderRadius ?? BorderRadius.circular(12);
    
    return Container(
      margin: widget.margin,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: widget.duration,
                padding: widget.padding,
                decoration: BoxDecoration(
                  borderRadius: effectiveBorderRadius,
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.hoverShadowColor?.withValues(alpha: 0.15) ??
                                Theme.of(context).primaryColor.withValues(alpha: 0.15),
                            blurRadius: widget.hoverElevation,
                            spreadRadius: 2,
                            offset: const Offset(0, 4),
                          ),
                          BoxShadow(
                            color: widget.hoverShadowColor?.withValues(alpha: 0.08) ??
                                Theme.of(context).primaryColor.withValues(alpha: 0.08),
                            blurRadius: widget.hoverElevation * 2,
                            spreadRadius: 1,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: ClipRRect(
                  borderRadius: effectiveBorderRadius,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

// Widget especializado para tarjetas con hover que mantiene la forma
class HoverCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double hoverScale;
  final Color? shadowColor;
  final double elevation;
  final double hoverElevation;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Border? border;

  const HoverCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.hoverScale = 1.02,
    this.shadowColor,
    this.elevation = 2,
    this.hoverElevation = 8,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.padding,
    this.margin,
    this.backgroundColor,
    this.border,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Material(
                elevation: _elevationAnimation.value,
                borderRadius: widget.borderRadius,
                shadowColor: widget.shadowColor ?? 
                    Theme.of(context).primaryColor.withValues(alpha: 0.3),
                color: widget.backgroundColor ?? 
                    Theme.of(context).cardColor,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: widget.borderRadius,
                    border: widget.border,
                  ),
                  child: ClipRRect(
                    borderRadius: widget.borderRadius,
                    child: Container(
                      padding: widget.padding,
                      child: widget.child,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}

// Widget para animaciones de carga staggered
class StaggeredList extends StatefulWidget {
  final List<Widget> children;
  final Duration itemDelay;
  final Duration itemDuration;
  final Axis direction;

  const StaggeredList({
    super.key,
    required this.children,
    this.itemDelay = const Duration(milliseconds: 60),
    this.itemDuration = const Duration(milliseconds: 400),
    this.direction = Axis.horizontal,
  });

  @override
  State<StaggeredList> createState() => _StaggeredListState();
}

class _StaggeredListState extends State<StaggeredList> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      // mainAxisAlignment: MainAxisAlignment.center,
      spacing: 2,
      runSpacing: 2,
      direction: widget.direction,
      crossAxisAlignment: widget.direction == Axis.horizontal
          ? WrapCrossAlignment.center
          : WrapCrossAlignment.start, 
      children: widget.children.asMap().entries.map((entry) {
        int index = entry.key;
        Widget child = entry.value;

        return AnimatedFadeSlide(
          delay: widget.itemDelay * index,
          duration: widget.itemDuration,
          offset: widget.direction == Axis.vertical
              ? const Offset(0, 30)
              : const Offset(30, 0),
          child: child,
        );
      }).toList(),
    );
  }
}

// Widget para animaciones de escritura (typewriter effect)
class TypewriterText extends StatefulWidget {
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
  State<TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<TypewriterText>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _characterCount;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );

    _characterCount = StepTween(
      begin: 0,
      end: widget.text.length,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _characterCount,
      builder: (context, child) {
        String animatedText = widget.text.substring(0, _characterCount.value);
        return Text(
          animatedText,
          style: widget.style,
        );
      },
    );
  }
}

// Widget para progreso circular animado
class AnimatedCircularProgress extends StatefulWidget {
  final double progress;
  final String label;
  final Color? color;
  final Duration duration;
  final Duration delay;

  const AnimatedCircularProgress({
    super.key,
    required this.progress,
    required this.label,
    this.color,
    this.duration = const Duration(milliseconds: 1000),
    this.delay = Duration.zero,
  });

  @override
  State<AnimatedCircularProgress> createState() =>
      _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _progressAnimation,
      builder: (context, child) {
        return Row(
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: _progressAnimation.value,
                strokeWidth: 4,
                backgroundColor:
                    Theme.of(context).dividerColor.withValues(alpha: 0.3),
                valueColor: AlwaysStoppedAnimation<Color>(
                  widget.color ?? Theme.of(context).primaryColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(_progressAnimation.value * 100).round()}%',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: widget.color ?? Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

// Widget para chips/badges con hover que mantiene forma de píldora
class HoverChip extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final double hoverScale;
  final Color? backgroundColor;
  final Color? hoverBackgroundColor;
  final Color? shadowColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double elevation;
  final double hoverElevation;

  const HoverChip({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 200),
    this.hoverScale = 1.05,
    this.backgroundColor,
    this.hoverBackgroundColor,
    this.shadowColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    this.margin,
    this.elevation = 1,
    this.hoverElevation = 4,
  });

  @override
  State<HoverChip> createState() => _HoverChipState();
}

class _HoverChipState extends State<HoverChip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  late Animation<Color?> _colorAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _elevationAnimation = Tween<double>(
      begin: widget.elevation,
      end: widget.hoverElevation,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _colorAnimation = ColorTween(
      begin: widget.backgroundColor ?? Theme.of(context).chipTheme.backgroundColor,
      end: widget.hoverBackgroundColor ?? 
          (widget.backgroundColor ?? Theme.of(context).chipTheme.backgroundColor)?.withValues(alpha: 0.8),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Material(
                elevation: _elevationAnimation.value,
                borderRadius: BorderRadius.circular(50), // Forma de píldora
                shadowColor: widget.shadowColor ?? 
                    Theme.of(context).primaryColor.withValues(alpha: 0.2),
                color: _colorAnimation.value,
                child: Container(
                  padding: widget.padding,
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
