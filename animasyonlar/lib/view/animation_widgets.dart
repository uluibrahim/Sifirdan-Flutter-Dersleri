import 'package:flutter/material.dart';

class AnimationWidgets extends StatefulWidget {
  AnimationWidgets({Key? key}) : super(key: key);

  @override
  _AnimationWidgetsState createState() => _AnimationWidgetsState();
}

class _AnimationWidgetsState extends State<AnimationWidgets> {
  Color _color = Colors.indigo;
  double _width = 100;
  double _height = 100;
  double _opacity = 0.3;

  bool _firstChildAktive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(seconds: 1),
                height: _height,
                width: _width,
                color: _color,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.orange),
                onPressed: () {
                  _animatedContainerAnimasyonu();
                },
                child: Text("Animated Container"),
              ),
              AnimatedCrossFade(
                firstChild:
                    Image.network("https://picsum.photos/200/300?grayscale"),
                secondChild: Image.network("https://picsum.photos/200"),
                crossFadeState: _firstChildAktive == true
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                duration: Duration(seconds: 2),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.cyan),
                onPressed: () {
                  _animatedCrossFade();
                },
                child: Text("Animated Cross fade"),
              ),
              GestureDetector(
                onTap: () => _animatedOpacity(),
                child: AnimatedOpacity(
                  opacity: _opacity,
                  duration: Duration(seconds: 1),
                  child: FlutterLogo(
                    size: 100,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.indigo),
                onPressed: () {
                  _animatedOpacity();
                },
                child: Text("Opacity"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _animatedContainerAnimasyonu() {
    setState(() {
      _color = _color == Colors.yellow ? Colors.indigo : Colors.yellow;

      _width = _width == 200 ? 100 : 200;
      _height = _height == 200 ? 100 : 200;
    });
  }

  _animatedCrossFade() {
    setState(() {
      _firstChildAktive = _firstChildAktive == true ? false : true;
    });
  }

  void _animatedOpacity() {
    setState(() {
      _opacity = _opacity == 0.3 ? 1.0 : 0.3;
    });
  }
}
