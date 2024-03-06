import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animated_icon_buttom.dart';

class SocialRow extends StatefulWidget {
  const SocialRow({super.key});

  @override
  State<SocialRow> createState() => _SocialRowState();
}

class _SocialRowState extends State<SocialRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedIconButtom(iconData: FontAwesomeIcons.facebook, onTap: () {}),
        const SizedBox(width: 8),
        AnimatedIconButtom(iconData: FontAwesomeIcons.instagram, onTap: () {}),
        const SizedBox(width: 8),
        AnimatedIconButtom(iconData: FontAwesomeIcons.xTwitter, onTap: () {}),
      ],
    );
  }
}
