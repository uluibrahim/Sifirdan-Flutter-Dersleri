import 'dart:async';

import 'package:flutter/material.dart';

class StreamKullanimi extends StatefulWidget {
  const StreamKullanimi({Key? key}) : super(key: key);

  @override
  _StreamKullanimiState createState() => _StreamKullanimiState();
}

class _StreamKullanimiState extends State<StreamKullanimi> {
  final StreamController<int> _streamController = StreamController<int>();
  int _counter = 0;

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("You have pushed the button this many times:"),
              StreamBuilder<int>(
                initialData: 0,
                stream: _streamController.stream,
                builder: (context, AsyncSnapshot<int> snapshot) {
                  return Text("${snapshot.data}");
                },
              )
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "fab1",
              onPressed: () {
                _streamController.sink.add(++_counter);
              },
              child: Icon(Icons.add),
            ),
            SizedBox(height: 5),
            FloatingActionButton(
              heroTag: "fab2",
              onPressed: () {
                _streamController.sink.add(--_counter);
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
