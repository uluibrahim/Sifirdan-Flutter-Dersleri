import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
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
    String dbpath = join(klasor.path + "ogrenci.db");
    print("db path " + dbpath);
    // açılacak db nin pathi verilir
    // openDatabese metodu onCreate özelliği ilk defa oluşturulacaksa kullanılmalıdır
    var ogrenciDB = openDatabase(dbpath, version: 1, onCreate: _dbCreate);
    // burada eğer yeni tablo veya yeni sutun eklenmesi halinde versiyonun arttırılması gerekir ki eski veri tabannı güncellernsin
    return ogrenciDB;
  }

  // veri tabanı üzerinden tabloları oluşturuyor
  FutureOr<void> _dbCreate(Database db, int version) {
    print("db create metodu çalıştırıılıp tablo oluşturuldu");
    db.execute(
        "CREATE TABLE $_ogrenciTablo ($_columnId INTEGER PRIMARY KEY AUTOINCREMENT, $_columnIsim TEXT, $_columnAktif INTEGER )");
  }
}
