import 'package:flutter/material.dart';
import 'package:tasarimi_kolaylastiran_yapilar/model/data.dart';

class AnaSafya extends StatefulWidget {
  AnaSafya(Key key) : super(key: key);

  @override
  _AnaSafyaState createState() => _AnaSafyaState();
}

class _AnaSafyaState extends State<AnaSafya> {
  List<Veri>? veriListesi;

  @override
  void initState() {
    super.initState();
    veriListesi = [
      Veri(baslik: "Hakkımızda", icerik: "hakkımızada ....", expanded: false),
      Veri(baslik: "Blog", icerik: "Blog ....", expanded: false),
      Veri(baslik: "İletişim", icerik: "İletişim ....", expanded: false),
      Veri(baslik: "Referanslar", icerik: "Referanslar ....", expanded: false),
      Veri(baslik: "Projeler", icerik: "Projeler .....", expanded: false),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: veriListesi!.length,
      itemBuilder: (context, index) {
        return ExpansionTile(
          key: PageStorageKey("$index"),
          title: Text(veriListesi![index].baslik),
          initiallyExpanded: veriListesi![index].expanded,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: Material(
                child: Text(veriListesi![index].icerik),
              ),
            ),
          ],
        );
      },
    );
  }
}
