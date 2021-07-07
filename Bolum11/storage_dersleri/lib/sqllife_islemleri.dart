import 'package:flutter/material.dart';
import 'package:storage_dersleri/models/ogrenci.dart';
import 'package:storage_dersleri/utils/database_helper.dart';

class SqllifeIslemleri extends StatefulWidget {
  SqllifeIslemleri({Key? key}) : super(key: key);

  @override
  _SqllifeIslemleriState createState() => _SqllifeIslemleriState();
}

class _SqllifeIslemleriState extends State<SqllifeIslemleri> {
  DatabaseHelper? _databaseHelper;
  List<Ogrenci>? tumOgrencilerListesi;

  var formKey = GlobalKey<FormState>();

  bool aktifMi = false;

  @override
  void initState() {
    // uygulama ilk açıldığında veri tabınından veriler bir kereliğine alınır ve listeye aktarılır.
    // uygulama boyunca liste ile çalışılır
    super.initState();

    tumOgrencilerListesi = [];
    _databaseHelper = DatabaseHelper();
    _databaseHelper!.tumOgrenciler().then((tumOgrencileriTutanMapListesi) {
      for (Map<String, dynamic> okunanOgrenciMap
          in tumOgrencileriTutanMapListesi) {
        tumOgrencilerListesi!.add(Ogrenci.fromMap(okunanOgrenciMap));
      }
      print("DB den gelen ogrenci sayısı " +
          tumOgrencilerListesi!.length.toString());
    }).catchError((error) {
      print("HATA: " + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: isimFormField(),
                ),
                switchButton(context),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    kaydetButton(),
                    guncelleButton(),
                    tumunuSil(),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Card(
                        color: tumOgrencilerListesi![index].aktif == 1
                            ? Colors.green.shade300
                            : Colors.red.shade300,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(
                                tumOgrencilerListesi![index].id.toString()),
                          ),
                          title: Text(tumOgrencilerListesi![index].isim),
                          subtitle: Text(tumOgrencilerListesi![index].aktif == 1
                              ? "Aktif"
                              : "Pasif"),
                        ),
                      );
                    },
                    itemCount: tumOgrencilerListesi!.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton tumunuSil() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Tüm Tabloyu Sil"),
      style: ElevatedButton.styleFrom(primary: Colors.red),
    );
  }

  ElevatedButton guncelleButton() {
    return ElevatedButton(
      onPressed: () {},
      child: Text("Güncelle"),
      style: ElevatedButton.styleFrom(primary: Colors.orange),
    );
  }

  ElevatedButton kaydetButton() {
    return ElevatedButton(
      child: Text("Kaydet"),
      style: ElevatedButton.styleFrom(primary: Colors.green),
      onPressed: () {},
    );
  }

  Container switchButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.5,
      child: SwitchListTile(
        value: aktifMi,
        onChanged: (value) {
          setState(() {
            aktifMi = value;
          });
        },
        title: Text("Aktif mi?"),
      ),
    );
  }

  TextFormField isimFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
