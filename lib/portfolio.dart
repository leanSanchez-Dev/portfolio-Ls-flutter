import 'dart:async';

import 'package:flutter/material.dart';

import 'package:portfolio_ls/components/about.dart';
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

  @override
  void initState() {
    navItems = [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {}, child: const Text('Work Experience')),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              if (isMobile) {
                Navigator.pop(context);
              }
              Timer(const Duration(milliseconds: 200), () {
                Scrollable.ensureVisible(skillsKey.currentContext!);
              });
            },
            child: const Text('Skills')),
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
        title: const Text('Leo Programer'),
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
              const Wrap(
                alignment: WrapAlignment.center,
                spacing: 30,
                children: [
                  About(),
                  WorkExperience(),
                ],
              ),
              Skills(
                key: skillsKey,
              ),
              const Footer()
            ],
          ),
        ),
      ),
    );
  }
}
