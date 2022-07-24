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
    final image1 =
        (await rootBundle.load("assets/punto.png")).buffer.asUint8List();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a3,
        build: (pw.Context context) {
          return pw.Align(
            alignment: pw.Alignment.topLeft,
            child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  //DATE "1"
                  pw.Container(
                    width: 400.0,
                    height: 400.0,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(
                            width: 300.0,
                            height: 300.0,
                            child: pw.Image(
                              pw.MemoryImage(image),
                            ),
                          ),
                          pw.Text(
                            "Comprobante de trasferencia",
                            style: pw.TextStyle(fontSize: 25.0),
                          ),
                          pw.Text(
                            "23 de julio 2022 a 20:24 hs",
                            style: pw.TextStyle(fontSize: 15.0),
                          ),
                        ]),
                  ),
                  pw.Divider(height: 100.0),
                  //DATE "2"
                  pw.SizedBox(
                    width: 400.0,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text("Trasferencia"),
                          pw.Text("2000", style: pw.TextStyle(fontSize: 30.0))
                        ]),
                  ),
                  pw.Divider(height: 100.0),

                  //DATE "3"

                  pw.Row(children: [
                    //IMAGEN PUNTOS
                    pw.SizedBox(
                      width: 100.0,
                      height: 300.0,
                      child: pw.Image(
                        pw.MemoryImage(image1),
                      ),
                    ),
                    //DUEÑO DE LA CUENTA DE MERCADO PAGO
                    pw.Column(children: [
                      pw.Text("De"),
                      pw.Text("Juan Perez Almeida"),
                      pw.Row(children: [
                        pw.Text("CVU:"),
                        pw.Text("0000483024932493849239429384028394394239480"),
                      ]),
                      pw.Text("Cuenta de Mercado Pago"),
                    ]),

                    //PAGO A LA OTRA CUENTA
                    pw.Column(children: [
                      pw.Text("Para"),
                      pw.Text("Roberto Copa Manuel"),
                      pw.Row(children: [
                        pw.Text("CUIT/CUIL"),
                        pw.Text("20-32485893-5"),
                      ]),
                      pw.Text("Caja de ahorro"),
                    ])
                  ]),
                  pw.Divider(height: 100.0),
                  //DATE "4"
                  pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text("COELSA ID"),
                        pw.Text("1LREYREUHBUEDGUYGDUE742386843286748"),
                      ]),
                  pw.Column(children: [
                    pw.Text("Código de trasferencia"),
                    pw.Text("24352653625365532"),
                  ])
                ]),
          ); // Center
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
        title: const Text('PDF FLUTTER'),
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
