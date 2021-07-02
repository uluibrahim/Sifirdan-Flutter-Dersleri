import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Ubuntu"),
      title: 'Tasarım',
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Tasarımı kolaylaştıran yapılar',
            style: TextStyle(fontFamily: "Dancing", fontSize: 25),
          ),
        ),
        body: Center(
          child: Container(
            child: Column(
              children: [
                Text(
                  'Hello World',
                  style: TextStyle(
                    fontFamily: "Ubuntu",
                    fontSize: 35,
                  ),
                ),
                Text(
                  'Hello World',
                  style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'Hello World',
                  style: TextStyle(
                      fontFamily: "Dancing",
                      fontSize: 35,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  'theme da tanımlanan tip ',
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
