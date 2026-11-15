import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_ls/l10n/app_localizations.dart';
import 'package:portfolio_ls/utils/harvard_cv_service.dart';
import 'package:portfolio_ls/utils/animations.dart';

class CVDownloadButton extends StatefulWidget {
  final String? label;
  final bool showIcon;
  final bool isCompact;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CVDownloadButton({
    super.key,
    this.label,
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

    final l10n = AppLocalizations.of(context)!;
    setState(() => _isLoading = true);
    try {
      await HarvardCVService.downloadCV();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.cvDownloadSuccess),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.cvDownloadError),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
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
    final l10n = AppLocalizations.of(context)!;
    final label = widget.label ?? l10n.cvDownloadLabel;

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
              : const Icon(
                  FontAwesomeIcons.download,
                  size: 20,
                ),
          style: IconButton.styleFrom(
            backgroundColor: widget.backgroundColor ?? theme.primaryColor,
            foregroundColor: widget.foregroundColor ?? Colors.white,
            padding: const EdgeInsets.all(12),
          ),
          tooltip: label,
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
          _isLoading ? l10n.cvDownloading : label,
          style: const TextStyle(
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

/// Widget para botón flotante de CV
class FloatingCVButton extends StatelessWidget {
  const FloatingCVButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedFadeSlide(
      delay: const Duration(milliseconds: 800),
      child: HoverCard(
        padding: const EdgeInsets.all(16),
        backgroundColor: Theme.of(context).primaryColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              FontAwesomeIcons.fileText,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.cvFloatingTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.cvFloatingSubtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            CVDownloadButton(
              label: l10n.cvFloatingDownload,
              isCompact: true,
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF1565C0),
              showIcon: true,
            ),
          ],
        ),
      ),
    );
  }
}
