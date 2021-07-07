import 'package:flutter/material.dart';
import 'package:storage_dersleri/dosya_islemleri.dart';
import 'package:storage_dersleri/models/ogrenci.dart';
import 'package:storage_dersleri/sqllife_islemleri.dart';
import 'package:storage_dersleri/utils/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SqllifeIslemleri(),
    );
  }
}
