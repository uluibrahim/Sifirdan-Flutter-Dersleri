import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/tab_items.dart';

class MyCustomBottomNavigation extends StatelessWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectedTab;
  final Map<TabItem, Widget> sayfaOlustur;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  MyCustomBottomNavigation(
      {required this.currentTab,
      required this.onSelectedTab,
      required this.sayfaOlustur,
      required this.navigatorKeys});

  @override
  Widget build(BuildContext context) {
    // biden fazla navigator isteniryorsa CupertinoTabScaffold kullanılabilir
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _bottomNavigationBarItem(TabItem.Kullanicilar),
          _bottomNavigationBarItem(TabItem.Konusmalarim),
          _bottomNavigationBarItem(TabItem.Profil),
        ],
        onTap: (index) => onSelectedTab(TabItem.values[index]),
      ),
      tabBuilder: (context, index) {
        final gosterilecekItem = TabItem.values[index];
        return CupertinoTabView(
          navigatorKey: navigatorKeys[gosterilecekItem],
          builder: (context) {
            return sayfaOlustur[gosterilecekItem]!;
          },
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavigationBarItem(TabItem tabItem) {
    final _olusturulacakTab = TabItemData.tumTablar[tabItem];
    return BottomNavigationBarItem(
      icon: Icon(_olusturulacakTab!.icon),
      label: _olusturulacakTab.labelText,
    );
  }
}
