// Esto va en main.dart
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void createPdf() async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Text('Hi linux torvals car , phone , keyword'),
        ),
      ),
    );

    String? path = await getPath();
    if (path != null) {
      final file = File('$path/example.pdf');
      await file.writeAsBytes(await pdf.save());
    } else {
      print('Ruta no disponible');
    }
  }

  Future<String?> getPath() async {
    Directory? appDocDir = await getApplicationSupportDirectory();
    String appDocPath = appDocDir.path;
    return appDocPath;
    // return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("THIS PROBLEM"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  createPdf();
                },
                child: Container(
                  child: Text("hello"),
                ))
          ],
        ),
      ),
    );
  }
}
