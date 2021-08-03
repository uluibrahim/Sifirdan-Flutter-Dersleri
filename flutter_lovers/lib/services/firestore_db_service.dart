import 'package:flutter_lovers/models/konusma_model.dart';
import 'package:flutter_lovers/models/message.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/services/db_base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDBService implements DBBase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<bool> saveUser(MyUser user) async {
    await _firebaseFirestore
        .collection("users")
        .doc(user.userId)
        .set(user.toMap());

    return true;
  }

  @override
  Future<MyUser> readUser(String userId) async {
    DocumentSnapshot _okunanUser =
        await _firebaseFirestore.doc("users/$userId").get();
    Map<String, dynamic> _okunanUserBilgileriMap =
        (_okunanUser.data() as Map<String, dynamic>);

    MyUser _okunanUserBilgileriNesne = MyUser.fromMap(_okunanUserBilgileriMap);

    print("Read User: " + _okunanUserBilgileriNesne.toString());
    return _okunanUserBilgileriNesne;
  }

  @override
  Future<bool> updateUserName(String userId, String newUserName) async {
    // burada newUserName değişkeninin değerinin aynısının olur olmadığını bulabiliriz
    // eğer sonuc 1 dönerse aynısı vardır
    // eğer sonuc 0 dönerse aynısı yoktur ve değiştirilebilir
    QuerySnapshot user = await _firebaseFirestore
        .collection("users")
        .where("userName", isEqualTo: newUserName)
        .get();
    if (user.docs.length >= 1) {
      // eğer length 1 ise aynı isimde kullanıcı var demektir
      return false;
    } else {
      await _firebaseFirestore
          .collection("users")
          .doc(userId)
          .update({"userName": newUserName});
      return true;
    }
  }

  Future<bool> updateProfilPhoto(String userId, String photoUrl) async {
    await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .update({"profilURL": photoUrl});
    return true;
  }

  @override
  Future<List<MyUser>> getAllUesr() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await _firebaseFirestore.collection("users").get();
    List<MyUser> allUsers = [];
    for (QueryDocumentSnapshot<Map<String, dynamic>> tekUser
        in querySnapshot.docs) {
      MyUser _user = MyUser.fromMap(tekUser.data());
      allUsers.add(_user);
    }
    return allUsers;
  }

  @override
  Future<List<KonusmaModel>> getAllConversations(String userId) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firebaseFirestore
        .collection("konusmalar")
        .where("konusma_sahibi", isEqualTo: userId)
        .orderBy("olusturulma_tarihi", descending: true)
        .get();

    List<KonusmaModel> tumKonusmalar = [];

    for (QueryDocumentSnapshot<Map<String, dynamic>> tekKonusma
        in querySnapshot.docs) {
      KonusmaModel _tekKonusma = KonusmaModel.fromMap(tekKonusma.data());
      /*print("okunan konusma tarisi:" +
          _tekKonusma.olusturulma_tarihi.toDate().toString());*/
      tumKonusmalar.add(_tekKonusma);
    }

    return tumKonusmalar;
  }

  @override
  Stream<List<MessageModel>> getMessages(
      String currentUserId, String sohbetEdilenUserId) {
    Stream<QuerySnapshot<Map<String, dynamic>>> _snapshot = _firebaseFirestore
        .collection("konusmalar")
        .doc(currentUserId + "--" + sohbetEdilenUserId)
        .collection("mesajlar")
        .orderBy("date", descending: true)
        .snapshots();
    return _snapshot.map((mesajListesi) => mesajListesi.docs
        .map((mesaj) => MessageModel.fromMap(mesaj.data()))
        .toList());
  }

  Future<bool> saveMessage(MessageModel mesaj) async {
    String _mesajID = _firebaseFirestore
        .collection("konusmalar")
        .doc()
        .id; // rastgele id almak

    String _myDocumentId =
        mesaj.kimden + "--" + mesaj.kime; // mesaj gönderen id
    String _receiverDocumentId =
        mesaj.kime + "--" + mesaj.kimden; // mesaj alıcı id
    Map<String, dynamic> _kaydedeilecekMesajMap = mesaj.toMap();
    await _firebaseFirestore
        .collection("konusmalar")
        .doc(_myDocumentId)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedeilecekMesajMap);

    await _firebaseFirestore.collection("konusmalar").doc(_myDocumentId).set({
      "konusma_sahibi": mesaj.kimden,
      "kimle_konusuyor": mesaj.kime,
      "son_yollanan_mesaj": mesaj.message,
      "konusma_goruldu": false,
      "olusturma_tarihi": FieldValue.serverTimestamp(),
    });

    // yukarıdaki kayıttan sonra sohbet edilen kişiyede kayıt yapılmalı
    // bunun için "kimden" değişkenini değiştirmek gerekir

    await _kaydedeilecekMesajMap.update("bendenMi", (value) => false);

    await _firebaseFirestore
        .collection("konusmalar")
        .doc(_receiverDocumentId)
        .collection("mesajlar")
        .doc(_mesajID)
        .set(_kaydedeilecekMesajMap);

    await _firebaseFirestore
        .collection("konusmalar")
        .doc(_receiverDocumentId)
        .set({
      "konusma_sahibi": mesaj.kime,
      "kimle_konusuyor": mesaj.kimden,
      "son_yollanan_mesaj": mesaj.message,
      "konusma_goruldu": false,
      "olusturma_tarihi": FieldValue.serverTimestamp(),
    });
    return true;
  }
}
