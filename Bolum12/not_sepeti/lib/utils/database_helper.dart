import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // sınıfa özgü değişken
  static DatabaseHelper? _databaseHelper;

  static Database? _database;

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      return _databaseHelper = DatabaseHelper._internal();
    } else {
      return _databaseHelper!;
    }
  }
  DatabaseHelper._internal();

  Future<Database> _getDatabase() async {
    if (_database == null) {
      _database = await _initializeDatabase();
      return _database!;
    } else {
      return _database!;
    }
  }

  Future<Database> _initializeDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "notlar.db");

    // Check if the database exists
    var exists = await databaseExists(
        path); // veri tabanının var olup olmadığını kontrol eder

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets/db", "notlar.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    return await openDatabase(path, readOnly: false);
  }

  kategoriTablosunuGetir() async {
    var db = await _getDatabase();

    var sonuc = await db
        .query("kategori"); // butun kategorileri içeren bir map döndürür
    print(sonuc);
    await db.insert("kategori", {"kategoriBaslik": "deneme kategori"});
    var sonuc2 = await db.query("kategori");
    print(sonuc2);
  }
}
