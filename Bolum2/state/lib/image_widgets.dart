import 'package:flutter/material.dart';

class ImageWidgets extends StatelessWidget {
  String _assetImageUrl = "assets/images/car.jpg";
  String _networkImageUrl = "https://picsum.photos/seed/picsum/200/300";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      height: 100,
                      child: Image.asset(_assetImageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Image.network(_networkImageUrl, fit: BoxFit.cover),
                    ),
                  ),
                  Expanded(
                    child: CircleAvatar(
                      //child: Text("ULU"),
                      backgroundColor:
                          Colors.blueAccent, // circle avatarın arka plan rengi
                      foregroundColor: Colors.red, // child in rengi
                      foregroundImage: NetworkImage(_networkImageUrl),
                      radius: 50,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 400,
            child: FadeInImage.assetNetwork(
              placeholder: "assets/images/loading.png",
              image: _networkImageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(child: Placeholder()),
        ],
      ),
    );
  }
}
