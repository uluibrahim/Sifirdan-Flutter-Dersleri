import 'package:flutter/material.dart';

class MyCounterPage extends StatefulWidget {
  MyCounterPage({Key key}) : super(key: key);

  @override
  _MyCounterPageState createState() => _MyCounterPageState();
}

class _MyCounterPageState extends State<MyCounterPage> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyNewTextWidget(),
            Text(
              _counter.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Buton tıklandı $_counter");
          counterArttir();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void counterArttir() {
    setState(() => _counter++);
  }
}

class MyNewTextWidget extends StatelessWidget {
  const MyNewTextWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Stateless widget',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}
