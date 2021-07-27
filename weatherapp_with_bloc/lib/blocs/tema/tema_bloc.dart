import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tema_event.dart';
import 'tema_state.dart';

class TemaBloc extends Bloc<TemaEvent, TemaState> {
  TemaBloc()
      : super(UygulamaTemasi(tema: ThemeData.light(), renk: Colors.cyan));

  @override
  TemaState get initialState =>
      UygulamaTemasi(tema: ThemeData.light(), renk: Colors.cyan);
  Stream<TemaState> mapEventToState(TemaEvent event) async* {
    UygulamaTemasi? uygulamaTemasi;
    if (event is TemaDegistirEvent) {
      switch (event.havaDurumuKisaltmasi) {
        case "sn": //karlı
        case "sl": // sulu kar
        case "h": // dolu
        case "t": // fırtına
        case "hc": // çok bulutlu
          uygulamaTemasi = UygulamaTemasi(
            tema: ThemeData(primaryColor: Colors.blueGrey),
            renk: Colors.grey,
          );
          break;
        case "hr": // ağır yağmurlu
        case "lr": // hafif yağmurlu
        case "s": // sağanak yağışlı
          uygulamaTemasi = UygulamaTemasi(
            tema: ThemeData(primaryColor: Colors.indigoAccent),
            renk: Colors.indigo,
          );
          break;
        case "lc": // az bulutlu
        case "c": // açık hava

          uygulamaTemasi = UygulamaTemasi(
            tema: ThemeData(primaryColor: Colors.orangeAccent),
            renk: Colors.orange,
          );
          break;
      }
      yield uygulamaTemasi!;
    }
  }
}
