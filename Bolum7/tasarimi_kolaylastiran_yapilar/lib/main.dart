import 'package:flutter/material.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/ana_sayfa.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/arama_sayfasi.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/drawer.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/font_kullanimi.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/hesap_sayfasi.dart';
import 'package:tasarimi_kolaylastiran_yapilar/view/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  List? tumSayfalar;
  AnaSafya? anaSayfa;
  AramaSayfasi? aramaSayfasi;
  SettingsPage? ayarSayfasi;
  HesapPage? hesapSayfasi;

  var keyAnaSayfa = PageStorageKey("key_ana_sayfa");
  var keyAramaSayfasi = PageStorageKey("key_arama_sayfa");
  @override
  void initState() {
    super.initState();
    anaSayfa = AnaSafya(keyAnaSayfa);
    aramaSayfasi = AramaSayfasi(keyAramaSayfasi);
    ayarSayfasi = SettingsPage();
    hesapSayfasi = HesapPage();
    tumSayfalar = [anaSayfa, aramaSayfasi, hesapSayfasi, ayarSayfasi];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Ubuntu"),
      title: 'Tasarım',
      home: Scaffold(
        drawer: SafeArea(child: DrawerMenu()),
        bottomNavigationBar: navMenu(),
        appBar: appBar(),
        body: Center(child: tumSayfalar![_currentIndex]),
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

  navMenu() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Hesap',
            backgroundColor: Colors.indigoAccent),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
            backgroundColor: Colors.green),
      ],
      selectedItemColor: Colors.black,
      backgroundColor: Colors.teal.shade300,
      //type: BottomNavigationBarType.fixed, // 3 ten fazla öğe eklenşrse fixedten çıktığında kullanılabilir.
      // 3 ten fazla öğe eklenirse her öğere color verilmelidir
      currentIndex: _currentIndex,
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
    );
  }
}
