import 'package:flutter/material.dart';

class TransformWidget extends StatefulWidget {
  TransformWidget({Key? key}) : super(key: key);

  @override
  _TransformWidgetState createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> {
  double _sliderValue = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [getSlider(), getRotate(), getScale(), getTranslate()],
        ),
      ),
    );
  }

  getSlider() {
    return Slider(
        value: _sliderValue,
        max: 100,
        onChanged: (newValue) {
          setState(() {
            _sliderValue = newValue;
          });
        });
  }

  getRotate() {
    return Container(
      child: Transform.rotate(
        angle: _sliderValue,
        origin: Offset(_sliderValue, -1),
        child: Container(
          height: 80,
          width: 80,
          color: Colors.indigo,
        ),
      ),
    );
  }

  getScale() {
    return Container(
      child: Transform.scale(
        scale: _sliderValue == 0
            ? 0.5
            : (_sliderValue < 0.5 ? _sliderValue * 2 : _sliderValue / 50),
        child: Container(
          height: 80,
          width: 80,
          color: Colors.orange,
        ),
      ),
    );
  }

  getTranslate() {
    return Container(
      child: Transform.translate(
        offset: Offset(_sliderValue, _sliderValue),
        child: Container(
          height: 80,
          width: 80,
          color: Colors.indigo,
        ),
      ),
    );
  }
}
