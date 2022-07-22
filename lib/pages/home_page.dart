import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(child: pw.Text("Hello Fernanda")); // Center
        })); // Page

    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = '${tempDir.path}/PaynmentMarket.pdf';
    final file = File(tempPath);
    var path = await file.writeAsBytes(await pdf.save());

    return path.path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF GENERATORE"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              var path = await generatePdf();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfViewer(
                    path: path,
                  ),
                ),
              );
            },
            child: Container(
              child: Text("Pdf Creator"),
            )),
      ),
    );
  }
}

class PdfViewer extends StatelessWidget {
  const PdfViewer({Key? key, this.path}) : super(key: key);
  final path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
        actions: [
          IconButton(
              onPressed: () {
                // ShareExtend.share(path, 'file');
                Share.shareFiles([path]);
              },
              icon: Icon(Icons.share))
        ],
      ),
      body: Container(
        child: PdfView(path: path),
      ),
    );
  }
}
