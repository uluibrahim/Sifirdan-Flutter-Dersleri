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
        body: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            height: 200,
            width: 200,
            color: Colors.red,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              color: Colors.blue,
              height: 50,
              width: 50,
              child: Text("Emre"),
            ),
          ),
        ),

        /**
         * BODY
         * body: Container(
          // container parent'ında bir kutu oluşturur
          // container default olarak çocuğu kadar yer kaplar

          color: Colors.cyan,
          
          //    width: 300,
          //    height: 300,
          
          // container içinde aligment kullanılır ve width heigth değerleri yok ise parentı kadar alanı kaplar
          alignment: Alignment.center,
          child: Text("BODY CONTAINER"),
          //  container boyutlarının sınırlandırılması => constraints
          constraints: BoxConstraints(
              maxHeight: 200, maxWidth: 200, minHeight: 100, minWidth: 100),),
         * 
         */
      ),
      title: "Base widget",
    );
  }
}
