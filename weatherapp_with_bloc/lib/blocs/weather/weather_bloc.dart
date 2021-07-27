import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:weatherapp_with_bloc/data/weather_repository.dart';
import 'package:weatherapp_with_bloc/locator.dart';
import 'package:weatherapp_with_bloc/models/weather_model.dart';
import 'bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(InitialWeatherState());
  final WeatherRepository weatherRepository = locator<WeatherRepository>();

  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherEvent) {
      // fetch veri getiriliyor ise
      yield WeatherLoadingState();
      try {
        final Weather getirilenWeather =
            await weatherRepository.getWeather(event.sehirAdi);
        //hava durumu getirme"
        yield WeatherLoaded(weather: getirilenWeather);
      } catch (_) {
        yield WeatherErrorState();
        print("Hata");
      }
    } else if (event is RefreshWeatherEvent) {
      try {
        final Weather getirilenWeather =
            await weatherRepository.getWeather(event.sehirAdi);
        yield WeatherLoaded(weather: getirilenWeather);
      } catch (_) {}
    }
  }
}
