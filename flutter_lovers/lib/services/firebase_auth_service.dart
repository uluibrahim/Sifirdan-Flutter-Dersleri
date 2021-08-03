import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
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
    return MyUser(userId: user.uid, email: user.email.toString());
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
      final _googleSignIn = GoogleSignIn();
      _googleSignIn.signOut();
      final _faceSignIn = FacebookLogin();
      _faceSignIn.logOut();
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

  @override
  Future<MyUser> signInWithFacebook() async {
    final _facebookLogin = FacebookLogin();
    FacebookLoginResult _loginResult = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);

    switch (_loginResult.status) {
      case FacebookLoginStatus.success:
        if (_loginResult.accessToken != null) {
          UserCredential _fireResult = await _firebaseAuth.signInWithCredential(
            FacebookAuthProvider.credential(_loginResult.accessToken!.token),
          );
          User? user = _fireResult.user;
          return _useFromFirebase(user!);
        }
        break;
      case FacebookLoginStatus.cancel:
        print("User facebook girişini iptal etti");
        break;
      case FacebookLoginStatus.error:
        print("Facebook login hatasi: " + _loginResult.error.toString());
        break;
      default:
    }
    throw Exception();
  }

  @override
  Future<MyUser> createUserWithEmailAndPassword(
      String email, String password) async {
    UserCredential sonuc = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    return _useFromFirebase(sonuc.user!);
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(
      String email, String password) async {
    UserCredential sonuc = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _useFromFirebase(sonuc.user!);
  }
}
