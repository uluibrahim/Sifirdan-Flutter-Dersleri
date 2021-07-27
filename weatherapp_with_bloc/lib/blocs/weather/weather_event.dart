import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]) : super();
}

class FetchWeatherEvent extends WeatherEvent {
  final String sehirAdi;

  FetchWeatherEvent({required this.sehirAdi}) : super([sehirAdi]);

  @override
  List<Object?> get props => throw UnimplementedError();
}

class RefreshWeatherEvent extends WeatherEvent {
  final String sehirAdi;

  RefreshWeatherEvent({required this.sehirAdi}) : super([sehirAdi]);

  @override
  List<Object?> get props => throw UnimplementedError();
}
