import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  final String name;

  const HomePage(this.name);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _name = TextEditingController(text: "");

  generatePdf() async {
    final pdf = pw.Document();
    final image =
        (await rootBundle.load("assets/mercadopago.png")).buffer.asUint8List();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(children: [
          
            pw.SizedBox(
              width: 100.0,
              height: 100.0,
              child: pw.Image(
                pw.MemoryImage(image),
              ),
            ),
            pw.Text(
              "Comprobante de trasferencia",
              style: pw.TextStyle(fontSize: 16.0),
            )
          ]); // Center
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
      body: Column(
        children: [
          TextField(
            controller: _name,
          ),
          Center(
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
        ],
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
