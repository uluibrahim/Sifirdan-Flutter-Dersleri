import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:weatherapp_with_provider/models/weather_model.dart';

class WeatherApiClient {
  static const baseUrl = "https://www.metaweather.com";
  final http.Client httpClient = http.Client();

  Future<int> getLocationId(String sehirAdi) async {
    final sehirURL = "$baseUrl/api/location/search/?query=$sehirAdi";
    final gelenCevap = await httpClient.get(Uri.parse(sehirURL));
    if (gelenCevap.statusCode != 200) {
      // istek atılmış fakat başarılı olunamamış
      throw Exception("Veri gettirilemedi");
    }
    final gelenCevapJson = jsonDecode(gelenCevap.body) as List;
    return gelenCevapJson[0]
        ["woeid"]; // burada secilen sehrin sehir kodunu almış olduk
  }

  Future<Weather> getWeather(int sehirId) async {
    final havaDurumuURL = "$baseUrl/api/location/$sehirId";

    final havaDurumuGelenCevap = await httpClient.get(Uri.parse(havaDurumuURL));
    if (havaDurumuGelenCevap.statusCode != 200) {
      throw Exception("Hava durumu getirilemedi");
    }
    final havaDurumuJson = jsonDecode(havaDurumuGelenCevap.body);
    return Weather.fromJson(havaDurumuJson);
  }
}
