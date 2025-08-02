import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:portfolio_ls/models/cv_model.dart';
import 'package:portfolio_ls/utils/web_pdf_utils.dart';

class CVService {
  /// Construye la sección de declaración personal estilo Harvard
  static pw.Widget _buildHarvardPersonalStatement(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'DECLARACIÓN PERSONAL',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.blue900,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          cvData.summary,
          style: const pw.TextStyle(fontSize: 12),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }

  /// Construye el encabezado estilo Harvard
  static pw.Widget _buildHarvardHeader(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          cvData.name,
          style: pw.TextStyle(
            fontSize: 32,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal900,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Text(
          cvData.title,
          style: pw.TextStyle(
            fontSize: 18,
            color: PdfColors.grey700,
            fontWeight: pw.FontWeight.normal,
          ),
        ),
        pw.SizedBox(height: 12),
        pw.Row(
          children: [
            pw.Text('📧 ${cvData.email}',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(width: 20),
            pw.Text('📱 ${cvData.phone}',
                style: const pw.TextStyle(fontSize: 12)),
            pw.SizedBox(width: 20),
            pw.Text('📍 ${cvData.location}',
                style: const pw.TextStyle(fontSize: 12)),
          ],
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 2,
          width: double.infinity,
          color: PdfColors.teal700,
        ),
      ],
    );
  }

  // Datos del CV por defecto - reemplaza con tus datos reales
  static CVModel get defaultCVData => const CVModel(
        name: 'Lean Sánchez',
        title: 'Desarrollador Full Stack Flutter/Web',
        email: 'lean.dev@example.com',
        phone: '+XX XXX XXX XXXX',
        location: 'Tu Ciudad, País',
        summary:
            'Desarrollador apasionado por crear aplicaciones web y móviles de alta calidad utilizando Flutter y tecnologías modernas. Con experiencia en desarrollo full-stack y un enfoque en la experiencia del usuario.',
        languages: ['Español (Nativo)', 'Inglés (Avanzado)'],
        experience: [
          CVExperience(
            company: 'Empresa Actual',
            position: 'Desarrollador Flutter Senior',
            startDate: '2023',
            endDate: 'Presente',
            description: 'Desarrollo de aplicaciones móviles y web con Flutter',
            achievements: [
              'Lideré el desarrollo de 3 aplicaciones móviles principales',
              'Implementé arquitectura limpia y patrones de diseño escalables',
              'Mejoré el rendimiento de las aplicaciones en un 40%',
            ],
          ),
          CVExperience(
            company: 'Empresa Anterior',
            position: 'Desarrollador Full Stack',
            startDate: '2021',
            endDate: '2023',
            description: 'Desarrollo web y backend con diversas tecnologías',
            achievements: [
              'Desarrollé APIs REST escalables',
              'Implementé sistemas de autenticación seguros',
              'Trabajé con equipos multidisciplinarios',
            ],
          ),
        ],
        education: [
          CVEducation(
            institution: 'Universidad/Instituto',
            degree: 'Ingeniería en Sistemas/Carrera relacionada',
            startDate: '2018',
            endDate: '2022',
            description:
                'Especialización en desarrollo de software y tecnologías web',
          ),
        ],
        skills: [
          CVSkill(name: 'Flutter', category: 'Frontend', proficiency: 0.95),
          CVSkill(name: 'Dart', category: 'Lenguaje', proficiency: 0.95),
          CVSkill(name: 'JavaScript', category: 'Lenguaje', proficiency: 0.90),
          CVSkill(name: 'TypeScript', category: 'Lenguaje', proficiency: 0.85),
          CVSkill(name: 'Node.js', category: 'Backend', proficiency: 0.85),
          CVSkill(name: 'Firebase', category: 'Backend', proficiency: 0.80),
          CVSkill(name: 'Git', category: 'Herramientas', proficiency: 0.90),
          CVSkill(
              name: 'MongoDB', category: 'Base de Datos', proficiency: 0.75),
        ],
        projects: [
          CVProject(
            name: 'Portfolio Personal',
            description:
                'Portafolio web desarrollado con Flutter para mostrar proyectos y habilidades',
            technologies: ['Flutter', 'Dart', 'Firebase'],
            link: 'https://tu-portfolio.com',
            github: 'https://github.com/tu-usuario/portfolio',
          ),
          CVProject(
            name: 'App de Gestión',
            description:
                'Aplicación móvil para gestión empresarial con funcionalidades avanzadas',
            technologies: ['Flutter', 'Firebase', 'Provider'],
            github: 'https://github.com/tu-usuario/app-gestion',
          ),
        ],
      );

  /// Genera un PDF del CV en formato Harvard
  static Future<Uint8List> generateCVPDF(CVModel cvData) async {
    final pdf = pw.Document();

    // Cargar fuente personalizada si está disponible
    pw.Font? regularFont;
    pw.Font? boldFont;
    try {
      final regularFontData =
          await rootBundle.load('fonts/Poppins-Regular.ttf');
      final boldFontData = await rootBundle.load('fonts/Poppins-Bold.ttf');
      regularFont = pw.Font.ttf(regularFontData);
      boldFont = pw.Font.ttf(boldFontData);
    } catch (e) {
      // Si no se puede cargar la fuente, usar la por defecto
      regularFont = null;
      boldFont = null;
    }

    pdf.addPage(
      pw.MultiPage(
        theme: pw.ThemeData.withFont(
          base: regularFont,
          bold: boldFont,
        ),
        pageFormat: PdfPageFormat.a4,
        margin:
            const pw.EdgeInsets.all(40), // Márgenes más amplios estilo Harvard
        build: (pw.Context context) {
          return [
            _buildHarvardHeader(cvData),
            pw.SizedBox(height: 30),
            _buildHarvardPersonalStatement(cvData),
            pw.SizedBox(height: 25),
            _buildHarvardEducation(cvData),
            pw.SizedBox(height: 25),
            _buildHarvardExperience(cvData),
            pw.SizedBox(height: 25),
            _buildHarvardSkills(cvData),
            pw.SizedBox(height: 25),
            _buildHarvardProjects(cvData),
          ];
        },
      ),
    );

    return pdf.save();
  }

  /// Construye la sección de habilidades estilo Harvard
  static pw.Widget _buildHarvardSkills(CVModel cvData) {
    final skillsByCategory = <String, List<CVSkill>>{};
    for (final skill in cvData.skills) {
      skillsByCategory.putIfAbsent(skill.category, () => []).add(skill);
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'HABILIDADES TÉCNICAS',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal900,
          ),
        ),
        pw.SizedBox(height: 12),
        ...skillsByCategory.entries.map((entry) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  entry.key,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.teal700,
                  ),
                ),
                pw.SizedBox(height: 6),
                pw.Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: entry.value
                      .map((skill) => pw.Container(
                            padding: const pw.EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(color: PdfColors.teal200),
                              borderRadius: pw.BorderRadius.circular(4),
                            ),
                            child: pw.Text(
                              '${skill.name} (${(skill.proficiency * 100).round()}%)',
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                          ))
                      .toList(),
                ),
                pw.SizedBox(height: 8),
              ],
            )),
      ],
    );
  }

  /// Construye la sección de educación estilo Harvard
  static pw.Widget _buildHarvardEducation(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'EDUCACIÓN',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal900,
          ),
        ),
        pw.SizedBox(height: 12),
        ...cvData.education.map((edu) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      edu.degree,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '${edu.startDate} - ${edu.endDate}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Text(
                  edu.institution,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.teal700,
                  ),
                ),
                if (edu.description.isNotEmpty) ...[
                  pw.SizedBox(height: 4),
                  pw.Text(
                    edu.description,
                    style: const pw.TextStyle(fontSize: 11),
                  ),
                ],
                pw.SizedBox(height: 12),
              ],
            )),
      ],
    );
  }

  /// Construye la sección de experiencia estilo Harvard
  static pw.Widget _buildHarvardExperience(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'EXPERIENCIA PROFESIONAL',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal900,
          ),
        ),
        pw.SizedBox(height: 12),
        ...cvData.experience.map((exp) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      exp.position,
                      style: pw.TextStyle(
                        fontSize: 14,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      '${exp.startDate} - ${exp.endDate}',
                      style: pw.TextStyle(
                        fontSize: 12,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ),
                pw.Text(
                  exp.company,
                  style: pw.TextStyle(
                    fontSize: 12,
                    fontStyle: pw.FontStyle.italic,
                    color: PdfColors.teal700,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  exp.description,
                  style: const pw.TextStyle(fontSize: 11),
                ),
                pw.SizedBox(height: 6),
                ...exp.achievements.map((achievement) => pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 16, bottom: 2),
                      child: pw.Text(
                        '• $achievement',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    )),
                pw.SizedBox(height: 12),
              ],
            )),
      ],
    );
  }

  /// Construye la sección de proyectos estilo Harvard
  static pw.Widget _buildHarvardProjects(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PROYECTOS DESTACADOS',
          style: pw.TextStyle(
            fontSize: 16,
            fontWeight: pw.FontWeight.bold,
            color: PdfColors.teal900,
          ),
        ),
        pw.SizedBox(height: 12),
        ...cvData.projects.map((project) => pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  project.name,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  project.description,
                  style: const pw.TextStyle(fontSize: 11),
                ),
                pw.SizedBox(height: 4),
                pw.Text(
                  'Tecnologías: ${project.technologies.join(', ')}',
                  style: pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey700,
                  ),
                ),
                if (project.link != null || project.github != null) ...[
                  pw.SizedBox(height: 4),
                  pw.Row(
                    children: [
                      if (project.link != null)
                        pw.Text(
                          'Demo: ${project.link}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.teal700,
                          ),
                        ),
                      if (project.github != null) ...[
                        if (project.link != null) pw.SizedBox(width: 16),
                        pw.Text(
                          'GitHub: ${project.github}',
                          style: pw.TextStyle(
                            fontSize: 10,
                            color: PdfColors.teal700,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
                pw.SizedBox(height: 12),
              ],
            )),
      ],
    );
  }

  /// Descarga el CV como PDF
  static Future<void> downloadCV({CVModel? customCVData}) async {
    try {
      final cvData = customCVData ?? await getCVData();
      final pdfBytes = await generateCVPDF(cvData);
      await downloadCVFromBytes(pdfBytes, cvData.name);
    } catch (e) {
      if (kDebugMode) {
        print('Error al descargar CV: $e');
      }
      rethrow;
    }
  }

  /// Descarga CV desde bytes ya generados
  static Future<void> downloadCVFromBytes(
      Uint8List pdfBytes, String name) async {
    try {
      if (kIsWeb) {
        // Usar las utilidades web para mayor compatibilidad
        await WebPdfUtils.downloadPdfInBrowser(
          pdfBytes,
          '${name.replaceAll(' ', '_')}_CV.pdf',
        );
      } else {
        // Para móvil, usar el paquete printing
        await Printing.sharePdf(
          bytes: pdfBytes,
          filename: '${name.replaceAll(' ', '_')}_CV.pdf',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al descargar CV desde bytes: $e');
      }
      rethrow;
    }
  }

  /// Previsualiza el CV
  static Future<void> previewCV({CVModel? customCVData}) async {
    try {
      final cvData = customCVData ?? await getCVData();
      final pdfBytes = await generateCVPDF(cvData);

      // Verificar si podemos usar Printing.layoutPdf
      if (WebPdfUtils.isPdfPreviewSupported) {
        await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async => pdfBytes,
          name: '${cvData.name} - CV',
        );
      } else {
        // En web production, abrir en nueva pestaña
        if (kIsWeb) {
          await WebPdfUtils.openPdfInNewTab(
            pdfBytes,
            '${cvData.name.replaceAll(' ', '_')}_CV.pdf',
          );
        } else {
          // Fallback para móvil
          await Printing.sharePdf(
            bytes: pdfBytes,
            filename: '${cvData.name.replaceAll(' ', '_')}_CV.pdf',
          );
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al previsualizar CV: $e');
      }
      rethrow;
    }
  }

  /// Obtiene los datos del CV (carga desde asset JSON)
  static Future<CVModel> getCVData() async {
    try {
      final String response =
          await rootBundle.loadString('assets/cv_data.json');
      final Map<String, dynamic> data = jsonDecode(response);
      return CVModel.fromJson(data);
    } catch (e) {
      if (kDebugMode) {
        print('Error cargando CV desde asset: $e');
      }
      // Si hay error cargando el archivo, lanzar excepción
      rethrow;
    }
  }

  /// Guarda los datos del CV
  static Future<void> saveCVData(CVModel cvData) async {
    // Implementar guardado según tus necesidades
    // Por ejemplo, en SharedPreferences o archivo local
    if (kDebugMode) {
      print('CV guardado: ${cvData.name}');
    }
  }
}
