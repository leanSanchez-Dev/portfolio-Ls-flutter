import 'dart:async';

import 'package:flutter/material.dart';

import 'package:portfolio_ls/components/about.dart';
import 'package:portfolio_ls/components/banner.dart';
import 'package:portfolio_ls/components/projects.dart';
import 'package:portfolio_ls/components/work_experience.dart';
import 'package:portfolio_ls/components/footer.dart';
import 'package:portfolio_ls/components/skills.dart';
// import 'package:portfolio_ls/providers/theme_provider.dart';
// import 'package:provider/provider.dart';

class Portfolio extends StatefulWidget {
  const Portfolio({super.key});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  List<Widget> navItems = [];
  bool isMobile = false;
  final skillsKey = GlobalKey();
  final workExp = GlobalKey();
  final project = GlobalKey();
  final contact = GlobalKey();

  @override
  void initState() {
    navItems = [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(2),
            shadowColor: WidgetStatePropertyAll(
              Colors.cyan.withOpacity(0.3),
            ),
          ),
          onPressed: () {
            if (isMobile) {
              Navigator.pop(context);
            }
            Timer(const Duration(milliseconds: 200), () {
              Scrollable.ensureVisible(workExp.currentContext!);
            });
          },
          child: const Text(
            'Work Experience',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(2),
              shadowColor: WidgetStatePropertyAll(
                Colors.cyan.withOpacity(0.3),
              ),
            ),
            onPressed: () {
              if (isMobile) {
                Navigator.pop(context);
              }
              Timer(const Duration(milliseconds: 200), () {
                Scrollable.ensureVisible(skillsKey.currentContext!);
              });
            },
            child: const Text(
              'Skills',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(2),
              shadowColor: WidgetStatePropertyAll(
                Colors.cyan.withOpacity(0.3),
              ),
            ),
            onPressed: () {
              if (isMobile) {
                Navigator.pop(context);
              }
              Timer(const Duration(milliseconds: 200), () {
                Scrollable.ensureVisible(project.currentContext!);
              });
            },
            child: const Text(
              'Projects',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
            style: ButtonStyle(
              elevation: const WidgetStatePropertyAll(2),
              shadowColor: WidgetStatePropertyAll(
                Colors.cyan.withOpacity(0.3),
              ),
            ),
            onPressed: () {
              if (isMobile) {
                Navigator.pop(context);
              }
              Timer(const Duration(milliseconds: 200), () {
                Scrollable.ensureVisible(contact.currentContext!);
              });
            },
            child: const Text(
              'Contact',
              style: TextStyle(
                color: Colors.white,
              ),
            )),
      ),
      // IconButton(
      //     onPressed: () {
      //      Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
      //     },
      //     icon: const Icon(FontAwesomeIcons.a))
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return Scaffold(
      appBar: AppBar(
        title: const Text('LeanSanchez - Dev'),
        actions: isMobile ? null : navItems,
      ),
      drawer: isMobile
          ? Drawer(
              child: ListView(
                children: navItems,
              ),
            )
          : null,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                children: [
                  const About(),
                  WorkExperience(
                    key: workExp,
                  ),
                ],
              ),
              Skills(
                key: skillsKey,
              ),
              Projects(
                key: project,
              ),
              const SizedBox(height: 28),
              BannerInf(
                key: contact,
              ),
              const SizedBox(height: 28),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
