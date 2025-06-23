import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Footer extends StatefulWidget {
  const Footer({super.key});

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0x00f7f7f7), // Color de fondo
      padding: const EdgeInsets.symmetric(
          vertical: 10.0), // Padding superior e inferior

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centrar el contenido
        children: [
          const Text(
            '© 2024 - LeanSanchez-Dev', // Texto del copyright
            style: TextStyle(
                fontSize: 14.0, color: Colors.grey), // Estilo del texto
          ),
          const SizedBox(
              width: 10.0), // Espacio entre el texto e iconos (opcional)

          // Opción 2: Iconos de redes sociales (reemplazar con tus enlaces)
          IconButton(
              icon: const Icon(FontAwesomeIcons.facebook, color: Colors.grey),
              onPressed: () {}), // Abrir enlace en el navegador

          const SizedBox(width: 5.0),
          IconButton(
              icon: const Icon(FontAwesomeIcons.twitter, color: Colors.grey),
              onPressed: () {}),
        ],
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.all(20),
    //   margin: const EdgeInsets.only(top: 20),
    //   child: const Column(
    //     children: [
    //       SizedBox(
    //         height: 10,
    //       ),
    //       Text('data')
    //     ],
    //   ),
    // );
  }
}
