import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/counter.dart';

class ProviderWithCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("provider ile sayac"),
      ),
      floatingActionButton: MyFabButtons(),
      body: Center(
        child: MyColumn(),
      ),
    );
  }
}

class MyFabButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myCounter = Provider.of<Counter>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: myCounter.arttir,
          heroTag: "fab1",
          child: Icon(Icons.add),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: myCounter.azalt,
          heroTag: "fab2",
          child: Icon(Icons.add),
        )
      ],
    );
  }
}

class MyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myCounter = Provider.of<Counter>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Counter value: \n ",
          style: TextStyle(fontSize: 25),
        ),
        Text(
          myCounter.counter.toString(),
          style: TextStyle(fontSize: 25),
        ),
      ],
    );
  }
}
