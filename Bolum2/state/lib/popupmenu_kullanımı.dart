import 'package:flutter/material.dart';

class PopUpMenuKullanimi extends StatefulWidget {
  @override
  _PopUpMenuKullanimiState createState() => _PopUpMenuKullanimiState();
}

class _PopUpMenuKullanimiState extends State<PopUpMenuKullanimi> {
  @override
  Widget build(BuildContext context) {
    List<String> tumSehirler = [
      "Ankara",
      "Şanlıurfa",
      "İstabul",
      "Denizli",
      "Aydın",
      "Antalya"
    ];
    String _secilenSehir;
    return Center(
      child: PopupMenuButton<String>(
        itemBuilder: (BuildContext context) {
          return tumSehirler
              .map(
                (e) => PopupMenuItem(
                  child: Text(e),
                  value: e,
                ),
              )
              .toList();
        },
        onSelected: (String sehir) {
          print(sehir);
          _secilenSehir = sehir;
        },
        icon: Icon(Icons.location_city),
      ),
    );
  }
}
