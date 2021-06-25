import 'package:flutter/material.dart';

class ImageWidgets extends StatelessWidget {
  String _assetImageUrl = "assets/images/car.jpg";
  String _networkImageUrl = "https://picsum.photos/seed/picsum/200/300";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 200,
            width: 200,
            child: Image.asset(_assetImageUrl,fit: BoxFit.cover),
          ),
          Container(
            height: 200,
            width: 200,
            child: Image.network(_networkImageUrl,fit: BoxFit.cover),
          ),
          CircleAvatar(
            //child: Text("ULU"),
            backgroundColor: Colors.blueAccent,// circle avatarın arka plan rengi
            foregroundColor: Colors.red,// child in rengi
            foregroundImage:NetworkImage(_networkImageUrl),
            radius: 50,
          )
        ],
      ),
    );
  }
}
