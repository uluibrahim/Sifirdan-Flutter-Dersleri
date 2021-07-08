class Kategori {
  int? _kategoriID;
  String? _kategoriBaslik;

  // db ye kategori eklerken kullanılır. Id db tarafından otomatik atanır
  Kategori(this._kategoriBaslik);

  // Db den veri okurken kullanılır
  Kategori.withID(this._kategoriID, this._kategoriBaslik);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kategoriID"] = kategoriID;
    map["kategoriBaslik"] = _kategoriBaslik;
    return map;
  }

  Kategori.fromMap(Map<String, dynamic> map) {
    this._kategoriID = map["kategoriID"];
    this._kategoriBaslik = map["kategoriBaslik"];
  }

  int get kategoriID => _kategoriID!;

  set kategoriID(int kategoriID) {
    _kategoriID = kategoriID;
  }

  String get kategoriBaslik => _kategoriBaslik!;

  set kategoriBaslik(String kategoriBaslik) {
    _kategoriBaslik = kategoriBaslik;
  }

  @override
  String toString() =>
      'Kategori(_kategoriID: $_kategoriID, _kategoriBaslik: $_kategoriBaslik)';
}
