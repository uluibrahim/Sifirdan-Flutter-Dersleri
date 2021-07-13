import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class FirestoreIslemleri extends StatefulWidget {
  FirestoreIslemleri({Key? key}) : super(key: key);

  @override
  _FirestoreIslemleriState createState() => _FirestoreIslemleriState();
}

class _FirestoreIslemleriState extends State<FirestoreIslemleri> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Firestore işlemleri")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: _veriEkle, child: Text("Veri ekle")),
            ElevatedButton(
                onPressed: _transactionEkle, child: Text("Transaction ekle")),
            ElevatedButton(onPressed: _veriSil, child: Text("Veri sil")),
            ElevatedButton(onPressed: _veriOku, child: Text("Veri oku")),
            ElevatedButton(
                onPressed: _veriSorgula, child: Text("Veri sorgula")),
          ],
        ),
      ),
    );
  }

  void _veriEkle() {
    Map<String, dynamic> emreEkle = Map();
    emreEkle["ad"] = "emre";
    emreEkle["mezun2"] = true;
    _firestore
        .collection("users")
        .doc("emre_altunbilek")
        .set(emreEkle, SetOptions(merge: true))
        .then((value) => print("emre eklendi"));

    _firestore
        .collection("users")
        .doc("hasan")
        .set({"ad": "hasan", "cinsiyet": "erkek"}).whenComplete(
            () => print("hasan eklendi"));

    _firestore
        .doc("/users/ayse")
        .set({"ad": "ayse"}).whenComplete(() => print("Ayse eklendi"));

    // id yi sistemin atamasını istiyorsak add kullanılır
    //_firestore.collection("users").add({"ad": "halil"});

    // kullanıcı referansını tutmak
    String yeniKullaniciId = _firestore.collection("users").doc().id;
    print("Yeni kullanıcı doc id: $yeniKullaniciId");

    _firestore
        .collection("users")
        .doc(yeniKullaniciId)
        .set({"ad": "ibrahim", "user_id": "$yeniKullaniciId"});

// update ile birlikte sitemsaatinide kaydedebiliriz
    _firestore.doc("users/emre_altunbilek").update({
      "mezun": false,
      "eklenme": FieldValue.serverTimestamp(),
      "begeni": FieldValue.increment(10)
    }).then((value) => print("güncellendi"));
  }

  void _transactionEkle() {
    DocumentReference? hasanDocRef = _firestore.doc("users/hasan");

    _firestore.runTransaction((transaction) async {
      // hasan docummanı içindeki bilgileri okumuş olduk
      DocumentSnapshot? hasanData = await hasanDocRef.get();

      int hasaninParasi = hasanData["para"];
      if (hasanData.exists) {
        if (hasaninParasi > 100) {
          transaction.update(hasanDocRef, {"para": (hasaninParasi - 100)});
          transaction.update(_firestore.doc("users/ayse"),
              {"para": FieldValue.increment(100)});
        } else {
          print("Bakiye yetersiz.");
        }
      } else {
        print("Hasan document i yok");
      }
    });
  }

  void _veriSil() {
    // document silmek
    _firestore.doc("users/silinecek").delete().then((value) {
      print("Silme işlemi başarılı...");
    }).catchError((error) {
      print("Silme işlemi başarısız. Hata: $error");
    });

    // documennt içindeki veriyi silmek
    _firestore
        .doc("users/hasan")
        .update({"cinsiyet": FieldValue.delete()}).then((value) {
      print("Veri silme işlemi başarılı");
    }).catchError((onError) {
      print("Veri silme işlemi başarısız. Hata: $onError");
    });
  }

  Future<void> _veriOku() async {
    DocumentSnapshot documentSnapshot =
        await _firestore.doc("users/emre_altunbilek").get();
    print("Document id: " + documentSnapshot.id);
    print("Document exists: " + documentSnapshot.exists.toString());
    print("Document data: " + documentSnapshot.data().toString());
    print("Document VAR MI?: " +
        documentSnapshot.metadata.hasPendingWrites.toString());
    print("Document id: " + documentSnapshot.toString());

    Map emreAltunbilek = (documentSnapshot.data() as Map);
    print(emreAltunbilek["mezun"]);
    emreAltunbilek.forEach((key, value) {
      print("key: $key    value: $value");
    });

    // bütün doocument  leri okumak

    _firestore.collection("users").get().then((quuerySnapshot) {
      for (var i = 0; i < quuerySnapshot.docs.length; i++) {
        print(quuerySnapshot.docs[i].data());
      }
    });

    // anlık olarak documentin dinlenmesi ve değişimleri yansıtması
    DocumentReference ref =
        _firestore.collection("users").doc("emre_altunbilek");

    ref.snapshots().listen((anlikVeri) {
      print("Anlık: " + anlikVeri.data().toString());
    });

    _firestore.collection("users").snapshots().listen((event) {
      print(event.docs.length.toString());
    });
  }

  _veriSorgula() async {
    _emaileGoreSorgu();

    _limitliSorgu();

    _diziSorgulama();

    _stringSorgu();
    _karsilastirmaIleVeriGetir();
  }

  void _emaileGoreSorgu() async {
    QuerySnapshot<Map<String, dynamic>> dokumanlar = await _firestore
        .collection("users")
        .where("email", isEqualTo: "emre@gmail.com")
        .get();
    for (var dokuman in dokumanlar.docs) {
      // print(dokuman.data().toString());
    }
  }

  void _limitliSorgu() async {
    // eğer çok fazla veri varsa ve bir kısmını istiyorsak limit kullanılabilir
    QuerySnapshot<Map<String, dynamic>> limitliGetir =
        await _firestore.collection("users").limit(2).get();
    for (var dokuman in limitliGetir.docs) {
      //   print("Limitli getirilenler: " + dokuman.data().toString());
    }
  }

  void _diziSorgulama() async {
    QuerySnapshot<Map<String, dynamic>> diziSorgula = await _firestore
        .collection("users")
        .where("dizi", arrayContains: "arka sokaklar")
        .get();

    for (var dokuman in diziSorgula.docs) {
      //   print("Dizi ile getirilenler: " + dokuman.data().toString());
    }
  }

  _stringSorgu() async {
    // burada orderby kullanaran hangi isimdeki verileri sıralayacağımızı belirttik

    QuerySnapshot<Map<String, dynamic>> stringSorgula = await _firestore
        .collection("users")
        .orderBy("email")
        .startAt(["ayse"]).endAt(["com"]).get();

    for (var dokuman in stringSorgula.docs) {
      // print("String orderby ile getirilenler: " + dokuman.data().toString());
    }
  }

  _karsilastirmaIleVeriGetir() {
    _firestore.collection("users").doc("emre_altunbilek").get().then((docSnap) {
      print("Emrenin verileri: " + docSnap.data().toString());

      _firestore
          .collection("users")
          .orderBy("begeni")
          .startAt([docSnap["begeni"]])
          .get()
          .then((querySnap) {
            if (querySnap.docs.length > 0) {
              for (var item in querySnap.docs) {
                print("Emrenin begenisinden fazla olanlar: " +
                    item.data().toString());
              }
            } else {
              print("Map içi boş");
            }
          });
    });
  }
}
