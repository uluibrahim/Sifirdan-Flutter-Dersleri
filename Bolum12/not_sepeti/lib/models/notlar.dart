class Not {
  int? _notID;
  int? _kategoriID;
  String? _kategoriBaslik;

  String? get kategoriBaslik => _kategoriBaslik;

  set kategoriBaslik(String? kategoriBaslik) {
    _kategoriBaslik = kategoriBaslik;
  }

  String? _notBaslik;
  String? _notIcerik;
  String? _notTarih;
  int? _notOncelik;

  int? get notID => _notID;

  set notID(int? notID) {
    _notID = notID;
  }

  int? get kategoriID => _kategoriID;

  set kategoriID(int? kategoriID) {
    _kategoriID = kategoriID;
  }

  String? get notBaslik => _notBaslik;

  set notBaslik(String? notBaslik) {
    _notBaslik = notBaslik;
  }

  String? get notIcerik => _notIcerik;

  set notIcerik(String? notIcerik) {
    _notIcerik = notIcerik;
  }

  String? get notTarih => _notTarih;

  set notTarih(String? notTarih) {
    _notTarih = notTarih;
  }

  int? get notOncelik => _notOncelik;

  set notOncelik(int? notOncelik) {
    _notOncelik = notOncelik;
  }

  // veri okurken
  Not(
    this._kategoriID,
    this._notBaslik,
    this._notIcerik,
    this._notOncelik,
  );
  //veri yazarken
  Not.withID(
    this._notID,
    this._kategoriID,
    this._notBaslik,
    this._notIcerik,
    // this._notTarih,
    this._notOncelik,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["kategoriID"] = _kategoriID;
    map["notBaslik"] = _notBaslik;
    map["notIcerik"] = _notIcerik;
    map["notOncelik"] = _notOncelik;
    return map;
  }

  Not.fromMap(Map<String, dynamic> map) {
    this._notID = map["notID"];
    this._kategoriID = map["kategoriID"];
    this._kategoriBaslik = map['kategoriBaslik'];
    this._notBaslik = map["notBaslik"];
    this._notIcerik = map["notIcerik"];
    this._notTarih = map["notTarih"];
    this._notOncelik = map["notOncelik"];
  }

  @override
  String toString() {
    return 'Not(_notID: $_notID, _kategoriID: $_kategoriID, _notBaslik: $_notBaslik, _notIcerik: $_notIcerik, _notTarih: $_notTarih, _notOncelik: $_notOncelik)';
  }
}
