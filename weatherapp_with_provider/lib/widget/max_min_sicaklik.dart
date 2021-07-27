import 'package:flutter/material.dart';

class MaxAndMinSicaklik extends StatelessWidget {
  double min;
  double max;
  MaxAndMinSicaklik({required this.min, required this.max});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(child: Text("Max " + max.toStringAsFixed(2) + "°C")),
        Flexible(child: Text("Min " + min.toStringAsFixed(2) + "°C")),
      ],
    );
  }
}
