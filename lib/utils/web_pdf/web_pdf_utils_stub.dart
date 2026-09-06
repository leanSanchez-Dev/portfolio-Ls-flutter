import 'dart:typed_data';

/// Variante sin DOM de [WebPdfUtils] (VM de Dart: `flutter test`, móvil).
///
/// Reproduce el contrato público de la implementación web. El comportamiento
/// coincide con el que ya tenía la versión original fuera de web: las
/// operaciones de blob/descarga lanzan [UnsupportedError].
class WebPdfUtils {
  static Future<void> openPdfInNewTab(
      Uint8List pdfBytes, String filename) async {
    throw UnsupportedError('Esta función solo está disponible en Flutter Web');
  }

  static Future<void> downloadPdfInBrowser(
      Uint8List pdfBytes, String filename) async {
    throw UnsupportedError('Esta función solo está disponible en Flutter Web');
  }

  static bool get isPdfPreviewSupported => true;
}
