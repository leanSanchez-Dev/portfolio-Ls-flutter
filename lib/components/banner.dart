import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BannerInf extends StatefulWidget {
  const BannerInf({super.key});

  @override
  State<BannerInf> createState() => _BannerInfState();
}

class _BannerInfState extends State<BannerInf> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: context.screenWidth * 0.85,
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
      child: Column(
        children: [
          Image.asset(
            'assets/dev_bg.png',
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const SizedBox(height: 16),
          const Text(
            'Let\'s go!!',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Let\'s make something great together',
            style: TextStyle(fontSize: 14, color: Colors.teal.shade50),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
              style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(4),
                shadowColor: WidgetStatePropertyAll(
                  Colors.grey.withOpacity(0.5),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Contact Me',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
