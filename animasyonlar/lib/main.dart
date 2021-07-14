import 'package:flutter/material.dart';

import 'view/hero.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  /**
  1- Ticker
  2- Animation
  3- AnimationController
  4- tween -> between(baslangic - bitis) 
  5- Curve 
   */
  int _counter = 0;
  AnimationController? controller;
  Animation? animation;
  Animation? animation2;
  Animation? animation3;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    // değimi dinleyen yapı listener
    controller!.addListener(() {
      setState(() {
        //print(controller!.value.toString());
        //print(animation!.value.toString());
      });
    });
    animation =
        ColorTween(begin: Colors.teal, end: Colors.red).animate(controller!);
    animation2 = AlignmentTween(begin: Alignment(-1, -1), end: Alignment(1, 1))
        .animate(
            CurvedAnimation(parent: controller!, curve: Curves.easeInOutExpo));

    animation3 =
        CurvedAnimation(parent: controller!, curve: Curves.easeInOutExpo);
    // controllerin başlamasını sağlar
    controller!.forward();

    // animasyonun durumu hakkında bilgi verir
    controller!.addStatusListener((durum) {
      if (durum == AnimationStatus.completed) {
        controller!.reverse().orCancel;
        // orcancel eğer işlem yapılamıyorsa durdurmasını sağlar
        // programda hata almamak adına kullanılmalıdır.
      }
      if (durum == AnimationStatus.dismissed) {
        controller!.forward().orCancel;
      }
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      appBar: AppBar(
        title: Text("Animasyonlar"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'You have pushed the button this many times:',
                style: TextStyle(
                  fontSize: animation3!.value * 40,
                ),
              ),
            ),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              alignment: animation2!.value,
              child: Text(
                '$_counter',
                style: TextStyle(
                  fontSize: controller!.value * 50,
                ),
              ),
            ),
            Container(
              height: 70,
              width: 80,
              child: Hero(
                tag: "tag",
                child: FlutterLogo(
                  textColor: Colors.orange,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => HeroAnimation("tag")));
              },
              child: Text("Hero"),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
