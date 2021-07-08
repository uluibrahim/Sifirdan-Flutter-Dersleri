class Not {
  int? _notID;
  int? _kategoriID;
  String? _notBaslik;
  String? _notIcerik;
  String? _notTarih;
  int? _notOncelik;

  // veri okurken
  Not(
    this._kategoriID,
    this._notBaslik,
    this._notIcerik,
    this._notTarih,
    this._notOncelik,
  );
  //veri yazarken
  Not.withID(
    this._notID,
    this._kategoriID,
    this._notBaslik,
    this._notIcerik,
    this._notTarih,
    this._notOncelik,
  );

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["notID"] = _notID;
    map["kategoriID"] = _kategoriID;
    map["notBaslik"] = _notBaslik;
    map["notIcerik"] = _notIcerik;
    map["notTarih"] = _notTarih;
    map["notOncelik"] = _notOncelik;
    return map;
  }

  Not.fromMap(Map<String, dynamic> map) {
    this._notID = map["notID"];
    this._kategoriID = map["kategoriID"];
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
