import 'package:flutter/material.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/utils/database_helper.dart';

import 'package:not_sepeti/view/not_detay.dart';

import 'kategori_islemleri.dart';
import 'not_goruntule.dart';

class NotListesi extends StatelessWidget {
  DatabaseHelper? databaseHelper = DatabaseHelper();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: fabButtons(context),
      body: NotGoruntule(),
    );
  }

  Column fabButtons(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          heroTag: "kategoriEkle",
          backgroundColor: Colors.orange,
          onPressed: () {
            kategoriEkleDialog(context);
          },
          child: Icon(Icons.add_circle),
          mini: true,
          tooltip: "Kategori Ekle",
        ),
        SizedBox(height: 7),
        FloatingActionButton(
          heroTag: "notDetay",
          onPressed: () {
            _notDetaySayfasi(context);
          },
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  void kategoriEkleDialog(BuildContext context) {
    String? yeniKategoriAdi;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          titleTextStyle: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
          ),
          titlePadding: EdgeInsets.all(4),
          title: Text("Kategori Ekle"),
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Kategori adı giriniz",
                    contentPadding: EdgeInsets.all(20),
                    border: OutlineInputBorder(),
                  ),
                  validator: (girilenKategoriAdi) {
                    if (girilenKategoriAdi!.length < 2) {
                      return "Kategori adı en az 2 karakter olmalıdır.";
                    }
                  },
                  onSaved: (value) {
                    yeniKategoriAdi = value!;
                  },
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      databaseHelper!
                          .kategoriEkle(Kategori(yeniKategoriAdi))
                          .then(
                        (gelenKategoriId) {
                          if (gelenKategoriId > 0) {
                            Navigator.pop(context);
                            print("Kayıt ekleme Başarılı $gelenKategoriId");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text(gelenKategoriId.toString() +
                                  "ID'li kayıt oluşturuldu\n"),
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        },
                      );
                    }
                  },
                  child: Text("Ekle"),
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Kapat"),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text("Not Sepeti"),
      actions: [
        PopupMenuButton(itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: ListTile(
                leading: Icon(Icons.category),
                title: Text("Kategoriler"),
                onTap: () {
                  Navigator.pop(context);

                  _kategoriIslemleri(context);
                },
              ),
            ),
          ];
        })
      ],
    );
  }

  void _notDetaySayfasi(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotDetay(),
      ),
    );
  }

  void _kategoriIslemleri(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => KategoriIslemleri()));
  }
}
