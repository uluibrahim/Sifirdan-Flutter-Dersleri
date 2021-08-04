import 'package:cloud_firestore/cloud_firestore.dart';

class KonusmaModel {
  final String? konusmaSahibi;
  final String? kimleKonusuyor;
  final bool? goruldu;
  final Timestamp? olusturmaTarihi;
  final String? sonYollananMesaj;
  final Timestamp? gorulmeTarihi;
  String? konusulanUserName;
  String? konusulanUserProfilURL;
  DateTime? sonOkunmaZamani;
  String? aradakiZamanFarki;
  KonusmaModel({
    this.konusmaSahibi,
    this.kimleKonusuyor,
    this.goruldu,
    this.olusturmaTarihi,
    this.sonYollananMesaj,
    this.gorulmeTarihi,
  });

  Map<String, dynamic> toMap() {
    return {
      "konusma_sahibi": konusmaSahibi,
      "kimle_konusuyor": kimleKonusuyor,
      "goruldu": goruldu,
      "olusturulma_tarihi": olusturmaTarihi ?? FieldValue.serverTimestamp(),
      "son_yollanan_mesaj": sonYollananMesaj,
      "gorulme_tarihi": gorulmeTarihi ?? FieldValue.serverTimestamp(),
    };
  }

  KonusmaModel.fromMap(Map<String, dynamic> map)
      : konusmaSahibi = map["konusma_sahibi"],
        kimleKonusuyor = map["kimle_konusuyor"],
        goruldu = map["goruldu"],
        olusturmaTarihi = map["olusturulma_tarihi"],
        sonYollananMesaj = map["son_yollanan_mesaj"],
        gorulmeTarihi = map["gorulme_tarihi"];

  @override
  String toString() {
    return 'KonusmaModel(konusmaSahibi: $konusmaSahibi, kimleKonusuyor: $kimleKonusuyor, goruldu: $goruldu, olusturmaTarihi: $olusturmaTarihi, sonYollananMesaj: $sonYollananMesaj, gorulmeTarihi: $gorulmeTarihi)';
  }
}
