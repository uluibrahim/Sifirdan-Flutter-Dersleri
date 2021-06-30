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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Container(
      color: Colors.grey,
      child: Column(
        children: [
          Expanded(
            // STATIC FORM TUTAN CONTAİNER
            child: Container(
              padding: EdgeInsets.all(10),
              color: Colors.white10,
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                        decoration: InputDecoration(
                          hintText: "Ders Adı",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.length < 1) {
                            return "Ders boş bırakılamaz";
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {}),
                    Expanded(
                      child: Row(children: []),
                    ),
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

  AppBar appBar() => AppBar(title: Text("Not Ortama Hesapla"));
}
