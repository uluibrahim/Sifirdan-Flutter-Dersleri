import 'package:flutter/material.dart';

class HeroAnimation extends StatefulWidget {
  String tag;
  HeroAnimation(this.tag);

  @override
  _HeroAnimationState createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        height: 200,
        width: 200,
        child: Hero(
          tag: widget.tag,
          child: FlutterLogo(
            style: FlutterLogoStyle.stacked,
            textColor: Colors.indigo,
          ),
        ),
      ),
    ));
  }
}
