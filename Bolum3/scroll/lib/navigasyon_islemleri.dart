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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/APage");
              },
              child: Text("A SAYFASINA GİT"),
            ),
            SizedBox(height: 1),
            OutlinedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => BSayfasi(_baslik)));
              },
              child: Text("B Sayfasına git ve veri gönder"),
            ),
            SizedBox(height: 1),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (contex) => CSayfasi(_baslik2)));
              },
              child: Text("C Sayfasına git ve geri gel"),
            ),
            SizedBox(height: 1),
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
            SizedBox(height: 1),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/EPage");
              },
              child: Text("E Sayfasına git ve geri gelme"),
            ),
            SizedBox(height: 1),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/listeSayfasi");
              },
              child: Text("Liste sayfasına git "),
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

class ListeSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste sayfası"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: Card(
              child: ListTile(
                title: Text("List elemanı ${index + 1}"),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, "/detay/$index");
            },
          );
        },
        itemCount: 20,
      ),
    );
  }
}

class ListeDetay extends StatelessWidget {
  int index;
  ListeDetay(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay ${index + 1}"),
      ),
      body: Center(
        child: Text("Gelen index değeri $index"),
      ),
    );
  }
}
