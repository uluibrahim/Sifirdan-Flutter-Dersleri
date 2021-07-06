import 'package:flutter/material.dart';
import 'package:pokedex/models/pokedex.dart';
import 'package:palette_generator/palette_generator.dart';

class PokemonDetail extends StatefulWidget {
  PokemonDetail({required this.pokemon});

  Pokemon pokemon;

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Color? dominantColor;
  PaletteGenerator? paletteGenaratorValue;
  void baskinRenkBul() {
    Future<PaletteGenerator> paletteGenerator =
        PaletteGenerator.fromImageProvider(
            NetworkImage(widget.pokemon.img.toString()));
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
  void initState() {
    // TODO: implement initState
    super.initState();
    baskinRenkBul();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: dominantColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: dominantColor,
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return dikeyStack(context);
          } else {
            return yatayStack(context);
          }
        }),
      ),
    );
  }

  Stack dikeyStack(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: MediaQuery.of(context).size.width * 0.08,
          right: MediaQuery.of(context).size.width * 0.08,
          top: MediaQuery.of(context).size.height * 0.1,
          bottom: MediaQuery.of(context).size.height * 0.1,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(height: 73),
                Text(
                  widget.pokemon.name.toString(),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Heigth" + widget.pokemon.height.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Weigth" + widget.pokemon.weight.toString(),
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  "Types",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.pokemon.type!
                      .map((e) => Chip(label: Text(e)))
                      .toList(),
                ),
                Text(
                  "Evolution",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.pokemon.nextEvolution != null
                      ? widget.pokemon.nextEvolution!
                          .map((e) => Chip(label: Text(e.name.toString())))
                          .toList()
                      : [Text("Son Hali")],
                ),
                Text(
                  "Weakness",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: widget.pokemon.weaknesses != null
                      ? widget.pokemon.weaknesses!
                          .map((e) => Chip(label: Text(e.toString())))
                          .toList()
                      : [Text("Zayıflık yok")],
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Hero(
            tag: widget.pokemon.img.toString(),
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.pokemon.img.toString(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget yatayStack(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Hero(
              tag: widget.pokemon.img.toString(),
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    // fit: BoxFit.cover,
                    image: NetworkImage(
                      widget.pokemon.img.toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    widget.pokemon.name.toString(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Heigth" + widget.pokemon.height.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Weigth" + widget.pokemon.weight.toString(),
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "Types",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.pokemon.type!
                        .map((e) => Chip(label: Text(e)))
                        .toList(),
                  ),
                  Text(
                    "Evolution",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.pokemon.nextEvolution != null
                        ? widget.pokemon.nextEvolution!
                            .map((e) => Chip(label: Text(e.name.toString())))
                            .toList()
                        : [Text("Son Hali")],
                  ),
                  Text(
                    "Weakness",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: widget.pokemon.weaknesses != null
                        ? widget.pokemon.weaknesses!
                            .map((e) => Chip(label: Text(e.toString())))
                            .toList()
                        : [Text("Zayıflık yok")],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
