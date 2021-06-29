import 'package:burc_rehberi/utils/strings.dart';
import 'package:flutter/material.dart';
import 'burc_detay.dart';
import 'burc_listesi.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.pink),
      debugShowCheckedModeBanner: false,
      title: 'Burc Rehberi',
      onUnknownRoute: (RouteSettings settings) => MaterialPageRoute(
        builder: (context) => BurcListesi(),
      ),
      routes: {
        "/": (context) => BurcListesi(),
      },
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        List<String> pathElemanlari = settings.name!.split("/");

        if (pathElemanlari[1] == "detay") {
          return MaterialPageRoute(
              builder: (context) => BurcDetay(int.parse(pathElemanlari[2])));
        }
        return null;
      },
    );
  }
}
