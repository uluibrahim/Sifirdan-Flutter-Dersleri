import 'package:flutter/material.dart';

class GecisliRenkContainer extends StatelessWidget {
  final Widget child;
  final MaterialColor color;

  GecisliRenkContainer({required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.shade200, color.shade700],
          stops: [0, 0.85],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}
