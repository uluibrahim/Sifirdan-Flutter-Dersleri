import 'package:flutter/material.dart';

class SehirSec extends StatefulWidget {
  @override
  _SehirSecState createState() => _SehirSecState();
}

class _SehirSecState extends State<SehirSec> {
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppbar(),
      body: Form(
        child: Row(
          children: [
            Expanded(
              flex: 80,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10),
                child: TextFormField(
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Sehir sec",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 20,
              child: CircleAvatar(
                radius: 25,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context, _textController.text);
                  },
                  icon: Icon(Icons.search),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar myAppbar() => AppBar(title: Text("Sehir Sec"));
}
