import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String _imgUrl = "https://picsum.photos/200/300";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        body: odev(),

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

Widget buildCenter(String imgUrl) {
  return Center(
    child: Container(
      child: FlutterLogo(
        // style: FlutterLogoStyle.horizontal,
        size: 200,
      ),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        // color: Colors.teal,
        shape: BoxShape.rectangle,
        border: Border.all(
          width: 4,
          color: Colors.red,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
          repeat: ImageRepeat.repeat,
        ),
      ),
    ),
  );
}

Widget buildRowAndColumn() {
  return Container(
    color: Colors.red.shade200,
    child: buildColumn(),
  );
}

Widget buildRow() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center, // x ekseninde işlem yapar
    crossAxisAlignment: CrossAxisAlignment.center, // y ekseninde işlem yapar
    children: [
      Icon(
        Icons.account_box,
        size: 50,
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
    ],
  );
}

Widget buildColumn() {
  return Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround, // y ekseninde işlem yapar
    crossAxisAlignment: CrossAxisAlignment.stretch, // x ekseninde işlem yapar
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("H"),
          Text("A"),
          Text("L"),
          Text("İ"),
          Text("L"),
        ],
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
      Icon(
        Icons.account_box,
        size: 50,
      ),
    ],
  );
}

Widget buildRowForExpandedAndFlexible() {
  return Row(
    children: flexibleContainerListesi,
  );
}

List<Widget> get expandedContainerListesi {
  return [
    Expanded(
      flex: 2,
      child: Container(
        height: 100,
        color: Colors.red,
      ),
    ),
    Expanded(
      flex: 1,
      child: Container(
        height: 100,
        color: Colors.blue,
      ),
    ),
    Expanded(
      flex: 3,
      child: Container(
        height: 100,
        color: Colors.orange,
      ),
    ),
    Expanded(
      flex: 2,
      child: Container(
        height: 100,
        color: Colors.teal,
      ),
    ),
  ];
}

List<Widget> get flexibleContainerListesi {
  return [
    Flexible(
      flex: 2,
      child: Container(
        constraints: BoxConstraints(maxWidth: 100),
        height: 100,
        color: Colors.red,
      ),
    ),
    Flexible(
      flex: 2,
      child: Container(
        constraints: BoxConstraints(maxWidth: 150),
        height: 100,
        color: Colors.blue,
      ),
    ),
  ];
}

Widget odev() {
  return Container(
    padding: EdgeInsets.all(5),
    child: Column(
      //mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        rowForOdev(),
        SizedBox(height: 5,),
        Expanded(
          child: columnForOdev(),
        ),
      ],
    ),
  );
}

Widget rowForOdev() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          child: Text(
            "D",
            style: TextStyle(fontSize: 30),
          ),
          color: Colors.orange.shade100,
        ),
      ),
      Flexible(
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          child: Text("A", style: TextStyle(fontSize: 30)),
          color: Colors.orange.shade200,
        ),
      ),
      Flexible(
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          child: Text("R", style: TextStyle(fontSize: 30)),
          color: Colors.orange.shade300,
        ),
      ),
      Flexible(
        child: Container(
          alignment: Alignment.center,
          height: 60,
          width: 60,
          child: Text("T", style: TextStyle(fontSize: 30)),
          color: Colors.orange.shade400,
        ),
      ),
    ],
  );
}

Widget columnForOdev() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("E", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade200,
      ),
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("R", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade300,
      ),
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("S", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade400,
      ),
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("L", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade500,
      ),
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("E", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade600,
      ),
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("R", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade700,
      ),
      Container(
        alignment: Alignment.center,
        height: 60,
        width: 60,
        child: Text("İ", style: TextStyle(fontSize: 30)),
        color: Colors.orange.shade800,
      ),
    ],
  );
}
