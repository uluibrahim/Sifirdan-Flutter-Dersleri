import 'package:flutter/material.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/models/notlar.dart';
import 'package:not_sepeti/utils/database_helper.dart';
import 'package:not_sepeti/view/not_goruntule.dart';

class NotDetay extends StatefulWidget {
  String? baslik;
  Not? duzenlenecekNot;
  NotDetay({this.baslik, this.duzenlenecekNot});
  @override
  _NotDetayState createState() => _NotDetayState();
}

class _NotDetayState extends State<NotDetay> {
  List<Kategori>? tumKategoriler;
  List<String> oncelikListesi = ["Yüksek", "Orta", "Düşük"];
  DatabaseHelper? databaseHeper;
  var kategoriID;
  String? notBaslik;
  String? notIcerik;

  var oncelik;
  var formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    oncelik = widget.duzenlenecekNot != null
        ? widget.duzenlenecekNot!.notOncelik
        : oncelik;
    kategoriID =
        widget.duzenlenecekNot != null ? widget.duzenlenecekNot!.kategoriID : 1;
    databaseHeper = DatabaseHelper();
    tumKategoriler = [];
    databaseHeper!.kategoriTablosunuGetir().then((kategoriIcerenMapListesi) {
      for (Map<String, dynamic> okunanMap in kategoriIcerenMapListesi) {
        tumKategoriler!.add(Kategori.fromMap(okunanMap));
      }
      setState(() {
        kategoriItems();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Not ekleme ekranı"),
      ),
      body: tumKategoriler!.length == 0
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: formKey,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Kategori seçiniz: ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text("Seciniz"),
                            items: kategoriItems(),
                            onChanged: (secilenKategori) {
                              setState(() {
                                kategoriID = secilenKategori;
                              });
                            },
                            value: kategoriID,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: notBaslikFormu(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: notIcerigiFormu(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Öncelik seçiniz: ",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all()),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            hint: Text("Seciniz"),
                            items: oncelikItems(),
                            onChanged: (secilenOncelik) {
                              setState(() {
                                oncelik = secilenOncelik;
                              });
                            },
                            value: oncelik,
                          ),
                        ),
                      ),
                    ],
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            if (widget.duzenlenecekNot == null) {
                              databaseHeper!
                                  .notEkle(Not(kategoriID, notBaslik, notIcerik,
                                      oncelik))
                                  .then((value) {
                                if (value != 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Not eklendi"),
                                        duration: Duration(seconds: 2)),
                                  );
                                  Navigator.pop(context);
                                }
                              });
                            } else {
                              databaseHeper!
                                  .notGuncelle(Not.withID(
                                      widget.duzenlenecekNot!.notID,
                                      kategoriID,
                                      notBaslik,
                                      notIcerik,
                                      oncelik))
                                  .then((value) {
                                if (value != 0) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Not güncellendi"),
                                        duration: Duration(seconds: 2)),
                                  );
                                  Navigator.pop(context);
                                }
                              });
                            }
                          }
                        },
                        child: Text(
                          "Kaydet",
                          style: TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                      ),
                      notEklemektenVazgec(context),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  TextFormField notIcerigiFormu() {
    return TextFormField(
      initialValue: widget.duzenlenecekNot != null
          ? widget.duzenlenecekNot!.notIcerik
          : "",
      maxLines: 3,
      autofocus: false,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Not içeriği giriniz",
      ),
      onSaved: (gelenIcerik) {
        notIcerik = gelenIcerik;
      },
    );
  }

  TextFormField notBaslikFormu() {
    return TextFormField(
      initialValue: widget.duzenlenecekNot != null
          ? widget.duzenlenecekNot!.notBaslik.toString()
          : "",
      decoration: InputDecoration(
        errorBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        border: OutlineInputBorder(),
        labelText: "Not başlığı giriniz",
      ),
      validator: (value) {
        if (value!.length < 3) {
          return "Boş geçilemez";
        }
      },
      onSaved: (gelenBaslik) {
        notBaslik = gelenBaslik;
      },
    );
  }

  ElevatedButton notEklemektenVazgec(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        "Vazgeç",
        style: TextStyle(fontSize: 18),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.red,
      ),
    );
  }

  List<DropdownMenuItem<int>> kategoriItems() {
    return tumKategoriler!
        .map(
          (gelenKategori) => DropdownMenuItem<int>(
            child: Text(gelenKategori.kategoriBaslik),
            value: gelenKategori.kategoriID,
          ),
        )
        .toList();
  }

  oncelikItems() {
    return oncelikListesi
        .map(
          (e) => DropdownMenuItem(
            child: Text(e.toString()),
            value: oncelikListesi.indexOf(e),
          ),
        )
        .toList();
  }
}
