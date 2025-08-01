import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/models/cv_model.dart';
import 'package:portfolio_ls/utils/harvard_cv_service.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/components/cv_preview_screen.dart';

class CVSection extends StatefulWidget {
  const CVSection({super.key});

  @override
  State<CVSection> createState() => _CVSectionState();
}

class _CVSectionState extends State<CVSection> {
  CVModel? _cvData;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadCVData();
  }

  Future<void> _loadCVData() async {
    setState(() => _isLoading = true);
    try {
      final cvData = await HarvardCVService.getCVData();
      setState(() => _cvData = cvData);
    } catch (e) {
      if (kDebugMode) {
        print('Error loading CV data: $e');
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _previewCV() async {
    if (_cvData == null) return;

    setState(() => _isLoading = true);
    try {
      // Navegar a la pantalla de preview
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CVPreviewScreen(cvData: _cvData!),
        ),
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Opening CV preview'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error opening CV preview'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _downloadCV() async {
    if (_cvData == null) return;

    setState(() => _isLoading = true);
    try {
      // Generar PDF en formato Harvard
      final pdfBytes = await HarvardCVService.generateHarvardCVPDF(_cvData!);
      // Descargar el PDF
      await HarvardCVService.downloadCVFromBytes(pdfBytes, _cvData!.name);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Harvard CV downloaded successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error downloading CV'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            children: [
              Column(
                children: [
                  // Título de la sección
                  AnimatedFadeSlide(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Mi CV',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  AnimatedFadeSlide(
                    delay: const Duration(milliseconds: 200),
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      'Descarga o previsualiza mi curriculum vitae',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.textTheme.bodyLarge?.color
                            ?.withValues(alpha: 0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),

                  if (_isLoading)
                    const CircularProgressIndicator()
                  else if (_cvData != null) ...[
                    // Tarjeta del CV
                    AnimatedFadeSlide(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 600),
                      child: HoverCard(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          children: [
                            // Header del CV
                            Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    color: theme.primaryColor
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.fileText,
                                    size: 40,
                                    color: theme.primaryColor,
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _cvData!.name,
                                        style: theme.textTheme.headlineSmall
                                            ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _cvData!.title,
                                        style:
                                            theme.textTheme.bodyLarge?.copyWith(
                                          color: theme.primaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        _cvData!.summary,
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                          color: theme
                                              .textTheme.bodyMedium?.color
                                              ?.withValues(alpha: 0.7),
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Estadísticas del CV
                            Row(
                              children: [
                                Expanded(
                                  child: _buildStatCard(
                                    icon: FontAwesomeIcons.briefcase,
                                    title: 'Experiencia',
                                    value: '${_cvData!.experience.length}',
                                    subtitle: 'empresas',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildStatCard(
                                    icon: FontAwesomeIcons.graduationCap,
                                    title: 'Educación',
                                    value: '${_cvData!.education.length}',
                                    subtitle: 'títulos',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildStatCard(
                                    icon: FontAwesomeIcons.code,
                                    title: 'Habilidades',
                                    value: '${_cvData!.skills.length}',
                                    subtitle: 'tecnologías',
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: _buildStatCard(
                                    icon: FontAwesomeIcons.projectDiagram,
                                    title: 'Proyectos',
                                    value: '${_cvData!.projects.length}',
                                    subtitle: 'completados',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 32),

                            // Botones de acción
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedHoverContainer(
                                  hoverScale: 1.05,
                                  child: ElevatedButton.icon(
                                    onPressed: _isLoading ? null : _previewCV,
                                    icon: const Icon(FontAwesomeIcons.eye),
                                    label: const Text('Previsualizar'),
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                AnimatedHoverContainer(
                                  hoverScale: 1.05,
                                  child: ElevatedButton.icon(
                                    onPressed: _isLoading ? null : _downloadCV,
                                    icon: const Icon(FontAwesomeIcons.download),
                                    label: const Text('Descargar PDF'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: theme.primaryColor,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24,
                                        vertical: 16,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Vista previa de habilidades
                  ] else
                    const Text(
                      'Error al cargar los datos del CV',
                      style: TextStyle(color: Colors.red),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.dividerColor.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: theme.primaryColor,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.6),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
