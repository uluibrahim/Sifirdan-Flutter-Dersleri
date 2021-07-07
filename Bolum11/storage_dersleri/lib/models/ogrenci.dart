class Ogrenci {
  // tabloda öğrenci ile neler tutulacak

  int? _id;
  String? _isim;
  int? _aktif;

  Ogrenci(this._isim, this._aktif);
  Ogrenci.withId(this._id, this._isim, this._aktif);

  int get id => _id!;

  set id(int value) {
    _id = value;
  }

  String get isim => _isim!;

  set isim(String value) {
    _isim = value;
  }

  int get aktif => _aktif!;

  set aktif(int value) {
    _aktif = value;
  }

// var olan bir objeyi mape dönüştürme
// veri tabanına deger yazdırılırken kullanılır
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["id"] = _id;
    map["isim"] = _isim;
    map["aktif"] = _aktif;
    return map;
  }

// var olan bir mapi objeye dönüştürme
// veri tabanından okumak için kullanılır
  Ogrenci.fromMap(Map<String, dynamic> value) {
    this._id = value["id"];
    this._isim = value["isim"];
    this._aktif = value["aktif"];
  }

  @override
  String toString() => 'Ogrenci(_id: $_id, _isim: $_isim, _aktif: $_aktif)';
}
