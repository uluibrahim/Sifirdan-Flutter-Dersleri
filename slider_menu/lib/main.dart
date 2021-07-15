import 'package:flutter/material.dart';
import 'package:slider_menu/view/menu_dashboard.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Slider Menu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MenuDashboard(title: "Menu Dashboard"),
    );
  }
}
