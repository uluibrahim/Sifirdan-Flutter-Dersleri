import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:scroll/form_islemleri.dart';

import 'card_list_tile.dart';
import 'custom_scroll_view.dart';
import 'grid_view.dart';
import 'list_view_kullanimi.dart';
import 'navigasyon_islemleri.dart';

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
      //home: SafeArea(child: NavigasyonIslemleri()),
      builder: EasyLoading.init(),
      routes: {
        // kök dizin / ile gösterilir  program ilk açıldığında kök dizinden başlar
        // burada kök dizin tanımlanmış home iptal edilmelidir aksi takdirde uygulamala ikisi arasında karar veremeyip hata verecektir.
        "/": (context) => FormIslemleri(),
        //"/": (context) => NavigasyonIslemleri(),
        "/APage": (context) => ASayfasi(),
        "/EPage": (context) => ESayfasi(),
        "/DPage": (context) => DSayfasi(),
        "APage": (context) => ASayfasi(),
        "/listeSayfasi": (context) => ListeSayfasi(),
        // "/form_islemleri":(context)=>
      },
      //initialRoute: "APage",
      // verilen rota bulunamazsa unknow çalışır
      // hata almamamk adına kullanılır
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (context) => ASayfasi(),
      ),
      onGenerateRoute: (RouteSettings settings) {
        List<String> pathElemanlari = settings.name.split("/");
        if (pathElemanlari[1] == "detay") {
          return MaterialPageRoute(
              builder: (context) => ListeDetay(int.parse(pathElemanlari[2])));
        }
        return null;
      },
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
