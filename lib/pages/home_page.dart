import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';

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
    final image1 =
        (await rootBundle.load("assets/punto.png")).buffer.asUint8List();
    final font = await PdfGoogleFonts.nunitoBold();
    final font2 = await PdfGoogleFonts.nunitoLight();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                //DATE "1"

                pw.SizedBox(
                  height: 300.0,
                  child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.SizedBox(
                          width: 200.0,
                          height: 200.0,
                          child: pw.Image(
                            pw.MemoryImage(image),
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            "Comprobante de trasferencia",
                            style: pw.TextStyle(fontSize: 35.0, font: font),
                          ),
                        ),
                        pw.Text(
                          "23 de julio 2022 a 20:24 hs",
                          style: pw.TextStyle(fontSize: 20.0, font: font2),
                        ),
                      ]),
                ),
                pw.Divider(height: 100.0),
                //DATE "2"
                pw.SizedBox(
                  width: 200.0,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("Trasferencia",
                            style: pw.TextStyle(fontSize: 20.0, font: font2)),
                        pw.Text("S 2.000",
                            style: pw.TextStyle(fontSize: 40.0, font: font))
                      ]),
                ),
                pw.Divider(height: 100.0),

                //DATE "3"

                pw.Row(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      //IMAGEN PUNTOS
                      pw.SizedBox(
                        height: 200.0,
                        child: pw.Image(
                          pw.MemoryImage(image1),
                        ),
                      ),
                      //DUEÑO DE LA CUENTA DE MERCADO PAGO
                      pw.SizedBox(
                        height: 250.0,
                        child: pw.Column(
                            mainAxisAlignment:
                                pw.MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              //CUENTA MERCADOPAGO
                              pw.Column(
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("De",
                                        style: pw.TextStyle(
                                            fontSize: 18.0, font: font2)),
                                    pw.Text("Juan Perez Almeida",
                                        style: pw.TextStyle(
                                            fontSize: 25.0, font: font)),
                                    pw.Row(children: [
                                      pw.Text("CVU : ",
                                          style: pw.TextStyle(
                                              fontSize: 18.0, font: font2)),
                                      pw.Text("000048302493249384",
                                          style: pw.TextStyle(
                                              fontSize: 18.0, font: font)),
                                    ]),
                                    pw.Text("Cuenta de Mercado Pago",
                                        style: pw.TextStyle(
                                            fontSize: 18.0, font: font)),
                                  ]),

                              //PAGO A LA OTRA CUENTA
                              pw.Column(
                                  mainAxisAlignment:
                                      pw.MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      pw.CrossAxisAlignment.start,
                                  children: [
                                    pw.Text("Para",
                                        style: pw.TextStyle(
                                            fontSize: 18.0, font: font2)),
                                    pw.Text("Roberto Copa Manuel",
                                        style: pw.TextStyle(
                                            fontSize: 25.0, font: font)),
                                    pw.Row(children: [
                                      pw.Text("CBU : ",
                                          style: pw.TextStyle(
                                              fontSize: 18.0, font: font2)),
                                      pw.Text("246823428374683",
                                          style: pw.TextStyle(
                                              fontSize: 18.0, font: font)),
                                    ]),
                                    pw.Text("Banco Macro",
                                        style: pw.TextStyle(
                                            fontSize: 20.0, font: font)),
                                  ])
                            ]),
                      ),
                    ]),
                //PAGO A LA OTRA CUENTA

                pw.Divider(height: 100.0),
                //DATE "4"
                pw.SizedBox(
                  height: 140.0,
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.SizedBox(
                          height: 60.0,
                          child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("COELSA ID",
                                    style: pw.TextStyle(
                                        fontSize: 15.0, font: font2)),
                                pw.Text("1LREYREUHBUEDGUYGDUE742386843286748",
                                    style: pw.TextStyle(
                                        fontSize: 15.0, font: font)),
                              ]),
                        ),
                        pw.SizedBox(
                          height: 60.0,
                          child: pw.Column(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text("Código de transferencia",
                                    style: pw.TextStyle(
                                        fontSize: 15.0, font: font2)),
                                pw.Text("24352653625365532",
                                    style: pw.TextStyle(
                                        fontSize: 15.0, font: font)),
                              ]),
                        )
                      ]),
                ),
              ]);
          // Center
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
        title: const Text('DANGER FLOW'),
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
