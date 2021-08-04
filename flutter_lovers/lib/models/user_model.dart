import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String? userId;
  String? email;
  String? userName;
  String? profilURL;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? seviye;

  MyUser({required this.userId, required this.email});
  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "email": email,
      "userName": userName ??
          email!.substring(0, email!.indexOf("@")) + randomSayiUret(),
      "profilURL": profilURL ??
          "https://st.depositphotos.com/1779253/5140/v/950/depositphotos_51405259-stock-illustration-male-avatar-profile-picture-use.jpg",
      "createdAt": createdAt ??
          FieldValue
              .serverTimestamp(), //database i değiştirir isel burayı güncelle
      "updatedAt": updatedAt ??
          FieldValue
              .serverTimestamp(), //database i değiştirir isel burayı güncelle
      "seviye": seviye ?? 1,
    };
  }

  MyUser.fromMap(Map<String, dynamic> map)
      // : ile o an oluşturuan nesnenin allanlarına erişmekte kulllanılır
      : userId = map["userId"],
        email = map["email"],
        userName = map["userName"],
        profilURL = map["profilURL"],
        createdAt = (map["createdAt"] as Timestamp).toDate(),
        updatedAt = (map["updatedAt"] as Timestamp).toDate(),
        seviye = map["seviye"];

  MyUser.userIdAndProfilPhotoAndUserName(
      {required this.userId, required this.profilURL, required this.userName});

  @override
  String toString() {
    return "User{ userId: $userId, email: $email, userName: $userName, profilURL: $profilURL, createAt: $createdAt, updateAt: $updatedAt}";
  }

  String randomSayiUret() {
    int _randomSayi = Random(1).nextInt(999999);
    return _randomSayi.toString();
  }
}
