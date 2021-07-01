import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double? harfDegeri = 4;
  int? dersKredisi = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // klavye açıldığında ekran daralmasını önler
      appBar: appBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.deepOrange.shade100,
      child: Column(
        children: [
          Expanded(
            // STATIC FORM TUTAN CONTAİNER
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.teal.shade100,
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "Ders Adı",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value!.length < 1) {
                          return "Ders boş bırakılamaz";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {},
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: DropdownButton<int>(
                            hint: Text("Kredi 1"),
                            items: buildKrediListesi(),
                            value: dersKredisi!,
                            onChanged: (value) {
                              setState(() {
                                dersKredisi = value!;
                              });
                            },
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        Container(
                          child: DropdownButton<double>(
                            hint: Text("AA"),
                            items: buildHarfNotuListesi(),
                            value: harfDegeri,
                            onChanged: (value) {
                              setState(() {
                                harfDegeri = value;
                              });
                            },
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                          decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.indigo),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    divider(),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            // DINAMIC FORM TUTAN CONTAİNER
            child: Container(
              child: Text("ndslcknsdşkcnsdşlk"),
            ),
          ),
        ],
      ),
    );
  }

  Divider divider() {
    return Divider(
      thickness: 1.5,
      color: Colors.red,
      indent: 40,
      endIndent: 40,
    );
  }

  AppBar appBar() => AppBar(title: Text("Not Ortama Hesapla"));
}

List<DropdownMenuItem<double>> buildHarfNotuListesi() {
  List<DropdownMenuItem<double>> harfNotuListesi = [];

  harfNotuListesi.add(DropdownMenuItem(child: Text("AA"), value: 4));
  harfNotuListesi.add(DropdownMenuItem(child: Text("AB"), value: 3.5));
  harfNotuListesi.add(DropdownMenuItem(child: Text("BB"), value: 3));
  harfNotuListesi.add(DropdownMenuItem(child: Text("BC"), value: 2.5));
  harfNotuListesi.add(DropdownMenuItem(child: Text("CC"), value: 2));
  harfNotuListesi.add(DropdownMenuItem(child: Text("CD"), value: 1.5));
  harfNotuListesi.add(DropdownMenuItem(child: Text("DD"), value: 1));
  harfNotuListesi.add(DropdownMenuItem(child: Text("FF"), value: 0));

  return harfNotuListesi;
}

List<DropdownMenuItem<int>> buildKrediListesi() {
  List<DropdownMenuItem<int>> krediler = [];

  for (var i = 1; i <= 10; i++) {
    krediler.add(
      DropdownMenuItem(
        child: Text("Kredi $i"),
        value: i,
      ),
    );
  }

  return krediler;
}
