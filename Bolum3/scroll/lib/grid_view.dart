import 'package:flutter/material.dart';

class GridViewKullanimi extends StatelessWidget {
  const GridViewKullanimi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, index) {
        return Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal[index % 9 * 100],
        );
      },
    );
  }

  GridView buildGridViewExtent() {
    return GridView.extent(
      maxCrossAxisExtent: 100, // en fazla alacağı genişlik
      reverse: false,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      primary: false,
      //scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(20),
      children: [
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
      ],
    );
  }

  GridView buildGridViewCount() {
    return GridView.count(
      reverse: false,
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      primary: false,
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(20),
      children: [
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
        Container(
          child: Text(
            "data",
            textAlign: TextAlign.center,
          ),
          color: Colors.teal.shade300,
        ),
      ],
    );
  }
}
