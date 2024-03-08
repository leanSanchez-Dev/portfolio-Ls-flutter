import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedIconButtom extends StatefulWidget {
  final IconData iconData;
  final double? borderRadius;
  final VoidCallback onTap;

  const AnimatedIconButtom({
    super.key,
    required this.iconData,
    required this.onTap,
    this.borderRadius = 12,
  });

  @override
  State<AnimatedIconButtom> createState() => _AnimatedIconButtomState();
}

class _AnimatedIconButtomState extends State<AnimatedIconButtom> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: isHovering
              ? const Color(0xFf003731)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          border: Border.all(
            color: isHovering
                ? const Color(0xFf003731)
                : Theme.of(context).cardColor,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: FaIcon(
            widget.iconData,
            size: 20,
          ),
        ),
      ),
    );
  }
}
