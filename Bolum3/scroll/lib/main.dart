import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'card_list_tile.dart';
import 'custom_scroll_view.dart';
import 'grid_view.dart';
import 'list_view_kullanimi.dart';

void main() {
  runApp(MyApp());
  configLoading();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: SafeArea(
        child: CustomScrollViewKullanimi(),
      ),
      builder: EasyLoading.init(),
    );
  }
}

// easy loading kişiselleştirmesi
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 4000)
    ..indicatorType = EasyLoadingIndicatorType.doubleBounce
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 70.0
    ..radius = 50.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.cyan
    ..indicatorColor = Colors.red
    ..textColor = Colors.white
    ..maskColor = Colors.black.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}
