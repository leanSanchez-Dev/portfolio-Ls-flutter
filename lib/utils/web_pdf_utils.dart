import 'package:flutter/foundation.dart';
import 'dart:typed_data';

// Solo importar dart:html en web
import 'dart:html' as html;

/// Utilidades específicas para el manejo de PDFs en Flutter Web
class WebPdfUtils {
  /// Abre un PDF en una nueva pestaña del navegador
  static Future<void> openPdfInNewTab(
      Uint8List pdfBytes, String filename) async {
    if (!kIsWeb) {
      throw UnsupportedError(
          'Esta función solo está disponible en Flutter Web');
    }

    try {
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Abrir en nueva pestaña
      html.window.open(url, '_blank');

      // Limpiar la URL del blob después de un tiempo
      Future.delayed(const Duration(seconds: 1), () {
        html.Url.revokeObjectUrl(url);
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error al abrir PDF en nueva pestaña: $e');
      }
      rethrow;
    }
  }

  /// Descargar PDF directamente en el navegador
  static Future<void> downloadPdfInBrowser(
      Uint8List pdfBytes, String filename) async {
    if (!kIsWeb) {
      throw UnsupportedError(
          'Esta función solo está disponible en Flutter Web');
    }

    try {
      final blob = html.Blob([pdfBytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);

      // Crear enlace de descarga
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = filename;

      html.document.body?.children.add(anchor);
      anchor.click();
      html.document.body?.children.remove(anchor);

      // Limpiar la URL del blob
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      if (kDebugMode) {
        print('Error al descargar PDF: $e');
      }
      rethrow;
    }
  }

  /// Verificar si PdfPreview es compatible en el entorno actual
  static bool get isPdfPreviewSupported {
    if (!kIsWeb) {
      return true; // En móvil/desktop siempre funciona
    }

    // En web, PdfPreview tiene problemas en modo release
    return kDebugMode;
  }
}
