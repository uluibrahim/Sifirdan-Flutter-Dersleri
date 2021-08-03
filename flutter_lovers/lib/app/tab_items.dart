import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem { Kullanicilar, Konusmalirim, Profil }

class TabItemData {
  IconData icon;
  String labelText;
  TabItemData({required this.icon, required this.labelText});

  static Map<TabItem, TabItemData> tumTablar = {
    TabItem.Kullanicilar:
        TabItemData(icon: Icons.supervised_user_circle, labelText: "users"),
    TabItem.Konusmalirim:
        TabItemData(icon: Icons.chat, labelText: "konusmalarim"),
    TabItem.Profil: TabItemData(icon: Icons.person, labelText: "profil"),
  };
}
