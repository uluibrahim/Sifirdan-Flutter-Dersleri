import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:moda_app/view/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Moda App',
      home: HomePage(),
    );
  }
}
