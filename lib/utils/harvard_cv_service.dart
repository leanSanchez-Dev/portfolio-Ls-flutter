import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:portfolio_ls/models/cv_model.dart';
import 'package:portfolio_ls/utils/web_pdf_utils.dart';

class HarvardCVService {
  /// Obtiene los datos del CV desde el archivo JSON
  static Future<CVModel> getCVData() async {
    try {
      final jsonString = await rootBundle.loadString('assets/cv_data.json');
      final Map<String, dynamic> jsonData = json.decode(jsonString);
      return CVModel.fromJson(jsonData);
    } catch (e) {
      if (kDebugMode) {
        print('Error al cargar datos del CV: $e');
      }
      rethrow;
    }
  }

  /// Genera un PDF del CV en formato Harvard
  static Future<List<int>> generateHarvardCVPDF(CVModel cvData) async {
    final pdf = pw.Document();

    // Cargar fuentes personalizadas
    pw.Font? regularFont;
    pw.Font? boldFont;
    try {
      final regularFontData =
          await rootBundle.load('fonts/Poppins-Regular.ttf');
      final boldFontData = await rootBundle.load('fonts/Poppins-Bold.ttf');
      regularFont = pw.Font.ttf(regularFontData);
      boldFont = pw.Font.ttf(boldFontData);
    } catch (e) {
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
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return [
            _buildHarvardHeader(cvData),
            pw.SizedBox(height: 30),
            _buildPersonalStatement(cvData),
            pw.SizedBox(height: 25),
            _buildEducation(cvData),
            pw.SizedBox(height: 25),
            _buildProfessionalExperience(cvData),
            pw.SizedBox(height: 25),
            _buildTechnicalSkills(cvData),
            pw.SizedBox(height: 25),
            _buildRelevantProjects(cvData),
          ];
        },
      ),
    );

    return pdf.save();
  }

  /// Encabezado estilo Harvard - centrado y elegante
  static pw.Widget _buildHarvardHeader(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.center,
      children: [
        // Nombre en mayúsculas, centrado y prominente
        pw.Text(
          cvData.name.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 20,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 2,
          ),
          textAlign: pw.TextAlign.center,
        ),
        pw.SizedBox(height: 12),

        // Línea decorativa
        pw.Container(
          height: 1,
          width: 150,
          color: PdfColors.grey800,
        ),
        pw.SizedBox(height: 15),

        // Información de contacto centrada
        pw.Text(
          cvData.email,
          style: const pw.TextStyle(fontSize: 11),
        ),
        pw.SizedBox(height: 5),
        pw.Text(
          '${cvData.phone} • ${cvData.location}',
          style: const pw.TextStyle(fontSize: 11),
        ),

        if (cvData.github != null || cvData.portfolio != null) ...[
          pw.SizedBox(height: 5),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              if (cvData.github != null) ...[
                pw.Text(
                  'GitHub: ${cvData.github}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
                if (cvData.portfolio != null) pw.Text(' • '),
              ],
              if (cvData.portfolio != null)
                pw.Text(
                  'Portfolio: ${cvData.portfolio}',
                  style: const pw.TextStyle(fontSize: 10),
                ),
            ],
          ),
        ],
      ],
    );
  }

  /// Declaración personal - primer párrafo después del encabezado
  static pw.Widget _buildPersonalStatement(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PERSONAL STATEMENT',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 0.5,
          width: 80,
          color: PdfColors.grey600,
        ),
        pw.SizedBox(height: 12),
        pw.Text(
          cvData.summary,
          style: const pw.TextStyle(
            fontSize: 11,
            lineSpacing: 1.4,
          ),
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }

  /// Educación - segunda sección en formato Harvard
  static pw.Widget _buildEducation(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'EDUCATION',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 0.5,
          width: 80,
          color: PdfColors.grey600,
        ),
        pw.SizedBox(height: 12),
        ...cvData.education.map((edu) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 16),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          edu.institution,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Text(
                        '${edu.startDate} - ${edu.endDate}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    edu.degree,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                  if (edu.description.isNotEmpty) ...[
                    pw.SizedBox(height: 3),
                    pw.Text(
                      edu.description,
                      style: const pw.TextStyle(
                        fontSize: 9,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ],
                ],
              ),
            )),
      ],
    );
  }

  /// Experiencia profesional
  static pw.Widget _buildProfessionalExperience(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'PROFESSIONAL EXPERIENCE',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 0.5,
          width: 80,
          color: PdfColors.grey600,
        ),
        pw.SizedBox(height: 12),
        ...cvData.experience.map((exp) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 18),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // Empresa en negritas
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          exp.company,
                          style: pw.TextStyle(
                            fontSize: 11,
                            fontWeight: pw.FontWeight.bold,
                          ),
                        ),
                      ),
                      pw.Text(
                        '${exp.startDate} - ${exp.endDate}',
                        style: const pw.TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 3),
                  // Posición en cursiva
                  pw.Text(
                    exp.position,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontStyle: pw.FontStyle.italic,
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  // Descripción
                  pw.Text(
                    exp.description,
                    style: const pw.TextStyle(
                      fontSize: 10,
                      lineSpacing: 1.3,
                    ),
                  ),
                  if (exp.achievements.isNotEmpty) ...[
                    pw.SizedBox(height: 6),
                    ...exp.achievements.map((achievement) => pw.Container(
                          margin: const pw.EdgeInsets.only(left: 12, bottom: 3),
                          child: pw.Row(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text('• ',
                                  style: const pw.TextStyle(fontSize: 9)),
                              pw.Expanded(
                                child: pw.Text(
                                  achievement,
                                  style: const pw.TextStyle(
                                    fontSize: 9,
                                    lineSpacing: 1.2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ],
                ],
              ),
            )),
      ],
    );
  }

  /// Habilidades técnicas - formato Harvard simplificado
  static pw.Widget _buildTechnicalSkills(CVModel cvData) {
    final skillsByCategory = <String, List<CVSkill>>{};
    for (final skill in cvData.skills) {
      skillsByCategory.putIfAbsent(skill.category, () => []).add(skill);
    }

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'TECHNICAL SKILLS',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 0.5,
          width: 80,
          color: PdfColors.grey600,
        ),
        pw.SizedBox(height: 12),
        ...skillsByCategory.entries.map((entry) => pw.Container(
              margin: const pw.EdgeInsets.only(bottom: 8),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.SizedBox(
                    width: 100,
                    child: pw.Text(
                      '${entry.key}:',
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Text(
                      entry.value.map((skill) => skill.name).join(', '),
                      style: const pw.TextStyle(
                        fontSize: 10,
                        lineSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  /// Proyectos relevantes
  static pw.Widget _buildRelevantProjects(CVModel cvData) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'RELEVANT PROJECTS',
          style: pw.TextStyle(
            fontSize: 12,
            fontWeight: pw.FontWeight.bold,
            letterSpacing: 1,
          ),
        ),
        pw.SizedBox(height: 8),
        pw.Container(
          height: 0.5,
          width: 80,
          color: PdfColors.grey600,
        ),
        pw.SizedBox(height: 12),
        ...cvData.projects.take(4).map((project) => pw.Container(
              // Limitamos a 4 proyectos
              margin: const pw.EdgeInsets.only(bottom: 12),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    project.name,
                    style: pw.TextStyle(
                      fontSize: 10,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    project.description,
                    style: const pw.TextStyle(
                      fontSize: 9,
                      lineSpacing: 1.2,
                    ),
                  ),
                  pw.SizedBox(height: 3),
                  pw.Text(
                    'Technologies: ${project.technologies.join(', ')}',
                    style: pw.TextStyle(
                      fontSize: 8,
                      fontStyle: pw.FontStyle.italic,
                      color: PdfColors.grey700,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }

  /// Descarga CV desde bytes ya generados
  static Future<void> downloadCVFromBytes(
      List<int> pdfBytes, String name) async {
    try {
      if (kIsWeb) {
        // Usar las utilidades web para mayor compatibilidad
        await WebPdfUtils.downloadPdfInBrowser(
          Uint8List.fromList(pdfBytes),
          '${name.replaceAll(' ', '_')}_CV_Harvard.pdf',
        );
      } else {
        await Printing.sharePdf(
          bytes: Uint8List.fromList(pdfBytes),
          filename: '${name.replaceAll(' ', '_')}_CV_Harvard.pdf',
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error al descargar CV Harvard: $e');
      }
      rethrow;
    }
  }
}
