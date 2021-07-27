import 'package:weatherapp_with_provider/models/weather_model.dart';

import '../locator.dart';
import 'weather_api_client.dart';

class WeatherRepository {
  WeatherApiClient weatherApiClient = locator<WeatherApiClient>();

  Future<Weather> getWeather(String sehir) async {
    final int sehirId = await weatherApiClient.getLocationId(sehir);
    return await weatherApiClient.getWeather(sehirId);
  }
}
