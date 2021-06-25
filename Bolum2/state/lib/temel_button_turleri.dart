import 'package:flutter/material.dart';

class TemelButonlar extends StatefulWidget {
  TemelButonlar({Key key}) : super(key: key);

  @override
  _TemelButonlarState createState() => _TemelButonlarState();
}

class _TemelButonlarState extends State<TemelButonlar> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {},
            child: Text("Text buton"),
            /*
            thmeData içinde tanımlandı
            style: ButtonStyle(
              //backgroundColor: MaterialStateProperty.all(Colors.orange.shade300),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.orange;
                  }
                  return null;
                },
              ),
            ),
            */
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
            label: Text("Text buton with ıcon"),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Elevated buton"),
            style: ElevatedButton.styleFrom(
                primary: Colors.red, onPrimary: Colors.yellow),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
            label: Text("Elevated with icon"),
          ),
          OutlinedButton(
            onPressed: () {},
            child: Text("Outlined buton"),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
            label: Text("Outlined with icon"),
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(), side: BorderSide()),
          ),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_box_outlined),
            label: Text("Outlined with icon"),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              side: BorderSide(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
