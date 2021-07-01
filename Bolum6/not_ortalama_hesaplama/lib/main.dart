import 'dart:math';

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
  String? dersAdi;
  double? _ortalama = 0;
  static int sayac = 0;

  late List<Ders> tumDersler;

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    tumDersler = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: floatingActionButton(),
      resizeToAvoidBottomInset:
          false, // klavye açıldığında ekran daralmasını önler
      appBar: appBar(),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return buildBody(orientation);
          } else {
            return buildBodyLandsape(orientation);
          }
        },
      ),
    );
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
        }
      },
    );
  }

  Widget buildBody(orientation) {
    return Container(
      //color: Colors.deepOrange.shade100,
      child: Column(
        children: [
          Expanded(
            flex: 40,
            // STATIC FORM TUTAN CONTAİNER
            child: staticContainer(),
          ),
          Expanded(
            flex: 70,
            // DINAMIC FORM TUTAN CONTAİNER
            child: dinamikContainerVeListeler(orientation),
          ),
        ],
      ),
    );
  }

  Container staticContainer() {
    return Container(
      padding: EdgeInsets.all(10),
      //color: Colors.teal.shade100,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
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
                onSaved: (value) {
                  dersAdi = value;
                  setState(() {
                    tumDersler.add(
                      Ders(
                        ad: dersAdi!,
                        kredi: dersKredisi!,
                        harfdegeri: harfDegeri!,
                      ),
                    );
                    _ortalama = 0;
                    _ortalama = ortalamaHesapla();
                  });
                },
              ),
            ),
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: DropdownButtonHideUnderline(
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
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.indigo),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
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
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.indigo),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: 70,
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(),
                    top: BorderSide(),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black),
                      children: [
                        TextSpan(
                          text: tumDersler.length == 0
                              ? "Ders ekleyiniz"
                              : "Ortalama:   ",
                          style: TextStyle(color: Colors.black, fontSize: 25),
                        ),
                        TextSpan(
                          text: tumDersler.length == 0
                              ? ""
                              : "${_ortalama!.toStringAsFixed(2)}",
                          style: TextStyle(
                            color: _ortalama! < 2 ? Colors.red : Colors.green,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBodyLandsape(orientation) {
    return Container(
      child: Row(
        children: [
          Expanded(child: staticContainer()),
          Expanded(child: dinamikContainerVeListeler(orientation)),
        ],
      ),
    );
  }

  Container dinamikContainerVeListeler(orientation) {
    double radius = orientation == Orientation.portrait ? 40 : 0;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(radius),
          topRight: Radius.circular(radius),
        ),
        color: Colors.indigoAccent.shade100,
      ),
      child: ListView.builder(
        reverse: true,
        itemBuilder: _listeElemanlariniOlustur,
        itemCount: tumDersler.length,
      ),
    );
  }

  double ortalamaHesapla() {
    double avg = 0;
    int krediler = 0;
    double harfler = 0;
    double toplamNot = 0;

    for (var i = 0; i < tumDersler.length; i++) {
      krediler += tumDersler[i].kredi;
      harfler += tumDersler[i].harfdegeri;
      toplamNot += (tumDersler[i].kredi.toDouble() * tumDersler[i].harfdegeri);
    }
    avg = toplamNot / krediler.toDouble();
    return avg;
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    Color randomColor = _randomColor();
    Color newColor = renkAtama(tumDersler[index].harfdegeri);
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, left: 22, right: 22),
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        key: Key("$sayac"),
        onDismissed: (value) {
          setState(() {
            tumDersler.removeAt(index);
            _ortalama = ortalamaHesapla();
          });
        },
        child: Card(
          child: ListTile(
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: newColor, width: 4),
            ),
            trailing: Icon(Icons.arrow_right_outlined),
            title: Text(tumDersler[index].ad),
            subtitle: Text(
              "Harf notu degeri: " +
                  tumDersler[index].harfdegeri.toString() +
                  "\nKredi: " +
                  tumDersler[index].kredi.toString(),
              style: TextStyle(fontSize: 15),
            ),
            leading: Icon(
              Icons.done,
              color: randomColor,
            ),
          ),
        ),
      ),
    );
  }
}

Color _randomColor() {
  return Color.fromARGB(180 + Random().nextInt(75), Random().nextInt(255),
      Random().nextInt(255), Random().nextInt(255));
}

Color renkAtama(double not) {
  Color color;
  if (not >= 3) {
    color = Colors.green;
  } else if (not < 3 && not >= 2) {
    color = Colors.orange;
  } else {
    color = Colors.red;
  }
  print(color.toString());
  return color;
}

AppBar appBar() => AppBar(title: Text("Not Ortama Hesapla"));

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

class Ders {
  String ad;
  int kredi;
  double harfdegeri;
  Ders({required this.ad, required this.kredi, required this.harfdegeri});
}
