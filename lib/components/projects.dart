import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/models/projects.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:url_launcher/url_launcher.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> with TickerProviderStateMixin {
  final CarouselSliderController _controller = CarouselSliderController();
  late AnimationController _headerController;
  late AnimationController _carouselController;

  List<Project> projects =
      jsonPj.map((item) => Project.fromJson(item)).toList();
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _carouselController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    if (mounted) {
      _headerController.forward();
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) {
        _carouselController.forward();
      }
    });
  }

  @override
  void dispose() {
    _headerController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container( 
      margin: const EdgeInsets.symmetric(vertical: 40),
      width: double.infinity, 
      child: Column(
        children: [
          _buildHeader(),
          const SizedBox(height: 40),
          _buildProjectsCarousel(),
          const SizedBox(height: 32),
          _buildIndicators(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return AnimatedBuilder(
      animation: _headerController,
      builder: (context, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -0.3),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: _headerController,
            curve: Curves.easeOut,
          )),
          child: FadeTransition(
            opacity: _headerController,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        FontAwesomeIcons.folderOpen,
                        color: Theme.of(context).primaryColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Featured Projects',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Explore some of my recent work and personal projects',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.7),
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Container(
                  height: 1,
                  width: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Theme.of(context).primaryColor.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectsCarousel() {
    return AnimatedBuilder(
      animation: _carouselController,
      builder: (context, child) {
        return ScaleTransition(
          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
            CurvedAnimation(
              parent: _carouselController,
              curve: Curves.easeOut,
            ),
          ),
          child: FadeTransition(
            opacity: _carouselController,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: projects.length,
                    carouselController: _controller,
                    options: CarouselOptions(
                      height: MediaQuery.of(context).size.height * 0.6,
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 5),
                      enlargeCenterPage: true,
                      enableInfiniteScroll: true,
                      viewportFraction:
                          MediaQuery.of(context).size.width < 900 ? 0.85 : 0.7,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      return _buildProjectCard(projects[index], index);
                    },
                  ),

                  // Navigation arrows
                  if (MediaQuery.of(context).size.width > 900) ...[
                    Positioned(
                      left: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedHoverContainer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.chevronLeft,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () => _controller.previousPage(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: AnimatedHoverContainer(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .shadowColor
                                      .withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.chevronRight,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () => _controller.nextPage(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectCard(Project project, int index) {
    return AnimatedHoverContainer(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).shadowColor.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Stack(
            children: [
              // Project image
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(project.url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Gradient overlay
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.8),
                    ],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),

              // Content
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  project.tag == 'Flutter'
                                      ? FontAwesomeIcons.mobileScreen
                                      : FontAwesomeIcons.code,
                                  color: Colors.white,
                                  size: 12,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  project.tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          AnimatedHoverContainer(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.3),
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  FontAwesomeIcons.github,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                onPressed: () => _launchGitHub(),
                                iconSize: 16,
                                padding: const EdgeInsets.all(8),
                                constraints: const BoxConstraints(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        project.project,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.building,
                            color: Colors.white.withOpacity(0.8),
                            size: 14,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            project.empresa,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: projects.asMap().entries.map((entry) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentIndex == entry.key ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentIndex == entry.key
                ? Theme.of(context).primaryColor
                : Theme.of(context).primaryColor.withOpacity(0.3),
          ),
        );
      }).toList(),
    );
  }

  Future<void> _launchGitHub() async {
    const url = 'https://github.com/leanSanchez-Dev';
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }
}
