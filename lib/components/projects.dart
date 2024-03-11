import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/models/projects.dart';
import 'package:portfolio_ls/utils/animated_icon_buttom.dart';
import 'package:portfolio_ls/utils/social_row.dart';
import 'package:velocity_x/velocity_x.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final CarouselController _controller = CarouselController();
  List<Project> projects =
      jsonPj.map((item) => Project.fromJson(item)).toList();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth * 0.85,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).cardColor,
      //   borderRadius: BorderRadius.circular(20.0),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.cyan.withOpacity(0.3), // Color de la sombra
      //       blurRadius: 5,
      //       spreadRadius: 0.05,
      //     ),
      //   ],
      // ),
      // padding: const EdgeInsets.all(30),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 28, bottom: 28),
            child: Text(
              'Projects'.toUpperCase(),
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _cardProjects()
        ],
      ),
    );
  }

  _cardProjects() {
    return Stack(
      children: [
        CarouselSlider.builder(
          itemCount: projects.length,
          carouselController: _controller,
          options: CarouselOptions(
            height: context.screenHeight * 0.55,
            aspectRatio: 16 / 9,
            autoPlay: false,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            viewportFraction: 0.8,
          ),
          itemBuilder: (BuildContext context, int index, int realIndex) {
            return _buildCard(projects[index]);
          },
        ),
        const SizedBox(height: 20),
        Positioned(
          bottom: 50,
          top: 50,
          left: context.screenWidth <= 900
              ? 10
              : context.screenWidth < 1200
                  ? 40
                  : 80,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _controller.previousPage(),
          ),
        ),
        Positioned(
          bottom: 50,
          top: 50,
          right: context.screenWidth <= 900
              ? 5
              : context.screenWidth < 1200
                  ? 40
                  : 80,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () => _controller.nextPage(),
          ),
        ),
      ],
    );

    // for (Project project in projects) {
    //   return Text(
    //       'Project: ${project.project}, Empresa: ${project.empresa}, Tag: ${project.tag}');
    // }
  }

  Widget _buildCard(Project project) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            spreadRadius: 4.0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.0),
        child: Stack(
          children: [
            // Neon effect
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    project.url,
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.3), // Color de la sombra
                    blurRadius: 5,
                    spreadRadius: 0.05,
                  ),
                ],
              ),
            ),
            // Glassmorphism effect
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  // stops: const [0.3, 0.5],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.cyan.withOpacity(0.1),
                    Theme.of(context).cardColor.withOpacity(0.4),
                  ],
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.project.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 4,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    project.empresa,
                    style: TextStyle(fontSize: 14, color: Colors.teal.shade50),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Chip(
                        padding: const EdgeInsets.all(8),
                        side: BorderSide.none,
                        elevation: 1,
                        labelPadding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 5),
                        label: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              project.tag == 'Flutter'
                                  ? FontAwesomeIcons.mobileScreen
                                  : FontAwesomeIcons.android,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              project.tag,
                              style: const TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      AnimatedIconButtom(
                        iconData: FontAwesomeIcons.github,
                        onTap: () => launch(
                            'https://github.com/leanSanchez-Dev',
                            isNewTab: true),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
