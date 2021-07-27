import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/tema/bloc.dart';
import 'package:weatherapp_with_bloc/blocs/tema/tema_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/weather/bloc.dart';
import 'package:weatherapp_with_bloc/models/weather_model.dart';

import 'gecisli_arkaplan_rengi.dart';
import 'hava_durumu_resim.dart';
import 'location.dart';
import 'max_min_sicaklik.dart';
import 'sehir_sec.dart';
import 'son_guncelleme.dart';

class WeatherApp extends StatelessWidget {
  String _secilenSehir = "Ankara";
  Completer<void> _refreshCompleter = Completer<void>();
  @override
  Widget build(BuildContext context) {
    final _weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return Scaffold(
      appBar: myAppbar(context, _weatherBloc),
      body: BlocBuilder(
        bloc: _weatherBloc,
        builder: (BuildContext context, state) {
          if (state is InitialWeatherState) {
            return Center(
              child: Text("Şehir Seçiniz"),
            );
          }
          if (state is WeatherLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WeatherLoaded) {
            final getirilenWeather = state.weather;
            final _havaDurumuKisaltmasi =
                getirilenWeather.consolidatedWeather[0].weatherStateAbbr;
            final _temaBloc = BlocProvider.of<TemaBloc>(context);
            _temaBloc.add(
                TemaDegistirEvent(havaDurumuKisaltmasi: _havaDurumuKisaltmasi));
            _refreshCompleter.complete();
            _refreshCompleter = Completer();

            return BlocBuilder(
              bloc: _temaBloc,
              builder: (BuildContext context, TemaState state) {
                return GecisliRenkContainer(
                  color: (state as UygulamaTemasi).renk,
                  child: RefreshIndicator(
                    onRefresh: () {
                      _weatherBloc.add(RefreshWeatherEvent(
                          sehirAdi: getirilenWeather.title));
                      return _refreshCompleter.future;
                    },
                    child: Center(
                      child: ListView(
                        children: [
                          Column(children: [
                            LocationWidget(
                                secilenSehir: getirilenWeather.title),
                            SonGuncellemeWidget(
                                getirilenWeather.time.toLocal()),
                            HavaDurumuResim(
                              weatherDurum: getirilenWeather
                                  .consolidatedWeather[0].weatherStateAbbr,
                              theTemp: getirilenWeather
                                  .consolidatedWeather[0].theTemp,
                            ),
                            MaxAndMinSicaklik(
                              min: getirilenWeather
                                  .consolidatedWeather[0].minTemp,
                              max: getirilenWeather
                                  .consolidatedWeather[0].maxTemp,
                            ),
                          ])
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          if (state is WeatherErrorState) {
            return Center(child: Text("HATA"));
          }
          return Text("Hata");
        },
      ),
    );
  }

  AppBar myAppbar(BuildContext context, WeatherBloc _weatherBloc) {
    return AppBar(
      title: Text("Weather App"),
      actions: [
        IconButton(
          onPressed: () => _searcButtonOnpressed(context, _weatherBloc),
          icon: Icon(Icons.search),
        ),
      ],
    );
  }

  void _searcButtonOnpressed(
      BuildContext context, WeatherBloc _weatherBloc) async {
    _secilenSehir = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => SehirSec()));
    if (_secilenSehir != null) {
      _weatherBloc.add(FetchWeatherEvent(sehirAdi: _secilenSehir));
    }
    print("secilen sehir: $_secilenSehir");
  }
}
