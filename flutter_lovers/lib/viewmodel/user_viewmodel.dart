import 'package:flutter/material.dart';
import 'package:flutter_lovers/locator.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/repostory/user_repostory.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum ViewState { Idle, Busy }

// idle boşta
// busy meşgul
class UserViewModel with ChangeNotifier implements UserRepostory {
  ViewState _state = ViewState.Idle;
  UserRepostory _repostory = locator<UserRepostory>();
  MyUser? _user;

  MyUser? get user => _user;

  ViewState get state => _state;
  UserViewModel() {
    currentUser();
  }

  set state(ViewState value) {
    _state = value;
    notifyListeners();
  }

  @override
  Future<MyUser> currentUser() async {
    try {
      state = ViewState.Busy;
      _user = await _repostory.currentUser();
      return user!;
    } catch (e) {
      print("Hata usermodel currentstate");
      throw Exception(e);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser> signInAnonymously() async {
    try {
      state = ViewState.Busy;
      _user = await _repostory.signInAnonymously();
      return user!;
    } catch (e) {
      print("Hata usermodel signin anon");
      throw Exception(e);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;
      final _googleSignIn = GoogleSignIn();
      _googleSignIn.signOut();
      await _repostory.signOut();
      _user = null;

      return true;
    } catch (e) {
      print("Hata usermodel sign out");
      return false;
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    try {
      state = ViewState.Busy;
      _user = await _repostory.signInWithGoogle();
      return user!;
    } catch (e) {
      print("Hata usermodel signin google");
      throw Exception(e);
    } finally {
      state = ViewState.Idle;
    }
  }
}
