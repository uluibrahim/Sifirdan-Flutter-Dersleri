import 'package:flutter/material.dart';

class AramaSayfasi extends StatefulWidget {
  AramaSayfasi(Key key) : super(key: key);

  @override
  _AramaSayfasiState createState() => _AramaSayfasiState();
}

class _AramaSayfasiState extends State<AramaSayfasi> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemExtent: 200,
      itemCount: 20,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.teal.shade300,
          padding: EdgeInsets.all(8),
          child: Material(
            child: Align(child: Text("ARAMA SAYFASI $index")),
          ),
        );
      },
    );
  }
}
