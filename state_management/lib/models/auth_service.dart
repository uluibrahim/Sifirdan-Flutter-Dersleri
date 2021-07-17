import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum UserState {
  OturumAcik, // oturum açık
  OturumAcikDegil, // oturum açık değil
  OturumAciliyor, // oturum açılıyor
}

class AuthService with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserState _userState = UserState.OturumAcikDegil;

  UserState get userState => _userState;
  User? _user;

  User? get user => _user;

  set user(User? user) {
    _user = user;
  }

  set userState(UserState userState) {
    _userState = userState;
    notifyListeners();
  }

  AuthService() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User? user) {
    if (user == null) {
      _user = null;
      // set state metodu kullanılır
      userState = UserState.OturumAcikDegil;
    } else {
      _user = user;
      userState = UserState.OturumAcik;
    }
  }

  createWithEmailAndPassword(String email, String password) async {
    try {
      userState = UserState.OturumAciliyor;
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? _newUser = userCredential.user;
      _user = _newUser;
      userState = UserState.OturumAcik;
      return _newUser;
    } catch (e) {
      userState = UserState.OturumAcikDegil;
      print("Create error : $e");
    }
  }

  signinWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      userState = UserState.OturumAcik;
      User? _oturumAcanUser = userCredential.user;
      _user = _oturumAcanUser;
      return _oturumAcanUser;
    } catch (e) {
      userState = UserState.OturumAcikDegil;
      print("Sign in  error : $e");
    }
  }

  signOut() async {
    try {
      await _auth.signOut();
      userState = UserState.OturumAcikDegil;
      _user = null;
      return true;
    } catch (e) {
      print("Sign out  error : $e");
      return false;
    }
  }
}
