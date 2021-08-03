import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  String userId = "123456";
  String email = "123@gmail.com";
  @override
  Future<MyUser> currentUser() async {
    return await Future.value(
      MyUser(userId: userId, email: email),
    );
  }

  @override
  Future<MyUser> signInAnonymously() async {
    return await Future.delayed(
      Duration(seconds: 1),
      () => MyUser(userId: userId, email: email),
    );
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    return await Future.delayed(
      Duration(seconds: 1),
      () => MyUser(userId: "googleuserid", email: "google@gmail.com"),
    );
  }

  @override
  Future<MyUser> signInWithFacebook() async {
    return await Future.delayed(Duration(seconds: 1),
        () => MyUser(userId: "facebookuserid", email: "facebook@gmail.com"));
  }

  @override
  Future<MyUser> createUserWithEmailAndPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 1),
        () => MyUser(
            userId: "createEmialAndPasswordid", email: "create@gmail.com"));
  }

  @override
  Future<MyUser> signInWithEmailAndPassword(
      String email, String password) async {
    return await Future.delayed(
        Duration(seconds: 1),
        () => MyUser(
            userId: "signinEmialAndPasswordid", email: "email@gmail.com"));
  }
}
