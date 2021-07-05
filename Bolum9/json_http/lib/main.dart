import 'package:flutter/material.dart';
import 'local_json_kullanimi.dart';

void main() => runApp(MyApp());

class Ogrenci {
  int id;
  String isim;
  Ogrenci(this.id, this.isim);

  @override
  String toString() {
    return "ID: $id   isim: $isim";
  }

  factory Ogrenci.mapiNesneyeDonustur(Map<String, dynamic> gelenMap) {
    return Ogrenci(gelenMap["id"], gelenMap["isim"]);
  }
  Ogrenci.fromMap(Map<String, dynamic> gelenJson)
      : id = gelenJson["id"],
        isim = gelenJson["isim"];
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Ogrenci halil;

    halil = Ogrenci(5, "halil");

    print(halil.toString());

    Map<String, dynamic> mapHasan = {"id": 1, "isim": "hasan"};
    //print("id " + mapHasan["id"].toString() + " isim " + mapHasan["isim"]);

    Ogrenci hasan = Ogrenci.mapiNesneyeDonustur(mapHasan);

    //print(hasan.isim);

    Map<String, dynamic> fatmaMap = {"id": 2, "isim": "fatma"};

    Ogrenci fatma = Ogrenci.fromMap(fatmaMap);

    print(fatma.toString());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => LocalJsonKullanimi()),
              );
            },
            child: Text("data"),
          ),
        ),
      ),
    );
  }
}
