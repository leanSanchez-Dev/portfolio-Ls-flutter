import 'dart:js_interop';

import 'package:flutter/foundation.dart';
import 'package:web/web.dart' as web;

/// Utilidades específicas para el manejo de PDFs en Flutter Web.
///
/// Implementada sobre `package:web` + `dart:js_interop`. `dart:html` está
/// deprecado y no compila con Wasm; el contrato público es idéntico al de la
/// versión anterior y al del stub de VM.
class WebPdfUtils {
  /// Crea un blob de PDF y devuelve su object URL.
  static String _createPdfObjectUrl(Uint8List pdfBytes) {
    final blob = web.Blob(
      <JSUint8Array>[pdfBytes.toJS].toJS,
      web.BlobPropertyBag(type: 'application/pdf'),
    );
    return web.URL.createObjectURL(blob);
  }

  /// Abre un PDF en una nueva pestaña del navegador
  static Future<void> openPdfInNewTab(
      Uint8List pdfBytes, String filename) async {
    if (!kIsWeb) {
      throw UnsupportedError(
          'Esta función solo está disponible en Flutter Web');
    }

    try {
      final url = _createPdfObjectUrl(pdfBytes);

      // Abrir en nueva pestaña
      web.window.open(url, '_blank');

      // Limpiar la URL del blob después de un tiempo
      Future.delayed(const Duration(seconds: 1), () {
        web.URL.revokeObjectURL(url);
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
      final url = _createPdfObjectUrl(pdfBytes);

      // Crear enlace de descarga
      final anchor = web.HTMLAnchorElement()
        ..href = url
        ..download = filename;
      anchor.style.display = 'none';

      web.document.body?.appendChild(anchor);
      anchor.click();
      anchor.remove();

      // Limpiar la URL del blob
      web.URL.revokeObjectURL(url);
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

    // Ahora habilitamos PdfPreview en web para mejorar la experiencia del usuario
    return true;
  }
}
