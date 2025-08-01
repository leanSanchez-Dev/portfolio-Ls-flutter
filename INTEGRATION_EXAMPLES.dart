// // Ejemplo de uso de los componentes de CV

// /*
// 1. INTEGRACIÓN EN COMPONENTE ABOUT:
//    Agrega este código en el archivo about.dart después de los botones sociales:

//    // Importar el componente
//    import 'package:portfolio_ls/components/cv_download_button.dart';

//    // Agregar en la sección de botones
//    const SizedBox(height: 24),
//    Row(
//      mainAxisAlignment: MainAxisAlignment.center,
//      children: [
//        // ... otros botones ...
//        const SizedBox(width: 16),
//        CVDownloadButton(
//          label: 'Descargar CV',
//          showIcon: true,
//        ),
//      ],
//    ),

// 2. BOTÓN FLOTANTE EN CUALQUIER SECCIÓN:
//    FloatingCVButton()

// 3. BOTÓN COMPACTO PARA TOOLBARS:
//    CVDownloadButton(
//      isCompact: true,
//      backgroundColor: Colors.blue,
//    )

// 4. PERSONALIZACIÓN DE DATOS:
//    Edita assets/cv_data.json con tu información real:
//    - Cambia el nombre, título, contacto
//    - Actualiza la experiencia laboral
//    - Modifica habilidades y proyectos
//    - Personaliza el resumen profesional

// 5. PERSONALIZACIÓN DE COLORES PDF:
//    En cv_service.dart, línea ~140, cambia:
//    color: PdfColors.blue900, // Por tu color preferido

// 6. NAVEGACIÓN:
//    Ya está integrada en el menú principal como "CV"
//    El usuario puede hacer scroll hacia la sección

// FUNCIONALIDADES DISPONIBLES:
// ✅ Descarga directa de PDF profesional
// ✅ Previsualización del CV
// ✅ Datos cargados desde JSON
// ✅ Diseño responsivo
// ✅ Animaciones integradas
// ✅ Compatible web y móvil
// ✅ Navegación automática
// ✅ Manejo de errores

// PRÓXIMOS PASOS:
// 1. Personaliza cv_data.json con tus datos reales
// 2. Ajusta colores en cv_service.dart si es necesario
// 3. Prueba la descarga en web y móvil
// 4. Considera agregar botones en otras secciones
// */

// // Ejemplo de integración completa en about.dart:

// import 'package:portfolio_ls/components/cv_download_button.dart';

// // En el widget build, después de los social links:
// Column(
//   children: [
//     const SocialRow(),
//     const SizedBox(height: 24),
//     // Fila con botones de acción
//     Wrap(
//       alignment: WrapAlignment.center,
//       spacing: 16,
//       runSpacing: 12,
//       children: [
//         // Botón para contacto (existente)
//         ElevatedButton.icon(
//           onPressed: () => _launchEmail(context),
//           icon: const Icon(FontAwesomeIcons.envelope),
//           label: Text(AppLocalizations.of(context)!.contactMe),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Theme.of(context).primaryColor,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//         ),
//         // Nuevo botón de CV
//         const CVDownloadButton(
//           label: 'Descargar CV',
//           showIcon: true,
//         ),
//       ],
//     ),
//   ],
// );
