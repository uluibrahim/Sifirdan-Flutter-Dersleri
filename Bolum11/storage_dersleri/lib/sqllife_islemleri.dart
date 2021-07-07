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

  var _formKey = GlobalKey<FormState>();

  bool aktifMi = false;

  var _textController = TextEditingController();
  int? tiklanilanElemaninIndexi;

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
            key: _formKey,
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
                          trailing: iconDelete(index),
                          onTap: () {
                            setState(() {
                              _textController.text =
                                  tumOgrencilerListesi![index].isim;
                              aktifMi = tumOgrencilerListesi![index].aktif == 1
                                  ? true
                                  : false;
                              tiklanilanElemaninIndexi = index;
                            });
                          },
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

  IconButton iconDelete(int index) {
    return IconButton(
      onPressed: () {
        _ogrenciSil(tumOgrencilerListesi![index].id, index);
      },
      icon: Icon(
        Icons.delete,
        size: 30,
        color: Colors.white,
      ),
    );
  }

  ElevatedButton tumunuSil() {
    return ElevatedButton(
      onPressed: () {
        _tumTabloyuTemizle();
      },
      child: Text("Tüm Tabloyu Sil"),
      style: ElevatedButton.styleFrom(primary: Colors.red),
    );
  }

  ElevatedButton guncelleButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _ogrenciGuncelle(
            Ogrenci.withId(
              tumOgrencilerListesi![tiklanilanElemaninIndexi!].id,
              _textController.text,
              aktifMi == true ? 1 : 0,
            ),
          );
        }
      },
      child: Text("Güncelle"),
      style: ElevatedButton.styleFrom(primary: Colors.orange),
    );
  }

  ElevatedButton kaydetButton() {
    return ElevatedButton(
      child: Text("Kaydet"),
      style: ElevatedButton.styleFrom(primary: Colors.green),
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _ogrenciEkle(Ogrenci(_textController.text, aktifMi == true ? 1 : 0));
        }
      },
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
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      controller: _textController,
      validator: (value) {
        if (value!.length < 3) {
          return "İsim 3 karakterden kısa olamaz";
        } else
          return null;
      },
    );
  }

  Future<void> _ogrenciEkle(Ogrenci ogrenci) async {
    var yeniEklenenElemanID = await _databaseHelper!.ogrenciEkle(ogrenci);
    ogrenci.id = yeniEklenenElemanID;
    // listeyi güncel tutup eklenne elemanı hızşı bir şekilde eklemek
    if (yeniEklenenElemanID > 0) {
      setState(() {
        tumOgrencilerListesi!.insert(0, ogrenci);
      });
    }
  }

  void _tumTabloyuTemizle() async {
    int silinenElemanSayisi = await _databaseHelper!.tumOgrenciTablosunuSil();
    if (silinenElemanSayisi > 0) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        content: Text(silinenElemanSayisi.toString() + 'kayıt silindi\n\n'),
        duration: const Duration(seconds: 2),
      ));
      setState(() {
        tumOgrencilerListesi!.clear();
      });
    }
  }

  Future<void> _ogrenciSil(int id, int index) async {
    int silinenId = await _databaseHelper!.ogrenciSil(id);
    if (silinenId == 1) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        content: Text(tumOgrencilerListesi![index].id.toString() +
            "  ID'li eleman Silindi\n\n"),
        duration: const Duration(seconds: 2),
      ));
      setState(() {
        tumOgrencilerListesi!.removeAt(index);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
        content: Text("Silme İşlemi Başarısız"),
        duration: const Duration(seconds: 2),
      ));
    }
  }

  void _ogrenciGuncelle(Ogrenci ogrenci) async {
    int guncellenenElemanSayisi =
        await _databaseHelper!.ogrenciGuncelle(ogrenci);
    if (guncellenenElemanSayisi == 1) {
      setState(() {
        tumOgrencilerListesi![tiklanilanElemaninIndexi!] = ogrenci;
      });
    }
  }
}
