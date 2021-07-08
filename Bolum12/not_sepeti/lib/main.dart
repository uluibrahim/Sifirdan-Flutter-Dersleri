import 'package:flutter/material.dart';
import 'package:not_sepeti/utils/database_helper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  var db = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    db.kategoriTablosunuGetir();
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
