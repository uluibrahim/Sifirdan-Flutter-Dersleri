import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: Colors.teal, accentColor: Colors.orange),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Appbar"), // appbar a text basar
          //backgroundColor: Colors.orange, // appbarın arka plan rengi
          //NOT: Burada appbar rengi tanımlanırsa Theme kısmında tanımlanan primaryColor ezilmiş (override) olur
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // buton tıklanıldığında tetiklenen metot
            print("Fab tıklanıldı");
          },
          child: Icon(
            Icons.account_balance,
            color: Colors.white,
          ),
        ),
        body: Text(
          "Uygulamanın hayat bulduğu appbarın altıdır",
          style: TextStyle(
            color: Colors.red, // yazı rengi
            fontSize: 30, // yazı boyutu
            fontWeight: FontWeight.bold, // yazı kalınlığı
          ),
        ),
      ),
      title: "Base widget",
    );
  }
}
