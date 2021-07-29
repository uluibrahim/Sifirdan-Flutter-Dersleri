import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService implements AuthBase {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<MyUser> currentUser() async {
    try {
      User _user = _firebaseAuth.currentUser!;
      return _useFromFirebase(_user);
    } catch (e) {
      print("Hata Current User: " + e.toString());
      throw Exception(e);
    }
  }

  MyUser _useFromFirebase(User user) {
    return MyUser(userId: user.uid);
  }

  @override
  Future<MyUser> signInAnonymously() async {
    try {
      UserCredential sonuc = await _firebaseAuth.signInAnonymously();
      return _useFromFirebase(sonuc.user!);
    } catch (e) {
      print("Hata anonmyously: $e");
      throw Exception(e);
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      print("Hata sign out $e");
      return false;
    }
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    GoogleSignIn _googleSignin = GoogleSignIn();
    GoogleSignInAccount? _googleUser = await _googleSignin.signIn();
    UserCredential? sonuc;
    if (_googleUser != null) {
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      if (_googleAuth.idToken != null && _googleAuth.accessToken != null) {
        sonuc = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.credential(
            idToken: _googleAuth.idToken,
            accessToken: _googleAuth.accessToken,
          ),
        );
        User? user = sonuc.user;
        return _useFromFirebase(user!);
      } else {
        throw Exception();
      }
    } else {
      throw Exception();
    }
  }
}
