import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokedex/models/pokedex.dart';
import 'package:pokedex/pokemon_detail.dart';

class PokemonList extends StatefulWidget {
  PokemonList({Key? key}) : super(key: key);

  @override
  _PokemonListState createState() => _PokemonListState();
}

class _PokemonListState extends State<PokemonList> {
  String url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  Pokedex? pokedex;

  Future<Pokedex>? veri;

  Future<Pokedex> veriGetir() async {
    var response = await http.get(Uri.parse(url));

    var decodedJson = jsonDecode(response.body);
    pokedex = Pokedex.fromJson(decodedJson);
    return pokedex!;
  }

  @override
  void initState() {
    super.initState();
    veri = veriGetir();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex Api'),
      ),
      body: Center(
        child: Container(
          child: OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              if (orientation == Orientation.portrait) {
                return futureBuilder(context);
              } else {
                return futureBuilder2(context);
              }
            },
          ),
        ),
      ),
    );
  }

  FutureBuilder<Pokedex> futureBuilder(BuildContext context) {
    return FutureBuilder(
      future: veri,
      builder: (context, AsyncSnapshot<Pokedex> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // veriler henüz gelmediyse çalışacak kısım
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // veri getirme işlemi tamamlandıysa
          /**
           * GRIDVIEW.BUILDER İLE
           * return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  color: Colors.orange.shade500,
                  child: Align(
                      child:
                          Text(snapshot.data!.pokemon![index].name.toString())),
                ),
              );
            },
            itemCount: snapshot.data!.pokemon!.length,
          );
           * 
           */

          return GridView.count(
            crossAxisCount: 2,
            children: snapshot.data!.pokemon!.map((gelenPoke) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Hero(
                    tag: gelenPoke.img!,
                    child: Card(
                      elevation: 5,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/gif/tenor.gif",
                        image: gelenPoke.img!,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PokemonDetail(
                              pokemon: gelenPoke,
                            )));
                  },
                ),
              );
            }).toList(),
          );
        } else {
          throw "hata alındı";
        }
      },
    );
  }

  FutureBuilder<Pokedex> futureBuilder2(BuildContext context) {
    return FutureBuilder(
      future: veri,
      builder: (context, AsyncSnapshot<Pokedex> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // veriler henüz gelmediyse çalışacak kısım
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {
          // veri getirme işlemi tamamlandıysa
          return GridView.count(
            crossAxisCount: 3,
            children: snapshot.data!.pokemon!.map((gelenPoke) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  child: Hero(
                    tag: gelenPoke.img!,
                    child: Card(
                      elevation: 5,
                      child: FadeInImage.assetNetwork(
                        placeholder: "assets/gif/tenor.gif",
                        image: gelenPoke.img!,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PokemonDetail(
                              pokemon: gelenPoke,
                            )));
                  },
                ),
              );
            }).toList(),
          );
        } else {
          throw "hata alındı";
        }
      },
    );
  }
}
