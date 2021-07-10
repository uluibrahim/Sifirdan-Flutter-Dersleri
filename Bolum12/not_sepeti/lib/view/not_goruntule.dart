import 'package:flutter/material.dart';
import 'package:not_sepeti/models/notlar.dart';
import 'package:not_sepeti/utils/database_helper.dart';

import 'not_detay.dart';

class NotGoruntule extends StatefulWidget {
  @override
  _NotGoruntuleState createState() => _NotGoruntuleState();
}

class _NotGoruntuleState extends State<NotGoruntule> {
  List<Not>? tumNotlar;

  DatabaseHelper? databaseHelper;

  @override
  void initState() {
    super.initState();
    tumNotlar = [];
    databaseHelper = DatabaseHelper();
    databaseHelper!.notListesiniGetir().then((value) {
      setState(() {
        tumNotlar = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return futureBuilder();
  }

  FutureBuilder<List<Not>> futureBuilder() {
    return FutureBuilder(
      future: databaseHelper!.notListesiniGetir(),
      builder: (context, AsyncSnapshot<List<Not>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          tumNotlar = snapshot.data;
          return ListView.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExpansionTile(
                  leading: _iconAta(tumNotlar![index].notOncelik),
                  title: Text(tumNotlar![index].notBaslik.toString()),
                  children: [
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Kategori"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(tumNotlar![index]
                                    .kategoriBaslik
                                    .toString()),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text("Oluşturulma Tarihi"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  databaseHelper!.dateFormat(
                                    DateTime.parse(
                                      tumNotlar![index].notTarih.toString(),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("İçerik:\n" +
                                tumNotlar![index].notIcerik.toString()),
                          ),
                          ButtonBar(
                            children: [
                              TextButton(
                                onPressed: () =>
                                    _notSil(tumNotlar![index].notID),
                                child: Text(
                                  "Sil",
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  _notDetaySayfasi(context, tumNotlar![index]);
                                },
                                child: Text(
                                  "Güncelle",
                                  style: TextStyle(color: Colors.indigo),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: tumNotlar!.length,
          );
        } else {
          return Center(
            child: Text("Yükleniyor..."),
          );
        }
      },
    );
  }

  _iconAta(oncelik) {
    switch (oncelik) {
      case 0:
        return CircleAvatar(
            child: Text("Yüksek"), radius: 30, backgroundColor: Colors.red);

      case 1:
        return CircleAvatar(
            child: Text("Orta"), radius: 30, backgroundColor: Colors.orange);

      case 2:
        return CircleAvatar(
            child: Text("Düşük"), radius: 30, backgroundColor: Colors.green);

      default:
    }
  }

  _notSil(int? notID) {
    databaseHelper!.notSil(notID!).then((value) {
      listeDoldur();
    });
  }

  void listeDoldur() {
    databaseHelper!.notListesiniGetir().then((value) {
      setState(() {
        tumNotlar = value;
      });
    });
  }

  void _notDetaySayfasi(BuildContext context, Not not) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotDetay(
          baslik: "Notu düzenle",
          duzenlenecekNot: not,
        ),
      ),
    );
  }
}
