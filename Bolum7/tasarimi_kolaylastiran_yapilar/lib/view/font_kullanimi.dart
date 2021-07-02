import 'package:flutter/material.dart';

class FontKullanimi extends StatelessWidget {
  const FontKullanimi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Hello World',
            style: TextStyle(
              fontFamily: "Ubuntu",
              fontSize: 35,
            ),
          ),
          Text(
            'Hello World',
            style: TextStyle(
                fontFamily: "Ubuntu",
                fontSize: 35,
                fontWeight: FontWeight.w700),
          ),
          Text(
            'Hello World',
            style: TextStyle(
                fontFamily: "Dancing",
                fontSize: 35,
                fontWeight: FontWeight.w700),
          ),
          Text(
            'theme da tanımlanan tip ',
            style: TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}
