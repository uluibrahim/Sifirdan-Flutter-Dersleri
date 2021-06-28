import 'package:flutter/material.dart';

class NavigasyonIslemleri extends StatelessWidget {
  String _baslik = "B Sayfası";
  String _baslik2 = "C sayfası";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Navigasyon İslemleri"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => ASayfasi()));
              },
              child: Text("A SAYFASINA GİT"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => BSayfasi(_baslik)));
              },
              child: Text("B Sayfasına git ve veri gönder"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => CSayfasi(_baslik2)));
              },
              child: Text("C Sayfasına git ve geri gel"),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push<bool>(
                  context,
                  MaterialPageRoute(builder: (contex) => CSayfasi(_baslik2)),
                  // pop ile geri gelindiğinde tetiklenecek kısım then kısmıdır
                ).then(
                  (value) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("Pop ile dönen deger $value"),
                      ),
                    );
                    print("gelen deger $value");
                  },
                );
              },
              child: Text("D Sayfasına git ve veri getir"),
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (contex) => ESayfasi()));
              },
              child: Text("e Sayfasına git ve geri gelme"),
            ),
          ],
        ),
      ),
    );
  }
}

class ASayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("A SAYFASI"),
      ),
      body: Center(
        child: Column(
          children: [Text("A SAYFASI")],
        ),
      ),
    );
  }
}

class BSayfasi extends StatelessWidget {
  String _baslik;
  BSayfasi(this._baslik);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_baslik),
      ),
      body: Center(
        child: Column(
          children: [Text(_baslik)],
        ),
      ),
    );
  }
}

class CSayfasi extends StatelessWidget {
  String _baslik;
  CSayfasi(this._baslik);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_baslik),
      ),
      body: Center(
        child: Column(
          children: [
            Text(_baslik),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Geri dön"),
            ),
          ],
        ),
      ),
    );
  }
}

class DSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop<bool>(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("D sayfası"),
        ),
        body: Center(
          child: Column(
            children: [
              Text("D sayfası"),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop<bool>(context, true);
                },
                child: Text("Geri dön ve  veri getir"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ESayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E SAYFASI"),
      ),
      body: Center(
        child: Column(
          children: [
            Text("E SAYFASI"),
          ],
        ),
      ),
    );
  }
}
