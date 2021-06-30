import 'package:flutter/material.dart';

class FormElemanlari extends StatefulWidget {
  @override
  _FormElemanlariState createState() => _FormElemanlariState();
}

class _FormElemanlariState extends State<FormElemanlari> {
  bool _secim = false;
  String _valueGroup = "Sehir";
  bool _secimSwitch = false;
  double _sliderValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: [
            CheckboxListTile(
              value: _secim,
              onChanged: (value) {
                setState(() {
                  _secim = value;
                });
              },
              title: Text("Seç"),
            ),
            RadioListTile(
              value: "Ankrara",
              groupValue: _valueGroup,
              onChanged: (value) {
                setState(() {
                  print("Seçilen şehir: $value");
                  _valueGroup = value;
                });
              },
              title: Text("Ankara"),
            ),
            RadioListTile(
              value: "Şanlıurfa",
              groupValue: _valueGroup,
              onChanged: (value) {
                setState(() {
                  print("Seçilen şehir: $value");
                  _valueGroup = value;
                });
              },
              title: Text("Şanlıurfa"),
            ),
            RadioListTile(
              value: "Denizli",
              groupValue: _valueGroup,
              onChanged: (value) {
                setState(() {
                  print("Seçilen şehir: $value");
                  _valueGroup = value;
                });
              },
              title: Text("Denizli"),
            ),
            SwitchListTile(
              value: _secimSwitch,
              onChanged: (value) {
                setState(() {
                  _secimSwitch = value;
                });
              },
              title: Text("Switch "),
              // activeThumbImage: NetworkImage("https://picsum.photos/200/300"),
              activeColor: Colors.red,
              activeTrackColor: Colors.blue,
            ),
            Slider(
              value: _sliderValue,
              label: '$_sliderValue',
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
              max: 10,
              min: 1,
              divisions: 9,
            ),
          ],
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(title: Text("Form Elemanları"));
}
