import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnimatedContact extends StatefulWidget {
  final IconData iconData;
  final String title;
  final String subTitle;
  final void Function()? onTap;

  const AnimatedContact({
    super.key,
    required this.iconData,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  State<AnimatedContact> createState() => _AnimatedContactState();
}

class _AnimatedContactState extends State<AnimatedContact> {
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
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovering
                ? const Color(0xFf003731)
                : Theme.of(context).cardColor,
          ),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FaIcon(
                  widget.iconData,
                  size: 20,
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w500),
                ),
                Text(
                  widget.subTitle,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
