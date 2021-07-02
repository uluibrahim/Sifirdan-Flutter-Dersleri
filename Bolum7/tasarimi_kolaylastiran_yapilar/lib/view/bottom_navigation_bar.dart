import 'package:flutter/material.dart';

class BottomNavigationBarKullanimi extends StatefulWidget {
  int _currentIndex;
  BottomNavigationBarKullanimi(this._currentIndex);

  @override
  _BottomNavigationBarKullanimiState createState() =>
      _BottomNavigationBarKullanimiState(_currentIndex);
}

class _BottomNavigationBarKullanimiState
    extends State<BottomNavigationBarKullanimi> {
  int _currentIndex;
  _BottomNavigationBarKullanimiState(this._currentIndex);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Anasayfa',
            backgroundColor: Colors.orange),
        BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Ara',
            backgroundColor: Colors.red),
        BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'Hesap',
            backgroundColor: Colors.indigoAccent),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Ayarlar',
            backgroundColor: Colors.green),
      ],
      selectedItemColor: Colors.black,
      backgroundColor: Colors.teal.shade300,
      //type: BottomNavigationBarType.fixed, // 3 ten fazla öğe eklenşrse fixedten çıktığında kullanılabilir.
      // 3 ten fazla öğe eklenirse her öğere color verilmelidir
      currentIndex: _currentIndex,
      onTap: (value) {
        setState(() {
          _currentIndex = value;
        });
      },
    );
  }
}
