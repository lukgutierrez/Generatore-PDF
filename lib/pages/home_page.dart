import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  pdfCreation() async {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello Lenke"),
          ); // Center
        }));
    Directory output = await getApplicationDocumentsDirectory();
    final file = File("${output.path}/ejemplo1.pdf");
    file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF GENERATORE"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              pdfCreation();
            },
            child: Container(
              child: Text("Pdf Creator"),
            )),
      ),
    );
  }
}
