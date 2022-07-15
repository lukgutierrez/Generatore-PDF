import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
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
            child: pw.Text("Hello Rocio Copa"),
          ); // Center
        }));
    // final file = File("example.pdf");
    // file.writeAsBytesSync(await pdf.save()); // Page
  }

  @override
  Widget build(BuildContext context) {
    pdfCreation();
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF GENERATORE"),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {},
            child: Container(
              child: Text("Pdf Creator"),
            )),
      ),
    );
  }
}
