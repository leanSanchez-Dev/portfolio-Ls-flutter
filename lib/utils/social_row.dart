import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animated_icon_buttom.dart';
import 'package:url_launcher/url_launcher.dart';

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
        AnimatedIconButtom(
          iconData: FontAwesomeIcons.facebook,
          onTap: () =>
              launch('https://www.facebook.com/andres.zanz', isNewTab: true),
        ),
        const SizedBox(width: 8),
        AnimatedIconButtom(
          iconData: FontAwesomeIcons.instagram,
          onTap: () =>
              launch('https://www.instagram.com/mcfadden1498/', isNewTab: true),
        ),
        const SizedBox(width: 8),
        AnimatedIconButtom(
          iconData: FontAwesomeIcons.xTwitter,
          onTap: () =>
              launch('https://twitter.com/s4nchez_leo', isNewTab: true),
        ),
      ],
    );
  }
}

Future<void> launch(String url, {bool isNewTab = true}) async {
  await launchUrl(
    Uri.parse(url),
    webOnlyWindowName: isNewTab ? '_blank' : '_self',
  );
}
