import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp_with_bloc/models/weather_model.dart';

@immutable
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class InitialWeatherState extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLoaded extends WeatherState {
  final Weather weather;
  WeatherLoaded({required this.weather});
  @override
  List<Object?> get props => [weather];
}

class WeatherErrorState extends WeatherState {
  @override
  List<Object?> get props => throw UnimplementedError();
}
