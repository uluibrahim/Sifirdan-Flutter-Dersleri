import 'package:flutter/material.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/bottom_navigation_bar.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/drawer.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/font_kullanimi.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Ubuntu"),
      title: 'Tasarım',
      home: Scaffold(
        drawer: SafeArea(child: DrawerMenu()),
        bottomNavigationBar: BottomNavigationBarKullanimi(_currentIndex),
        appBar: appBar(),
        body: Center(child: FontKullanimi()),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        'Tasarımı kolaylaştıran yapılar',
        style: TextStyle(fontFamily: "Dancing", fontSize: 25),
      ),
    );
  }
}
