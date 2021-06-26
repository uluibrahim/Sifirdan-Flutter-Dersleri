import 'dart:math';

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

        //sabit elemanlarla bir satırda kaç eleman olacağını söylediğimiz grid türü
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildListDelegate(sabitListeElemanlari()),
        ),

        //dinamik (builder ile üretilen) elemanlarla bir satırda kaç eleman olacağını söylediğimiz grid türü
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          delegate: SliverChildBuilderDelegate(_dinamikElemanUretenFonksiyon,
              childCount: 6),
        ),

        //dinamik (builder ile üretilen) elemanlarla bir satırdaki bir elemanın max genişliğini söylediğimiz grid türü
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 200),
          delegate: SliverChildBuilderDelegate(_dinamikElemanUretenFonksiyon,
              childCount: 6),
        ),

        SliverGrid.count(
          crossAxisCount: 6,
          children: sabitListeElemanlari(),
        ),

        SliverGrid.extent(
          maxCrossAxisExtent: 300,
          children: sabitListeElemanlari(),
        ),

        //statik elemanlı bir sliver list view
        SliverPadding(
          padding: EdgeInsets.all(4),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              sabitListeElemanlari(),
            ),
          ),
        ),

        //elemanları builder ile olusturulan list view
        SliverPadding(
          padding: EdgeInsets.all(10),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(_dinamikElemanUretenFonksiyon,
                childCount: 6),
          ),
        ),

        //elemanları statik olusturulan ama extent mantıgıyla calısan listview
        SliverFixedExtentList(
            delegate: SliverChildListDelegate(sabitListeElemanlari()),
            itemExtent: 100),

        //elemanları dinamik olusturulan ama extent mantıgıyla calısan listview
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(_dinamikElemanUretenFonksiyon,
              childCount: 6),
          itemExtent: 50,
        ),
      ],
    );
  }

//listeler için tanımlanmış elemanları döndüren fonksiyon
  List<Widget> sabitListeElemanlari() {
    return [
      Container(
        height: 100,
        color: Colors.amber,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elemanı 1",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.teal,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elemanı 2",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.blue,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elemanı 3",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.orange,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elemanı 4",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.purple,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elemanı 5",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        height: 100,
        color: Colors.cyan,
        alignment: Alignment.center,
        child: Text(
          "Sabit Liste Elemanı 6",
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    ];
  }

  //listeler için dinamik olarak eleman döndüren fonksiyon
  Widget _dinamikElemanUretenFonksiyon(BuildContext context, int index) {
    return Container(
      height: 100,
      color: rastgeleRenkUret(),
      alignment: Alignment.center,
      child: Text(
        "Dinamik Liste Elemanı ${index + 1}",
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }

  //liste elemanları için rastgele renk üretme fonksiyonu
  Color rastgeleRenkUret() {
    return Color.fromARGB(
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
      Random().nextInt(255),
    );
  }
}
