import 'package:flutter_lovers/models/user_model.dart';

abstract class AuthBase {
  Future<MyUser> currentUser();
  Future<MyUser> signInAnonymously();
  Future<bool> signOut();
  Future<MyUser> signInWithGoogle();
}
