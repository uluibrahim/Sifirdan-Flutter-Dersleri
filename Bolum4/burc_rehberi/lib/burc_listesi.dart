import 'package:flutter/material.dart';
import 'utils/strings.dart';
import 'models/burc.dart';

class BurcListesi extends StatelessWidget {
  static List<Burc>? tumBurclar;
  @override
  Widget build(BuildContext context) {
    tumBurclar = veriKaynaginiOku();
    return Scaffold(
      appBar: buildAppbar(),
      body: buildBody(tumBurclar!),
    );
  }

  Widget buildBody(List<Burc> tumBurclar) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return buildCard(tumBurclar, index, context);
        },
        itemCount: tumBurclar.length,
      )),
    );
  }

  Card buildCard(List<Burc> tumBurclar, int index, BuildContext context) {
    return Card(
      elevation: 7,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(40))),
      color: Colors.cyan.shade100,
      child: buildListTile(tumBurclar, index, context),
    );
  }

  ListTile buildListTile(
      List<Burc> tumBurclar, int index, BuildContext context) {
    return ListTile(
      leading: Image.asset("assets/images/${tumBurclar[index].burcKucukResim}"),
      title: Text(tumBurclar[index].burcAdi),
      subtitle: Text(tumBurclar[index].burcTarihi),
      trailing: Icon(Icons.arrow_right),
      onTap: () {
        Navigator.pushNamed(context, "/detay/$index");
      },
    );
  }

  List<Burc> veriKaynaginiOku() {
    List<Burc> burclar = [];
    for (var i = 0; i < Strings.BURC_ADLARI.length; i++) {
      String kucukResim = Strings.BURC_ADLARI[i].toLowerCase() + "${i + 1}.png";
      String buyukResim =
          Strings.BURC_ADLARI[i].toLowerCase() + "_buyuk${i + 1}.png";

      Burc oAnkiBurc = Burc(Strings.BURC_ADLARI[i], Strings.BURC_TARIHLERI[i],
          Strings.BURC_GENEL_OZELLIKLERI[i], kucukResim, buyukResim);
      burclar.add(oAnkiBurc);
    }

    return burclar;
  }
}

AppBar buildAppbar() {
  return AppBar(
    title: Text('Burc Rehberi'),
  );
}
