import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Appbar"), // appbar a text basar
          backgroundColor: Colors.orange, // appbarın arka plan rengi
        ),
      ),
      title: "Base widget",
    );
  }
}
