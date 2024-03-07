import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/animated_contact.dart';
import 'package:portfolio_ls/utils/social_row.dart';
import 'package:velocity_x/velocity_x.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth < 900
          ? context.screenWidth * 0.9
          : context.screenWidth < 1600
              ? context.screenWidth * 0.3
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
          ? context.screenHeight
          : context.screenWidth < 900
              ? null
              : context.screenHeight * 0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Image.asset(
                'assets/dev.png',
                height: 156,
              ),
              const Text(
                'Leonardo',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Tecnólogo en Análisis y Desarrollo de Sistemas de Información (ADSI) con competencias en desarrollo de software, diseño mobile y análisis de bases de datos. Estoy familiarizado con la metodología ágil Scrum y me dedico a crear, planificar, gestionar y ejecutar programas que buscan mejorar la eficiencia empresarial, todo ello manteniendo siempre un alto estándar de ética profesional.',
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
                onTap: () {},
              ),
              const SizedBox(height: 10),
              AnimatedContact(
                title: 'GitHub',
                subTitle: 'LeanSanchez-dev',
                iconData: FontAwesomeIcons.github,
                onTap: () {},
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
}
