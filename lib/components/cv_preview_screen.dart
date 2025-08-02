import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/models/cv_model.dart';
import 'package:portfolio_ls/utils/harvard_cv_service.dart';
import 'package:portfolio_ls/utils/animations.dart';
import 'package:portfolio_ls/utils/web_pdf_utils.dart';
import 'package:printing/printing.dart';

class CVPreviewScreen extends StatefulWidget {
  final CVModel cvData;

  const CVPreviewScreen({
    super.key,
    required this.cvData,
  });

  @override
  State<CVPreviewScreen> createState() => _CVPreviewScreenState();
}

class _CVPreviewScreenState extends State<CVPreviewScreen> {
  bool _isLoading = true;
  Uint8List? _pdfBytes;
  String? _error;

  @override
  void initState() {
    super.initState();
    _generatePDF();
  }

  Future<void> _generatePDF() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final pdfBytes =
          await HarvardCVService.generateHarvardCVPDF(widget.cvData);

      if (mounted) {
        setState(() {
          _pdfBytes = Uint8List.fromList(pdfBytes);
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Error al generar el PDF: $e';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _downloadPDF() async {
    if (_pdfBytes == null) return;

    try {
      await HarvardCVService.downloadCVFromBytes(
          _pdfBytes!, widget.cvData.name);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('CV descargado exitosamente'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al descargar: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Vista Previa - ${widget.cvData.name}',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(FontAwesomeIcons.arrowLeft),
        ),
        actions: [
          if (_pdfBytes != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: AnimatedHoverContainer(
                hoverScale: 1.05,
                child: ElevatedButton.icon(
                  onPressed: _downloadPDF,
                  icon: const Icon(
                    FontAwesomeIcons.download,
                    size: 16,
                  ),
                  label: const Text('Descargar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _buildBody(theme),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (_isLoading) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Generando vista previa del CV...',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              FontAwesomeIcons.exclamationTriangle,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error al generar la vista previa',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.red,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _generatePDF,
              icon: const Icon(FontAwesomeIcons.redo),
              label: const Text('Reintentar'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    if (_pdfBytes != null) {
      // Verificar si PdfPreview es compatible con el entorno actual
      if (!WebPdfUtils.isPdfPreviewSupported) {
        return _buildWebProductionPreview();
      }

      // En debug o móvil, usar PdfPreview normal
      return Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: PdfPreview(
                build: (format) => _pdfBytes!,
                allowPrinting: false,
                allowSharing: true,
                canChangePageFormat: false,
                canDebug: false,
                maxPageWidth: 800,
                pdfFileName:
                    '${widget.cvData.name.replaceAll(' ', '_')}_CV.pdf',
                actions: const [], // Remover acciones por defecto
                scrollViewDecoration: BoxDecoration(
                  color: theme.cardColor,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return const Center(
      child: Text('No se pudo cargar la vista previa'),
    );
  }

  Widget _buildWebProductionPreview() {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.dividerColor.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      FontAwesomeIcons.filePdf,
                      size: 80,
                      color: theme.primaryColor,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Vista previa del CV',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'El CV de ${widget.cvData.name} está listo para descargar.',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'En la versión web, la previsualización está limitada por seguridad del navegador.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.5),
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedHoverContainer(
                          child: ElevatedButton.icon(
                            onPressed: _downloadPDF,
                            icon: const Icon(FontAwesomeIcons.download),
                            label: const Text('Descargar CV'),
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
                        const SizedBox(width: 16),
                        AnimatedHoverContainer(
                          child: OutlinedButton.icon(
                            onPressed: () => _openPdfInNewTab(),
                            icon: const Icon(FontAwesomeIcons.externalLinkAlt),
                            label: const Text('Abrir en nueva pestaña'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: theme.primaryColor,
                              side: BorderSide(color: theme.primaryColor),
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
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.blue.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.infoCircle,
                      color: Colors.blue,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Consejo: Para una mejor experiencia de previsualización, usa la aplicación móvil o descarga el PDF.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openPdfInNewTab() async {
    if (_pdfBytes == null) return;

    try {
      if (kIsWeb) {
        await WebPdfUtils.openPdfInNewTab(
          _pdfBytes!,
          '${widget.cvData.name.replaceAll(' ', '_')}_CV.pdf',
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('CV abierto en nueva pestaña'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al abrir: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

// Widget para abrir la pantalla de previsualización
class CVPreviewButton extends StatelessWidget {
  final CVModel cvData;
  final String label;
  final bool isCompact;

  const CVPreviewButton({
    super.key,
    required this.cvData,
    this.label = 'Previsualizar',
    this.isCompact = false,
  });

  void _openPreview(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CVPreviewScreen(cvData: cvData),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isCompact) {
      return AnimatedHoverContainer(
        hoverScale: 1.05,
        child: IconButton.outlined(
          onPressed: () => _openPreview(context),
          icon: const Icon(FontAwesomeIcons.eye),
          tooltip: label,
        ),
      );
    }

    return AnimatedHoverContainer(
      hoverScale: 1.05,
      child: ElevatedButton.icon(
        onPressed: () => _openPreview(context),
        icon: const Icon(FontAwesomeIcons.eye),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.surface,
          foregroundColor: theme.colorScheme.onSurface,
          side: BorderSide(
            color: theme.dividerColor,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
