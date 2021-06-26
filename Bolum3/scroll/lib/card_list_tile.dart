import 'package:flutter/material.dart';

class CardListTile extends StatefulWidget {
  CardListTile({Key key}) : super(key: key);

  @override
  _CardListTileState createState() => _CardListTileState();
}

class _CardListTileState extends State<CardListTile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: ListView(
          children: [
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
            buildCard(),
          ],
        ),
      ),
    );
  }

  Column buildCard() {
    return Column(
      children: [
        Card(
          color: Colors.cyan.shade200,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ListTile(
            title: Text("title"),
            leading: Icon(Icons.real_estate_agent),
            subtitle: Text("Subtitle"),
            trailing: Icon(Icons.remove_shopping_cart),
          ),
        ),
        Divider(
          color: Colors.red,
          endIndent: 30,
          indent: 30,
          height: 20,
          thickness: 1.5,
        ),
      ],
    );
  }
}
