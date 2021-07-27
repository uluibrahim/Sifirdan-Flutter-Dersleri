import 'package:flutter/material.dart';
import 'package:weatherapp_with_provider/data/weather_repostory.dart';
import 'package:weatherapp_with_provider/models/weather_model.dart';

import '../locator.dart';

enum WeatherState {
  InitialWeatherState,
  WeatherLoadingState,
  WeatherLoadedState,
  WeatherErrorState
}

class WeatherViewModel with ChangeNotifier {
  WeatherState? _state;
  WeatherRepository _repository = locator<WeatherRepository>();
  Weather? _getirilenWeather;
  WeatherViewModel() {
    _getirilenWeather = Weather();
    // uygulama ilk açıldığında aşağıda belirtilen state ile başlayacak
    _state = WeatherState.InitialWeatherState;
  }

  WeatherState get state => _state!;
  Weather get getirilenWeather => _getirilenWeather!;

  set state(WeatherState state) {
    _state = state;
    notifyListeners();
  }

  Future<Weather> havaDurumunuGetir(String sehirAdi) async {
    try {
      state = WeatherState.WeatherLoadingState;
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state = WeatherState.WeatherLoadedState;
      return _getirilenWeather!;
    } catch (e) {
      state = WeatherState.WeatherErrorState;
    }
    return Weather();
  }

  Future<Weather> havaDurumunuGuncelle(String sehirAdi) async {
    try {
      _getirilenWeather = await _repository.getWeather(sehirAdi);
      state = WeatherState.WeatherLoadedState;
      return _getirilenWeather!;
    } catch (e) {}
    return Weather();
  }

  String havaDurumuKisaltmasi() {
    return _getirilenWeather!.consolidatedWeather![0].weatherStateAbbr;
  }
}
