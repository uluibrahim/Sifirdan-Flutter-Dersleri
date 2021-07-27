import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weatherapp_with_provider/viewmodel/mytheme_viewmodel.dart';
import 'package:weatherapp_with_provider/viewmodel/weather_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:weatherapp_with_provider/widget/gecisli_arkaplan_rengi.dart';
import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'sehir_sec.dart';
import 'son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String _secilenSehir = "Ankara";
  WeatherViewModel? _weatherViewModel;

  @override
  Widget build(BuildContext context) {
    _weatherViewModel = Provider.of<WeatherViewModel>(context);

    return Scaffold(
      appBar: myAppbar(context),
      body: Center(
        child: (_weatherViewModel!.state == WeatherState.WeatherLoadingState)
            ? havaDurumuLoading()
            : (_weatherViewModel!.state == WeatherState.WeatherLoadedState)
                ? HavaDurumuLoaded()
                : (_weatherViewModel!.state == WeatherState.WeatherErrorState)
                    ? havaDurumuError()
                    : Text("Şehir Seçiniz"),
      ),
    );
  }

  AppBar myAppbar(BuildContext context) {
    return AppBar(
      title: Text("Weather App"),
      actions: [
        IconButton(
          onPressed: () => _searcButtonOnpressed(context),
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  void _searcButtonOnpressed(BuildContext context) async {
    _secilenSehir = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SehirSec()));
    if (_secilenSehir != null) {
      _weatherViewModel!.havaDurumunuGetir(_secilenSehir);
    }
  }

  Widget havaDurumuError() {
    return Text("Şehir Bulunamadı...");
  }

  Widget havaDurumuLoading() {
    return CircularProgressIndicator();
  }
}

class HavaDurumuLoaded extends StatefulWidget {
  HavaDurumuLoaded({Key? key}) : super(key: key);

  @override
  _HavaDurumuLoadedState createState() => _HavaDurumuLoadedState();
}

class _HavaDurumuLoadedState extends State<HavaDurumuLoaded> {
  WeatherViewModel? _weatherViewModel;
  MyThemeViewModel? _myThemeViewModel;
  Completer<void>? _refreshIndicator;
  @override
  void initState() {
    super.initState();
    _refreshIndicator = Completer<void>();
    // build metodundan hemen sonra çalışacak metot binding
    WidgetsBinding.instance!.addPostFrameCallback(
      (_) {
        String kisaltma = Provider.of<WeatherViewModel>(context, listen: false)
            .havaDurumuKisaltmasi();
        debugPrint("kisaltma kodu:" + kisaltma);
        Provider.of<MyThemeViewModel>(context, listen: false)
            .temaDegistir(kisaltma);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Hazırlandıııııııııııı");
    _refreshIndicator!.complete();
    _refreshIndicator = Completer<void>();

    _myThemeViewModel = Provider.of<MyThemeViewModel>(context);
    _weatherViewModel = Provider.of<WeatherViewModel>(context);
    String kullanicininSectigiSehir =
        _weatherViewModel!.getirilenWeather.title.toString();

    return GecisliRenkContainer(
      color: _myThemeViewModel!.myTheme.renk,
      child: RefreshIndicator(
        onRefresh: () {
          _weatherViewModel!.havaDurumunuGuncelle(kullanicininSectigiSehir);
          return _refreshIndicator!.future;
        },
        child: ListView(
          children: [
            Column(
              children: [
                LocationWidget(secilenSehir: kullanicininSectigiSehir),
                SonGuncellemeWidget(
                  time: _weatherViewModel!.getirilenWeather.time!.toLocal(),
                ),
                HavaDurumuResim(
                  weatherDurum: _weatherViewModel!.getirilenWeather
                      .consolidatedWeather![0].weatherStateAbbr,
                  theTemp: _weatherViewModel!
                      .getirilenWeather.consolidatedWeather![0].theTemp,
                ),
                MaxAndMinSicaklik(
                  min: _weatherViewModel!
                      .getirilenWeather.consolidatedWeather![0].minTemp,
                  max: _weatherViewModel!
                      .getirilenWeather.consolidatedWeather![0].maxTemp,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
