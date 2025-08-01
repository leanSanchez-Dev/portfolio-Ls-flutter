// Ejemplo de uso de los widgets de hover estilo Core Competencies
import 'package:flutter/material.dart';
import 'package:portfolio_ls/utils/shaped_hover_widgets.dart';

class HoverExamplesPage extends StatelessWidget {
  const HoverExamplesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplos de Hover Estilo Core Competencies'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tarjetas Estilo Core Competencies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            
            // Ejemplo de tarjeta con ícono y título
            CompetencyStyleCard(
              icon: Icons.code,
              title: 'Desarrollo de Software',
              child: const Text(
                'Esta es una tarjeta con el estilo visual de Core Competencies. '
                'Incluye sombras suaves, bordes redondeados y animaciones de hover.',
              ),
            ),
            const SizedBox(height: 20),
            
            // Ejemplo de otra tarjeta
            CompetencyStyleCard(
              icon: Icons.design_services,
              title: 'Diseño UI/UX',
              child: const Text(
                'Esta tarjeta también utiliza el estilo elegante de Core Competencies '
                'con elevación suave y animaciones fluidas.',
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              'Chips de Tecnología',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Ejemplo de chips estilo Core Competencies
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                CompetencyStyleChip(
                  text: 'Flutter',
                  backgroundColor: Colors.blue.withValues(alpha: 0.1),
                ),
                CompetencyStyleChip(
                  text: 'React',
                  backgroundColor: Colors.cyan.withValues(alpha: 0.1),
                ),
                CompetencyStyleChip(
                  text: 'Firebase',
                  backgroundColor: Colors.orange.withValues(alpha: 0.1),
                ),
                CompetencyStyleChip(
                  text: 'MongoDB',
                  backgroundColor: Colors.green.withValues(alpha: 0.1),
                ),
              ],
            ),

            const SizedBox(height: 40),

            const Text(
              'Contenedores de Hover',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Ejemplo de contenedor con hover personalizado
            CompetencyContainer(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.web, size: 32, color: Colors.blue),
                      const SizedBox(width: 12),
                      Text(
                        'Desarrollo Web',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Este contenedor tiene efectos de hover suaves y elegantes, '
                    'creando una experiencia visual cohesiva con el resto del portafolio.',
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
