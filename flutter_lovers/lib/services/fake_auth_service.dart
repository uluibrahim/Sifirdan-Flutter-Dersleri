import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';

class FakeAuthService implements AuthBase {
  String userId = "123456";
  @override
  Future<MyUser> currentUser() async {
    return await Future.value(MyUser(userId: userId));
  }

  @override
  Future<MyUser> signInAnonymously() async {
    return await Future.delayed(
        Duration(seconds: 1), () => MyUser(userId: userId));
  }

  @override
  Future<bool> signOut() {
    return Future.value(true);
  }

  @override
  Future<MyUser> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }
}
