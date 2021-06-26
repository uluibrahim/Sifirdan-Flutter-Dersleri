import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ListViewKullanimi extends StatelessWidget {
  List<Ogrenci> tumOgrenciler = List.generate(500,
      (index) => Ogrenci(index + 1, "Ad ${index + 1}", "Soyad ${index + 1}"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Listview kullanımı")),
      body: Container(
        child: buildListViewSeparated(),
      ),
    );
  }

  ListView buildListViewSeparated() {
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        var ogrenci = tumOgrenciler[index];
        return Card(
          color: Colors.cyan[((index + 1) % 10 * 100)],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: ListTile(
            onTap: () {
              print("List tile tıklanıldı $index");
              EasyLoading.showToast(
                "Toast",
                duration: Duration(seconds: 3),
                toastPosition: EasyLoadingToastPosition.center,
                maskType: EasyLoadingMaskType.custom, // arka plan ayarı
                dismissOnTap:
                    true, // farklı yere tıklandığında kapatılmasını sağlar
              );
            },
            onLongPress: () {
              _alertDialogIslemleri(context, tumOgrenciler[index]);
            },
            title: Text(ogrenci.isim),
            subtitle: Text(ogrenci.soyad),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade400,
              child: Text(
                ogrenci.ogrId.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
      itemCount: tumOgrenciler.length,
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.red,
          endIndent: 60,
          indent: 60,
          thickness: 2,
        );
      },
    );
  }

  void _alertDialogIslemleri(BuildContext context, Ogrenci ogrenci) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${ogrenci}"),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text("data\n" * 100),
                ],
              ),
            ),
            actions: [
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed: () {}, child: Text("Tamam")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Kapat")),
                ],
              ),
            ],
          );
        });
  }

  ListView buildListViewBuilder() {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        var ogrenci = tumOgrenciler[index];
        return Card(
          color: Colors.cyan[((index + 1) % 10 * 100)],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          child: ListTile(
            onTap: () => print("List tile tıklanıldı $index"),
            title: Text(ogrenci.isim),
            subtitle: Text(ogrenci.soyad),
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey.shade400,
              child: Text(
                ogrenci.ogrId.toString(),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      },
      itemCount: tumOgrenciler.length,
    );
  }

  ListView buildListView() {
    return ListView(
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
    );
  }
}

class Ogrenci {
  final int ogrId;
  final String isim;
  final String soyad;

  Ogrenci(this.ogrId, this.isim, this.soyad);

  @override
  String toString() {
    // TODO: implement toString
    return 'Ad: $isim Soyad: $soyad ID: $ogrId';
  }
}
