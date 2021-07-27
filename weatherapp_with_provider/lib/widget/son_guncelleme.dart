import 'package:flutter/material.dart';

class SonGuncellemeWidget extends StatelessWidget {
  DateTime time;
  SonGuncellemeWidget({required this.time});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "Son Guncelleme " +
            TimeOfDay(hour: time.hour, minute: time.minute).format(context),
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
    );
  }
}
