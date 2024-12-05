import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animated_contact.dart';
import 'package:portfolio_ls/utils/social_row.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

import '../utils/animated_icon_buttom.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  bool _isFirstImage = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth < 900
          ? context.screenWidth * 0.93
          : context.screenWidth < 1600
              ? context.screenWidth * 0.4
              : context.screenWidth * 0.2,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.3), // Color de la sombra
            blurRadius: 5,
            spreadRadius: 0.05,
          ),
        ],
      ),
      padding: const EdgeInsets.all(30),
      height: context.screenWidth > 900
          ? context.screenHeight + 50
          : context.screenWidth < 900
              ? null
              : context.screenHeight * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  AnimatedSwitcher(
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    duration: const Duration(milliseconds: 800),
                    child: _isFirstImage
                        ? Image.asset(
                            'assets/dev_bg.png',
                            key: const ValueKey<String>('dev_bg'),
                            height: MediaQuery.of(context).size.height * 0.2,
                          )
                        : Image.asset(
                            'assets/ls_bg.png',
                            key: const ValueKey<String>('ls_bg'),
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                  ),
                  const SizedBox(height: 20),
                  Positioned(
                    right: 1,
                    bottom: 1,
                    child: AnimatedIconButtom(
                        borderRadius: 30,
                        iconData: FontAwesomeIcons.cameraRotate,
                        onTap: _toggleImage),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Leonardo Sanchez',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  // 'Tecnólogo en Análisis y Desarrollo de Sistemas de Información (ADSI) con competencias en desarrollo de software, diseño mobile y análisis de bases de datos. Estoy familiarizado con la metodología ágil Scrum y me dedico a crear, planificar, gestionar y ejecutar programas que buscan mejorar la eficiencia empresarial, todo ello manteniendo siempre un alto estándar de ética profesional.',
                  'Technologist in Analysis and Development of Information Systems (ADSI) with skills in software development, mobile design and database analysis. I am familiar with the Agile Scrum methodology and I am dedicated to creating, planning, managing and executing programs that seek to improve business efficiency, all while maintaining a high standard of professional ethics.',
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    Chip(
                      label: const Text(
                        'Flutter Developer',
                        style: TextStyle(fontSize: 14),
                      ),
                      backgroundColor: Colors.cyan.shade900,
                      elevation: 1,
                      padding: const EdgeInsets.all(8),
                      side: BorderSide.none,
                    ),
                    Chip(
                      label: const Text(
                        'UX / UI',
                        style: TextStyle(fontSize: 14),
                      ),
                      backgroundColor: Colors.cyan.shade900,
                      elevation: 1,
                      padding: const EdgeInsets.all(8),
                      side: BorderSide.none,
                    ),
                    Chip(
                      label: const Text(
                        'App Developer',
                        style: TextStyle(fontSize: 14),
                      ),
                      backgroundColor: Colors.cyan.shade900,
                      elevation: 1,
                      padding: const EdgeInsets.all(8),
                      side: BorderSide.none,
                    ),
                    Chip(
                      label: const Text(
                        'Frontend Developer',
                        style: TextStyle(fontSize: 14),
                      ),
                      backgroundColor: Colors.cyan.shade900,
                      elevation: 1,
                      padding: const EdgeInsets.all(8),
                      side: BorderSide.none,
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 5),
              AnimatedContact(
                title: 'Linkedin',
                subTitle: 'Leonardo Sanchez',
                iconData: FontAwesomeIcons.linkedinIn,
                onTap: () => launch(
                    'https://www.linkedin.com/in/leansanchez-dev/',
                    isNewTab: true),
              ),
              const SizedBox(height: 10),
              AnimatedContact(
                title: 'E-mail',
                subTitle: 'Leansanchez14@gmail.com',
                iconData: FontAwesomeIcons.envelopesBulk,
                onTap: () {},
              ),
              const SizedBox(height: 5),
              AnimatedContact(
                title: 'GitHub',
                subTitle: 'LeanSanchez-dev',
                iconData: FontAwesomeIcons.github,
                onTap: () => launch('https://github.com/leanSanchez-Dev',
                    isNewTab: true),
              ),
              const SizedBox(height: 5),
              AnimatedContact(
                title: 'GitLab',
                subTitle: 'LeanSanchez-dev',
                iconData: FontAwesomeIcons.gitlab,
                onTap: () => launch('https://gitlab.com//leansanchez-dev/',
                    isNewTab: true),
              ),
              const SizedBox(height: 5),
            ],
          ),
          const Column(
            children: [
              Divider(),
              SocialRow(),
            ],
          ),
        ],
      ),
    );
  }

  _toggleImage() {
    setState(() {
      _isFirstImage = !_isFirstImage;
    });
  }

  Future<void> launch(String url, {bool isNewTab = true}) async {
    await launchUrl(
      Uri.parse(url),
      webOnlyWindowName: isNewTab ? '_blank' : '_self',
    );
  }
}
