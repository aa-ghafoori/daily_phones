import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewPage extends StatelessWidget {

  const PDFViewPage({required this.pdfData, super.key});
  final Uint8List pdfData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PDF Viewer')),
      body: SfPdfViewer.memory(pdfData),
    );
  }
}
