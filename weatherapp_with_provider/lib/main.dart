import 'package:flutter/material.dart';
import 'package:weatherapp_with_provider/locator.dart';
import 'package:weatherapp_with_provider/viewmodel/mytheme_viewmodel.dart';
import 'viewmodel/weather_viewmodel.dart';
import 'widget/weather_app.dart';
import 'package:provider/provider.dart';

void main() {
  setupLocator();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MyThemeViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MyThemeViewModel>(
      builder: (context, myThemeViewModel, child) => MaterialApp(
        title: 'Weather App',
        debugShowCheckedModeBanner: false,
        theme: myThemeViewModel.myTheme.tema,
        home: ChangeNotifierProvider<WeatherViewModel>(
            create: (context) => locator<WeatherViewModel>(),
            child: WeatherApp()),
      ),
    );
  }
}
