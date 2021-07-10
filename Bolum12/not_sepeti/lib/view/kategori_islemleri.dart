import 'package:flutter/material.dart';
import 'package:not_sepeti/models/kategori.dart';
import 'package:not_sepeti/utils/database_helper.dart';

class KategoriIslemleri extends StatefulWidget {
  KategoriIslemleri({Key? key}) : super(key: key);

  @override
  _KategoriIslemleriState createState() => _KategoriIslemleriState();
}

class _KategoriIslemleriState extends State<KategoriIslemleri> {
  List<Kategori>? tumKategoriler;
  DatabaseHelper? databaseHelper;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    if (tumKategoriler == null) {
      tumKategoriler = [];
      _kategoriListesiniDoldur();
    }
    return Scaffold(
      appBar: appBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
            child: Card(
              child: ListTile(
                leading: Icon(Icons.category_outlined),
                title: Text(tumKategoriler![index].kategoriBaslik),
                trailing: IconButton(
                  onPressed: () {
                    _kategoriSil(tumKategoriler![index].kategoriID);
                  },
                  icon: Icon(Icons.delete),
                ),
                onTap: () {
                  kategoriGuncelle(tumKategoriler![index].kategoriID,
                      tumKategoriler![index].kategoriBaslik);
                },
              ),
            ),
          );
        },
        itemCount: tumKategoriler!.length,
      ),
    );
  }

  void _kategoriListesiniDoldur() {
    databaseHelper!.kategoriListesiniGetir().then((value) {
      setState(() {
        tumKategoriler = value;
      });
    });
  }

  AppBar appBar() => AppBar(title: Text("Kategoriler"));

  void _kategoriSil(int id) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Silmek istediğinizden eminmisiniz???"),
            content: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    databaseHelper!.kategoriSil(id).then((value) {
                      setState(() {
                        _kategoriListesiniDoldur();
                      });
                      Navigator.pop(context);
                    });
                  },
                  icon: Icon(Icons.delete),
                  label: Text("Sil"),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.multiple_stop),
                  label: Text("Vazgeç"),
                ),
              ],
            ),
          );
        });
  }

  kategoriGuncelle(int id, String baslik) {
    kategoriGuncelleDialog(context, id, baslik);
  }

  void kategoriGuncelleDialog(BuildContext context, int id, String baslik) {
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
          title: Text("Kategori Güncelle"),
          children: [
            Form(
              key: formKey,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: TextFormField(
                  initialValue: baslik,
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
                          .kategoriGuncelle(
                              Kategori.withID(id, yeniKategoriAdi))
                          .then(
                        (gelenKategoriId) {
                          if (gelenKategoriId > 0) {
                            Navigator.pop(context);
                            setState(() {
                              _kategoriListesiniDoldur();
                            });
                            print("Kayıt güncelleme Başarılı $id");
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.blue,
                              content: Text(
                                  id.toString() + "ID'li güncelleme yapıldı "),
                              duration: const Duration(seconds: 2),
                            ));
                          }
                        },
                      );
                    }
                  },
                  child: Text("Güncelle"),
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
}
