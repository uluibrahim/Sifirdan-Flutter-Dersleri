import 'package:flutter/material.dart';

class DropDownButtonKullanimi extends StatefulWidget {
  @override
  _DropDownButtonKullanimiState createState() =>
      _DropDownButtonKullanimiState();
}

class _DropDownButtonKullanimiState extends State<DropDownButtonKullanimi> {
  String _secilenSehir;

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
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DropdownButton<String>(
            hint: Text("Seciniz"),
            items: tumSehirler
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            //dropList(tumSehirler),
            value: _secilenSehir,
            onChanged: (String sehir) {
              setState(() {
                _secilenSehir = sehir;
              });
            },
          ),
        ],
      ),
    );
  }

  /**
  * Map olmadan onceki yontem

  List<DropdownMenuItem<String>> dropList(List<String> sehirler) {
    List<DropdownMenuItem<String>> dropListIc = [];
    for (var i = 0; i < sehirler.length; i++) {
      dropListIc.add(
        DropdownMenuItem(
          child: Text(sehirler[i]),
          value: sehirler[i],
        ),
      );
    }
    return dropListIc;
  }
  */

}
