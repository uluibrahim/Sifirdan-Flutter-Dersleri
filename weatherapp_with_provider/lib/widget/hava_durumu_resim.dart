import 'package:flutter/material.dart';

class HavaDurumuResim extends StatelessWidget {
  String weatherDurum;
  double theTemp;

  HavaDurumuResim({required this.weatherDurum, required this.theTemp});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.all(30),
          color: Colors.transparent,
          height: 200,
          width: 200,
          child: Image.network(
            "https://www.metaweather.com/static/img/weather/png/$weatherDurum.png",
            fit: BoxFit.cover,
          ),
        ),
        Text(
          theTemp.floor().toString() + " °C",
          style: TextStyle(fontSize: 35),
        )
      ],
    );
  }
}
