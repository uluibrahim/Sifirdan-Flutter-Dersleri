import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp_with_bloc/blocs/tema/bloc.dart';
import 'package:weatherapp_with_bloc/locator.dart';
import 'blocs/weather/bloc.dart';

import 'widget/weather_app.dart';

void main() {
  setupLocator();
  runApp(
    BlocProvider<TemaBloc>(create: (context) => TemaBloc(), child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<TemaBloc>(context),
      builder: (BuildContext context, TemaState state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Weather',
          theme: (state as UygulamaTemasi).tema,
          home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(),
            child: WeatherApp(),
          ),
        );
      },
    );
  }
}
