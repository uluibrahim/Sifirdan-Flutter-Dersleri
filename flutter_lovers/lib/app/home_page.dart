import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/kullanicilar.dart';
import 'package:flutter_lovers/app/my_custom_bottom_navigation.dart';
import 'package:flutter_lovers/app/profil.dart';
import 'package:flutter_lovers/app/tab_items.dart';
import 'package:flutter_lovers/models/user_model.dart';

import 'konusmalarim_page.dart';

class HomePage extends StatefulWidget {
  final MyUser user;
  HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.Kullanicilar;
  Map<TabItem, Widget> tumSayfalar() {
    return {
      TabItem.Kullanicilar: KullanicilarPage(),
      TabItem.Konusmalirim: KonusmalarimPage(),
      TabItem.Profil: ProfilPage(),
    };
  }

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.Kullanicilar: GlobalKey<NavigatorState>(),
    TabItem.Konusmalirim: GlobalKey<NavigatorState>(),
    TabItem.Profil: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
      child: MyCustomBottomNavigation(
        currentTab: _currentTab,
        onSelectedTab: (secilenTab) {
          if (secilenTab == _currentTab) {
            navigatorKeys[secilenTab]!
                .currentState!
                .popUntil((route) => route.isFirst);
            // is first ile stacteki ilk elemana kadar pop yapmış olduk
          } else {
            setState(() {
              _currentTab = secilenTab;
            });
          }

          print("Secilen tab: " + secilenTab.toString());
        },
        sayfaOlustur: tumSayfalar(),
        navigatorKeys: navigatorKeys,
      ),
    );
  }
}
