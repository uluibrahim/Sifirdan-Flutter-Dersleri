import 'package:burc_rehberi/burc_listesi.dart';
import 'package:flutter/material.dart';

import 'models/burc.dart';

import 'package:palette_generator/palette_generator.dart';

class BurcDetay extends StatefulWidget {
  int index;
  BurcDetay(this.index);

  @override
  _BurcDetayState createState() => _BurcDetayState(index);
}

class _BurcDetayState extends State<BurcDetay> {
  int index;
  PaletteGenerator? paletteGenaratorValue;
  BurcListesi burcListe = BurcListesi();
  _BurcDetayState(this.index, {this.paletteGenaratorValue, this.burclist});
  Color? dominantColor;
  List<Burc>? tumBurclar;

  Burc? burclist;

  @override
  void initState() {
    // constructor metodundan sonra tetiklenen kısım
    super.initState();
    tumBurclar = burcListe.veriKaynaginiOku();
    //tumBurclar = BurcListesi.tumBurclar; // BurcListesi sınıfında static olarak liste tanımlandığından nesne oluşturmadan listeye ulaşılabilir.
    baskinRenkBul();
  }

  void baskinRenkBul() {
    Future<PaletteGenerator> paletteGenerator =
        PaletteGenerator.fromImageProvider(
            AssetImage("assets/images/${tumBurclar![index].burcBuyukResim}"));
    paletteGenerator.then((value) {
      paletteGenaratorValue = value;
      debugPrint("Secilen renk " +
          paletteGenaratorValue!.dominantColor!.color.toString());

      setState(() {
        dominantColor = paletteGenaratorValue!.dominantColor!.color;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: buildBody(widget.index, context, tumBurclar!)),
    );
  }

  CustomScrollView buildBody(
      int index, BuildContext context, List<Burc> tumBurclar) {
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(tumBurclar, index, context),
        buildSliverToBoxAdapter(tumBurclar, index, context),
      ],
    );
  }

  SliverToBoxAdapter buildSliverToBoxAdapter(
      List<Burc> tumBurclar, int index, BuildContext context) {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Text(
          tumBurclar[index].burcDetay,
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar(
      List<Burc> tumBurclar, int index, BuildContext context) {
    return SliverAppBar(
      backgroundColor: dominantColor != null ? dominantColor : Colors.cyan,
      centerTitle: true,
      floating: true,
      pinned: true,
      expandedHeight: 200,
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          "assets/images/${tumBurclar[index].burcBuyukResim}",
          fit: BoxFit.fill,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          tumBurclar[index].burcAdi,
          style: Theme.of(context)
              .textTheme
              .headline2!
              .copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
