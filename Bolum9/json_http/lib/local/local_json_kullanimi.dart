import 'package:flutter/material.dart';
import 'dart:convert';

import '../models/araba.dart';
import '../models/araba_model.dart';

class LocalJsonKullanimi extends StatefulWidget {
  @override
  _LocalJsonKullanimiState createState() => _LocalJsonKullanimiState();
}

class _LocalJsonKullanimiState extends State<LocalJsonKullanimi> {
  var tumAarabalar;
  @override
  void initState() {
    super.initState();
    /**
     veriKaynaginiOku().then((value) {
      setState(() {
        tumAarabalar = value;
      });
    });
    */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child: FutureBuilder(
          future: veriKaynaginiOku(),
          builder: (context, result) {
            if (result.hasData) {
              tumAarabalar = result.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${tumAarabalar[index].arabaAdi}"),
                    subtitle: Text("${tumAarabalar[index].ulke}"),
                  );
                },
                itemCount: tumAarabalar.length,
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  AppBar appBar() => AppBar(title: Text("Josn kullanimi"));

  Future<List> veriKaynaginiOku() async {
    /**
     *  Future<String> jsonOku =
        DefaultAssetBundle.of(context).loadString("assets/data/araba.json");

    jsonOku.then((value) {
      debugPrint("$value");
      return value;
    });
     */

    var gelenJson = await DefaultAssetBundle.of(context)
        .loadString("assets/data/araba.json");

    List<Araba> arabaListesi = (json.decode(gelenJson) as List)
        .map((mapYapisi) => Araba.fromJson(mapYapisi))
        .toList();
    List<Model> modelListesi = (json.decode(gelenJson) as List)
        .map((mapYapisi) => Model.fromJson(mapYapisi))
        .toList();

    return arabaListesi;
  }
}


/**
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: tumAarabalar != null
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Text("${tumAarabalar![index]["araba_adi"]}"),
                    subtitle: Text("${tumAarabalar![index]["ulke"]}"),
                  );
                },
                itemCount: tumAarabalar!.length,
              )
            : CircularProgressIndicator(),
      ),
    );
  }
 */



/**
 * 
 Future<List> veriKaynaginiOku() async {
    /**
     *  Future<String> jsonOku =
        DefaultAssetBundle.of(context).loadString("assets/data/araba.json");

    jsonOku.then((value) {
      debugPrint("$value");
      return value;
    });
     */

    var gelenJson = await DefaultAssetBundle.of(context)
        .loadString("assets/data/araba.json");

    var arabaListesi = json.decode(gelenJson);

    return arabaListesi;
}
 */