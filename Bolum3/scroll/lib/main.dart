import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'card_list_tile.dart';
import 'list_view_kullanimi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: ListViewKullanimi(),
    );
  }
}
