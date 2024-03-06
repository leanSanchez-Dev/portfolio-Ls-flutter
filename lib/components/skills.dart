import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Skills extends StatefulWidget {
  const Skills({Key? key}) : super(key: key);

  @override
  State<Skills> createState() => _SkillsState();
}

class _SkillsState extends State<Skills> {
  double _validationWiht() {
    return context.screenWidth < 900
        ? context.screenWidth * 0.9
        : context.screenWidth < 1600
            ? context.screenWidth * 0.84
            : context.screenWidth * 0.82 / 3;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 30,
      runSpacing: 30,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(
            top: 32,
          ),
          alignment: Alignment.center,
          child: Text(
            'My skills'.toUpperCase(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          width: _validationWiht(),
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
          padding: const EdgeInsets.all(28),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Programing languages',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8),
                child: Divider(),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text(
                      'Dart',
                    ),
                    labelStyle: TextStyle(color: Colors.indigo),
                    side: BorderSide(color: Colors.indigo),
                  ),
                  Chip(
                    label: Text(
                      'Java Mobile',
                    ),
                    labelStyle: TextStyle(color: Colors.indigo),
                    side: BorderSide(color: Colors.indigo),
                  ),
                  Chip(
                    label: Text(
                      'Kotlin',
                    ),
                    labelStyle: TextStyle(color: Colors.indigo),
                    side: BorderSide(color: Colors.indigo),
                  ),
                  Chip(
                    label: Text(
                      'JavaScript',
                    ),
                    labelStyle: TextStyle(color: Colors.indigo),
                    side: BorderSide(color: Colors.indigo),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          width: _validationWiht(),
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
          padding: const EdgeInsets.all(28),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Frameworks',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8),
                child: Divider(),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text(
                      'React Native',
                    ),
                    labelStyle: TextStyle(color: Colors.cyan),
                    side: BorderSide(color: Colors.cyan),
                  ),
                  Chip(
                    label: Text(
                      'Django',
                    ),
                    labelStyle: TextStyle(color: Colors.cyan),
                    side: BorderSide(color: Colors.cyan),
                  ),
                  Chip(
                    label: Text(
                      'Flutter',
                    ),
                    labelStyle: TextStyle(color: Colors.cyan),
                    side: BorderSide(color: Colors.cyan),
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          width: _validationWiht(),
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
          padding: const EdgeInsets.all(28),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Other Tools',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 8),
                child: Divider(),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  Chip(
                    label: Text(
                      'Figma',
                    ),
                    labelStyle: TextStyle(color: Colors.cyan),
                    side: BorderSide(color: Colors.cyan),
                  ),
                  Chip(
                    label: Text(
                      'Illustrator',
                    ),
                    labelStyle: TextStyle(color: Colors.cyan),
                    side: BorderSide(color: Colors.cyan),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
