import 'package:weatherapp_with_provider/viewmodel/weather_viewmodel.dart';

import 'data/weather_api_client.dart';
import 'data/weather_repostory.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  // lazy ilk defa kullanılmak istendiğinde nesnenin üretilmesini sağlar
  // lazy olmadan kullanımda ise program çalıştırıldığı anda nesne üretilir
  locator.registerLazySingleton(() => WeatherRepository());
  locator.registerLazySingleton(() => WeatherApiClient());
  // her çağırılmada yeni nesne üretilmesi
  locator.registerFactory(() => WeatherViewModel());
}
