import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tasarımı kolaylaştıran yapılar',
            style: TextStyle(fontFamily: "Dancing", fontSize: 25),
          ),
        ),
        body: Center(
          child: Container(
            child: Text(
              'Hello World',
              style: TextStyle(fontFamily: "Dancing", fontSize: 35),
            ),
          ),
        ),
      ),
    );
  }
}
