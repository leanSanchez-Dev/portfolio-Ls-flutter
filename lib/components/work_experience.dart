import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:velocity_x/velocity_x.dart';

import '../models/experience.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  final skillsKey = GlobalKey();

  List<Experience> experiencias =
      jsonStr.map((item) => Experience.fromJson(item)).toList();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth < 900
          ? context.screenWidth * 0.9
          : context.screenWidth < 1600
              ? context.screenWidth * 0.5
              : context.screenWidth * 0.64,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            'Work experience'.toUpperCase(),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          // const SizedBox(height: 8),
          Timeline.tileBuilder(
            shrinkWrap: true,
            reverse: true,
            physics: const NeverScrollableScrollPhysics(),
            // scrollDirection: Axis.vertical,
            theme: TimelineThemeData(
              connectorTheme:
                  ConnectorThemeData(space: 24, color: Colors.cyan.shade900),
              indicatorTheme:
                  IndicatorThemeData(size: 16.0, color: Colors.cyan.shade900),
            ),
            builder: TimelineTileBuilder.fromStyle(
                itemCount: experiencias.length,
                contentsAlign: ContentsAlign.alternating,
                contentsBuilder: (_, i) {
                  return Card(
                    child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Text(
                              experiencias[i].empresa,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              experiencias[i].descripcion,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.teal.shade50),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${experiencias[i].fechaInicio} / ${experiencias[i].fechaFin}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.white54,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
