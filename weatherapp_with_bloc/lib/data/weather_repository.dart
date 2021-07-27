import 'package:weatherapp_with_bloc/data/weather_api_client.dart';
import 'package:weatherapp_with_bloc/locator.dart';
import 'package:weatherapp_with_bloc/models/weather_model.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<Weather> getWeather(String sehir) async {
    final int sehirId = await weatherApiClient.getLocationId(sehir);
    return await weatherApiClient.getWeather(sehirId);
  }
}
