import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:storage_dersleri/models/ogrenci.dart';

class DatabaseHelper {
  ///CRUD İŞLEMLERİ

  // bu sınıftan herhangi bir nesne üretmeden kullanılması için static yapmak gerekir
  static DatabaseHelper? _databaseHelper;
  static Database? _database;

  String _ogrenciTablo = "ogrenci";

  String _columnId = "id";
  String _columnIsim = "isim";
  String _columnAktif = "aktif";

  // kontroller yapılacağından factory olrak tanımlandı
  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._internal();
      print("db null idi oluşturuldu");
      return _databaseHelper!;
    } else {
      print("db null değildi var olan kullanıldı");
      return _databaseHelper!;
    }
  }

  DatabaseHelper._internal();

  // sistemde bulunan veri tabanını getirmek
  Future<Database> _getDatabase() async {
    if (_database == null) {
      print("DB null idi oluşturulacak");
      _database = await _intializeDatabase();
      return _database!;
    } else {
      print("DB null değildi var olan kullanılacak");
      return _database!;
    }
  }

  _intializeDatabase() async {
    // telefon hafızasında bulunan veri tabanına erişmek
    Directory klasor =
        await getApplicationDocumentsDirectory(); // dosyanın hangi klasorde bulunduğunu gösterir
    // ancak bizim burada ihtiyacımız dosyanın kendisi
    // bundan dolayı join metodu kullanılmalı
    String dbpath = join(klasor.path + "/ogrenci.db"); // db ismi verilir
    print("db path " + dbpath);
    // açılacak db nin pathi verilir
    // openDatabese metodu onCreate özelliği ilk defa oluşturulacaksa kullanılmalıdır
    var ogrenciDB = openDatabase(dbpath, version: 1, onCreate: _dbCreate);
    // burada eğer yeni tablo veya yeni sutun eklenmesi halinde versiyonun arttırılması gerekir ki eski veri tabannı güncellernsin
    return ogrenciDB;
  }

  // veri tabanı üzerinden tabloları oluşturuyor
  Future<FutureOr<void>> _dbCreate(Database db, int version) async {
    print("db create metodu çalıştırıılıp tablo oluşturuldu");
    await db.execute(
        "CREATE TABLE $_ogrenciTablo ($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnAktif INTEGER )");
  }

  // veri tabınana yapılacak işlemler kısmı (ekleme silme güncelleme  yazdırma)

  Future<int> ogrenciEkle(Ogrenci ogrenci) async {
    var db = await _getDatabase();
    var sonuc = await db.insert(_ogrenciTablo, ogrenci.toMap(),
        nullColumnHack: "$_columnId");
    // nullColumnHack eğer sutun adı verilmezse bile id  vermesini sağlar
    print("Sonuc " + sonuc.toString());
    return sonuc;
  }

  Future<List<Map<String, dynamic>>> tumOgrenciler() async {
    // tabloyu okumak
    var db = await _getDatabase();
    var sonuc = db.query(_ogrenciTablo, orderBy: "$_columnId DESC");
    return sonuc;
  }

  Future<int> ogrenciGuncelle(Ogrenci ogrenci) async {
    var db = await _getDatabase();

    var sonuc = await db.update(_ogrenciTablo, ogrenci.toMap(),
        where: "$_columnId = ?", whereArgs: [ogrenci.id]);

    return sonuc;
  }

  Future<int> ogrenciSil(int id) async {
    var db = await _getDatabase();

    var sonuc = await db
        .delete(_ogrenciTablo, where: "$_columnId = ?", whereArgs: [id]);
    // kaç tane veri sildiğini döndürür
    return sonuc;
  }

  Future<int> tumOgrenciTablosunuSil(int id) async {
    var db = await _getDatabase();

    var sonuc = await db.delete(_ogrenciTablo);

    return sonuc;
  }
}
