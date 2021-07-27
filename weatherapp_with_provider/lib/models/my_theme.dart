import 'package:flutter/material.dart';

class MyTheme {
  MaterialColor _renk;
  ThemeData _tema;

  MyTheme(this._renk, this._tema);

  MaterialColor get renk => _renk;

  set renk(MaterialColor renk) {
    _renk = renk;
  }

  ThemeData get tema => _tema;

  set tema(ThemeData tema) {
    _tema = tema;
  }
}
