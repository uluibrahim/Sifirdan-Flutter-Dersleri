import 'package:flutter/material.dart';

class ListViewKullanimi extends StatelessWidget {
  List<Ogrenci> tumOgrenciler = List.generate(500,
      (index) => Ogrenci(index + 1, "Ad ${index + 1}", "Soyad ${index + 1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listview kullanımı")),
      body: Container(
        child: ListView(
          children: tumOgrenciler
              .map(
                (Ogrenci e) => Card(
                  color: Colors.cyan.shade200,
                  child: ListTile(
                    title: Text(e.isim),
                    subtitle: Text(e.soyad),
                    leading: CircleAvatar(
                      backgroundColor: Colors.blueGrey.shade400,
                      child: Text(
                        e.ogrId.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

class Ogrenci {
  final int ogrId;
  final String isim;
  final String soyad;

  Ogrenci(this.ogrId, this.isim, this.soyad);
}
