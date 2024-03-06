import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/social_row.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 20),
      child: const Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Text('data')
        ],
      ),
    );
  }
}
