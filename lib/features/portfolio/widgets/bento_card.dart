import 'package:flutter/material.dart';
import 'package:portfolio_ls/core/theme/app_colors_extension.dart';

/// Surface card with 24 radius, 1px border, and -3px hover lift on pointer devices.
class BentoCard extends StatefulWidget {
  const BentoCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.clipBehavior = Clip.antiAlias,
    this.backgroundColor,
    this.borderColor,
    this.enableHoverLift = true,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Clip clipBehavior;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool enableHoverLift;

  @override
  State<BentoCard> createState() => _BentoCardState();
}

class _BentoCardState extends State<BentoCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).extension<AppColorsExtension>()!;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final lift = widget.enableHoverLift && _hovered && !reduceMotion;

    Widget content = AnimatedContainer(
      duration: reduceMotion
          ? Duration.zero
          : const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
      transform: Matrix4.translationValues(0, lift ? -3 : 0, 0),
      margin: widget.margin,
      padding: widget.padding,
      clipBehavior: widget.clipBehavior,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? colors.bgSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: lift
              ? colors.accentPrimary.withValues(alpha: 0.35)
              : (widget.borderColor ?? colors.borderSubtle),
          width: 1,
        ),
        boxShadow: lift
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.35),
                  blurRadius: 28,
                  offset: const Offset(0, 14),
                ),
                BoxShadow(
                  color: colors.accentPrimary.withValues(alpha: 0.18),
                  blurRadius: 20,
                  offset: const Offset(0, 0),
                ),
              ]
            : null,
      ),
      child: widget.child,
    );

    if (widget.onTap != null) {
      content = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Semantics(
          button: true,
          child: GestureDetector(
            onTap: widget.onTap,
            behavior: HitTestBehavior.opaque,
            child: content,
          ),
        ),
      );
    } else if (widget.enableHoverLift) {
      content = MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: content,
      );
    }

    return content;
  }
}
