import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/utils/cv_service.dart';
import 'package:portfolio_ls/utils/animations.dart';

class CVDownloadButton extends StatefulWidget {
  final String label;
  final bool showIcon;
  final bool isCompact;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CVDownloadButton({
    super.key,
    this.label = 'Descargar CV',
    this.showIcon = true,
    this.isCompact = false,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  State<CVDownloadButton> createState() => _CVDownloadButtonState();
}

class _CVDownloadButtonState extends State<CVDownloadButton> {
  bool _isLoading = false;

  Future<void> _downloadCV() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);
    try {
      await CVService.downloadCV();
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
          const SnackBar(
            content: Text('Error al descargar el CV'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (widget.isCompact) {
      return AnimatedHoverContainer(
        hoverScale: 1.05,
        child: IconButton.filled(
          onPressed: _isLoading ? null : _downloadCV,
          icon: _isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      widget.foregroundColor ?? Colors.white,
                    ),
                  ),
                )
              : Icon(
                  FontAwesomeIcons.download,
                  size: 20,
                ),
          style: IconButton.styleFrom(
            backgroundColor: widget.backgroundColor ?? theme.primaryColor,
            foregroundColor: widget.foregroundColor ?? Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          tooltip: widget.label,
        ),
      );
    }

    return AnimatedHoverContainer(
      hoverScale: 1.05,
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _downloadCV,
        icon: _isLoading
            ? SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    widget.foregroundColor ?? Colors.white,
                  ),
                ),
              )
            : widget.showIcon
                ? const Icon(FontAwesomeIcons.download)
                : const SizedBox.shrink(),
        label: Text(
          _isLoading ? 'Descargando...' : widget.label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.backgroundColor ?? theme.primaryColor,
          foregroundColor: widget.foregroundColor ?? Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
      ),
    );
  }
}

// Widget para botón flotante de CV
class FloatingCVButton extends StatelessWidget {
  const FloatingCVButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedFadeSlide(
      delay: const Duration(milliseconds: 800),
      child: HoverCard(
        padding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              FontAwesomeIcons.fileText,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Mi Curriculum',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Descarga mi CV completo',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            const CVDownloadButton(
              label: 'Descargar',
              isCompact: true,
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF1565C0),
              showIcon: true,
            ),
          ],
        ),
      ),
    );
  }
}
