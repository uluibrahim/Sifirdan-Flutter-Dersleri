import 'package:flutter/material.dart';
import 'package:weatherapp_with_provider/models/my_theme.dart';

class MyThemeViewModel with ChangeNotifier {
  MyTheme? _myTheme;

  MyThemeViewModel() {
    _myTheme = MyTheme(Colors.blue, ThemeData.light());
  }

  MyTheme get myTheme => _myTheme!;

  set myTheme(MyTheme myTheme) {
    _myTheme = myTheme;
    notifyListeners();
  }

  void temaDegistir(String havaDurumuKisaltmasi) {
    MyTheme? _geciciTheme;
    switch (havaDurumuKisaltmasi) {
      case "sn": //karlı
      case "sl": // sulu kar
      case "h": // dolu
      case "t": // fırtına
      case "hc": // çok bulutlu
        _geciciTheme = MyTheme(
          Colors.grey,
          ThemeData(primaryColor: Colors.blueGrey),
        );
        break;
      case "hr": // ağır yağmurlu
      case "lr": // hafif yağmurlu
      case "s": // sağanak yağışlı
        _geciciTheme = MyTheme(
          Colors.indigo,
          ThemeData(primaryColor: Colors.indigoAccent),
        );
        break;
      case "lc": // az bulutlu
      case "c": // açık hava

        _geciciTheme = MyTheme(
          Colors.orange,
          ThemeData(primaryColor: Colors.orangeAccent),
        );
        break;
    }
    _myTheme = _geciciTheme!;
  }
}
