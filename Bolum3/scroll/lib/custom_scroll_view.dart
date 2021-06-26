import 'package:flutter/material.dart';

class CustomScrollViewKullanimi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          leading: Icon(
            Icons.real_estate_agent_rounded,
            size: 35,
          ),
          backgroundColor: Colors.red,
          title: Text(
            "Sliver App Bar",
            style: TextStyle(fontSize: 35),
          ),
          expandedHeight: 200,
          floating: true,
          pinned: true,
          flexibleSpace: Image.network(
            "https://picsum.photos/seed/picsum/200/300",
            fit: BoxFit.cover,
          ),
        ),
        SliverList(delegate: SliverChildListDelegate(sliverListesi))
      ],
    );
  }

  List<Widget> get sliverListesi => [
        Container(
          alignment: Alignment.center,
          height: 150,
          color: Colors.cyan,
          child: Text(
            "Sliver liste eleamanı",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 150,
          color: Colors.blueGrey,
          child: Text(
            "Sliver liste eleamanı",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 150,
          color: Colors.brown,
          child: Text(
            "Sliver liste eleamanı",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 150,
          color: Colors.teal,
          child: Text(
            "Sliver liste eleamanı",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 150,
          color: Colors.orange,
          child: Text(
            "Sliver liste eleamanı",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
      ];
}
