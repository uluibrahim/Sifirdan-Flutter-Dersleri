import 'package:burc_rehberi/burc_detay.dart';

class Burc {
  String _burcAdi;
  String _burcTarihi;
  String _burcDetay;
  String _burcKucukResim;
  String _burcBuyukResim;
  Burc(this._burcAdi, this._burcTarihi, this._burcDetay, this._burcKucukResim,
      this._burcBuyukResim);

  String get burcAdi => _burcAdi;
  set burcAdi(value) => _burcAdi = value;

  String get burcTarihi => _burcTarihi;
  set burcTarihi(value) => _burcTarihi = value;

  String get burcDetay => _burcDetay;
  set burcDetay(value) => _burcDetay = value;

  String get burcBuyukResim => _burcBuyukResim;
  set burcBuyukResim(value) => _burcBuyukResim = value;

  String get burcKucukResim => _burcKucukResim;
  set burcKucukResim(value) => _burcKucukResim = value;
}
