import 'package:flutter/material.dart';
import 'package:storage_dersleri/models/ogrenci.dart';

class SqllifeIslemleri extends StatefulWidget {
  SqllifeIslemleri({Key? key}) : super(key: key);

  @override
  _SqllifeIslemleriState createState() => _SqllifeIslemleriState();
}

class _SqllifeIslemleriState extends State<SqllifeIslemleri> {
  @override
  Widget build(BuildContext context) {
    Ogrenci emre = Ogrenci.withId(1, "emre", 1);

    Map<String, dynamic> yeniMap = emre.toMap(); // nesneyi mape dönüştürmek
    Ogrenci.fromMap(yeniMap); // mapi nesneye dönüştürmek
    print(yeniMap.toString());
    print(emre);

    return Scaffold(
      body: Center(),
    );
  }
}
