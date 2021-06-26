import 'package:flutter/material.dart';

class GridViewKullanimi extends StatelessWidget {
  const GridViewKullanimi({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Grid view")),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, index) {
          return GestureDetector(
            child: Container(
              child: Text(
                "data",
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                // color: Colors.teal[index % 9 * 100],
                gradient: LinearGradient(
                    colors: [Colors.tealAccent, Colors.orange],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight),
                image: DecorationImage(
                  image: NetworkImage(
                      "https://picsum.photos/id/870/200/300?grayscale&blur=2"),
                ),
                border: Border.all(color: Colors.blue, width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 5,
                    offset: Offset(10, 10),
                  ),
                ],
                shape: BoxShape.circle,
              ),
              margin: EdgeInsets.all(20),
            ),
            onTap: () => print("Gesture detector $index"),
          );
        },
      ),
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
