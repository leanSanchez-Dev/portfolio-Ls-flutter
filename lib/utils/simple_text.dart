import 'package:flutter/material.dart';

class SimpleTypewriterText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const SimpleTypewriterText({
    super.key,
    required this.text,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
