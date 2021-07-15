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

  set userState(UserState userState) {
    _userState = userState;
    notifyListeners();
  }

  AuthService() {
    _auth.authStateChanges().listen(_authStateChanged);
  }

  void _authStateChanged(User? user) {
    if (user == null) {
      // set state metodu kullanılır
      userState = UserState.OturumAcikDegil;
    } else {
      userState = UserState.OturumAcik;
    }
  }

  createWithEmailAndPassword(String email, String password) async {
    try {
      userState = UserState.OturumAciliyor;
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? _newUser = userCredential.user;
      return _newUser;
    } catch (e) {
      userState = UserState.OturumAcikDegil;
      print("Create error : $e");
    }
  }

  signinWithEmailAndPassword(String email, String password) async {
    try {
      userState = UserState.OturumAciliyor;
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? _oturumAcanUser = userCredential.user;
      return _oturumAcanUser;
    } catch (e) {
      userState = UserState.OturumAcikDegil;
      print("Sign in  error : $e");
    }
  }

  signOut() async {
    try {
      userState = UserState.OturumAcikDegil;
      await _auth.signOut();
      return true;
    } catch (e) {
      userState = UserState.OturumAcik;
      print("Sign out  error : $e");
      return false;
    }
  }
}
