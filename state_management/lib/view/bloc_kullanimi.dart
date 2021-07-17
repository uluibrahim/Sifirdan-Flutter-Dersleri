import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_management/bloc/sayac/sayac_boc.dart';
import 'package:state_management/bloc/sayac/sayac_event.dart';

class BlocKullanimi extends StatefulWidget {
  const BlocKullanimi({Key? key}) : super(key: key);

  @override
  _BlocKullanimiState createState() => _BlocKullanimiState();
}

class _BlocKullanimiState extends State<BlocKullanimi> {
  final _sayacBloc = SayacBloc();
  @override
  void dispose() {
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
                stream: _sayacBloc.sayac,
                builder: (context, snapshot) {
                  return Text("${snapshot.data}");
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: "fab1",
              onPressed: () {
                _sayacBloc.sayacEventSink.add(ArttirmaEvent());
              },
              child: Icon(Icons.add),
            ),
            SizedBox(height: 5),
            FloatingActionButton(
              heroTag: "fab2",
              onPressed: () {
                _sayacBloc.sayacEventSink.add(AzaltmaEvent());
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
