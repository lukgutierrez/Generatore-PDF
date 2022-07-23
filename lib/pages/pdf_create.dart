import 'package:flutter/material.dart';
import 'package:generatore_pdf/pages/home_page.dart';

class PdfCreate extends StatefulWidget {
  PdfCreate({Key? key}) : super(key: key);

  @override
  State<PdfCreate> createState() => _PdfCreateState();
}

class _PdfCreateState extends State<PdfCreate> {
  TextEditingController _name = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _name,
              ),
              ElevatedButton(
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(_name.text),
                      ),
                    );
                  },
                  child: Container(
                    child: Text("helllos"),
                  ))
            ],
          ),
        ));
  }
}
