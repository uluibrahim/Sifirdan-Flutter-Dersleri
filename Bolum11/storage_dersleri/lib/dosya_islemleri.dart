import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DosyaIslemleri extends StatefulWidget {
  DosyaIslemleri({Key? key}) : super(key: key);

  @override
  _DosyaIslemleriState createState() => _DosyaIslemleriState();
}

class _DosyaIslemleriState extends State<DosyaIslemleri> {
  var controllerText = TextEditingController();

  // dosya path i elde etmek

  Future<String> get getKlasorYolu async {
    Directory klasor = await getApplicationDocumentsDirectory();
    debugPrint("dosya yolu" + klasor.path);
    return klasor.path;
  }

  Future<File> get dosyaOlustur async {
    var olusturulanDosyaninKlasorYolu = await getKlasorYolu;
    return File(olusturulanDosyaninKlasorYolu + "/myDosya.txt");
  }

  Future<String> get dosyadanOku async {
    try {
      var myDosya = await dosyaOlustur;
      String dosyaIcerigi = await myDosya.readAsString();
      return dosyaIcerigi;
    } catch (e) {
      return "Hata Çıktı $e";
    }
  }

  Future<File> dosyayaYaz(String yazilacakDeger) async {
    var myDosya = await dosyaOlustur;
    return myDosya.writeAsString(yazilacakDeger);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dosya İşlemleri")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: textField(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: buttonRow(),
            )
          ],
        ),
      ),
    );
  }

  TextField textField() {
    return TextField(
      //maxLines: 3,
      controller: controllerText,
      decoration: InputDecoration(
        hintText: "Dosyaya kaydedilecek",
        border: OutlineInputBorder(),
      ),
    );
  }

  Row buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        OutlinedButton(
          onPressed: _dosyaYaz,
          child: Text("Dosyaya yaz"),
          style: OutlinedButton.styleFrom(shadowColor: Colors.indigo),
        ),
        OutlinedButton(
          onPressed: _dosyaOku,
          child: Text("Dosyadan oku"),
          style: OutlinedButton.styleFrom(shadowColor: Colors.indigo),
        ),
      ],
    );
  }

  void _dosyaYaz() {
    dosyayaYaz(controllerText.text.toString());
  }

  void _dosyaOku() async {
    debugPrint(await dosyadanOku);
  }
}
