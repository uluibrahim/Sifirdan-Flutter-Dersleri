import 'package:flutter/material.dart';
import 'package:flutter_lovers/app/locator.dart';
import 'package:flutter_lovers/models/konusma_model.dart';
import 'package:flutter_lovers/models/message.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/repostory/user_repostory.dart';

enum ViewState { Idle, Busy }

// idle boşta
// busy meşgul
class UserViewModel with ChangeNotifier implements UserRepostory {
  ViewState _state = ViewState.Idle;
  UserRepostory _repostory = locator<UserRepostory>();
  MyUser? _user;

  //validate form login
  String? emailErrorMessage;
  String? passwordErrorMessage;

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
      print("Hata userViewmodel currentstate");
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
      print("Hata userViewmodel signin anon");
      throw Exception(e);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      state = ViewState.Busy;

      await _repostory.signOut();
      _user = null;

      return true;
    } catch (e) {
      print("Hata userViewmodel sign out");
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
      print("Hata userViewmodel signin google");
      throw Exception(e);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser> signInWithFacebook() async {
    try {
      state = ViewState.Busy;
      _user = await _repostory.signInWithFacebook();
      return user!;
    } catch (e) {
      print("Hata userViewmodel signin facebook");
      throw Exception(e);
    } finally {
      state = ViewState.Idle;
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    if (_emailAndPasswordValidate(email, password)) {
      try {
        state = ViewState.Busy;
        _user =
            await _repostory.createUserWithEmailAndPassword(email, password);
        return user!;
      } finally {
        state = ViewState.Idle;
      }
    }
  }

  @override
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      if (_emailAndPasswordValidate(email, password)) {
        state = ViewState.Busy;
        _user = await _repostory.signInWithEmailAndPassword(email, password);
        return user!;
      }
    } finally {
      state = ViewState.Idle;
    }
  }

  bool _emailAndPasswordValidate(String email, String password) {
    bool sonuc = true;

    if (password.length < 6) {
      passwordErrorMessage = "Sifre en az 6 karakter olmalıdır";
      sonuc = false;
    } else {
      passwordErrorMessage = null;
    }
    if (!email.contains("@")) {
      emailErrorMessage = "hatali email";
      sonuc = false;
    } else {
      emailErrorMessage = null;
    }
    return sonuc;
  }

  Future<bool> updateUserName(String newUserName, String userId) async {
    bool result = await _repostory.updateUserName(newUserName, userId);

    return result;
  }

  Future<String> uploadFile(
      String? userId, String fileType, profilPhoto) async {
    String link = await _repostory.uploadFile(userId, fileType, profilPhoto!);
    return link;
  }

  Future<List<MyUser>> getAllUser() async {
    List<MyUser> allUsers = await _repostory.getAllUser();
    return allUsers;
  }

  Stream<List<MessageModel>> getMessages(
      String currentUserserId, String sohbetEdilenUserUserId) {
    return _repostory.getMessages(currentUserserId, sohbetEdilenUserUserId);
  }

  Future<bool> saveMessage(MessageModel mesaj) async {
    return await _repostory.saveMessage(mesaj);
  }

  Future<List<KonusmaModel>> getAllConversations(String userId) async {
    return await _repostory.getAllConversations(userId);
  }
}
