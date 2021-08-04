import 'package:flutter_lovers/app/locator.dart';
import 'package:flutter_lovers/models/konusma_model.dart';
import 'package:flutter_lovers/models/message.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/services/auth_base.dart';
import 'package:flutter_lovers/services/fake_auth_service.dart';
import 'package:flutter_lovers/services/firebase_auth_service.dart';
import 'package:flutter_lovers/services/firebase_storage_service.dart';
import 'package:flutter_lovers/services/firestore_db_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timeago/timeago.dart' as timeago;

enum AppMode { DEBUG, RELEASE }

class UserRepostory implements AuthBase {
  FirebaseAuthService _firebaseAuthService = locator<FirebaseAuthService>();
  FakeAuthService _fakeAuthService = locator<FakeAuthService>();
  FirestoreDBService _firestoreDBService = locator<FirestoreDBService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  AppMode _appMode = AppMode.RELEASE;

  List<MyUser> _allUsers = [];
  @override
  Future<MyUser> currentUser() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.currentUser();
    } else {
      MyUser _user = await _firebaseAuthService.currentUser();
      return await _firestoreDBService.readUser(_user.userId.toString());
    }
  }

  @override
  Future<MyUser> signInAnonymously() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInAnonymously();
    } else {
      MyUser _user = await _firebaseAuthService.signInAnonymously();
      bool result = await _firestoreDBService.saveUser(_user);
      if (result) {
        return _user;
      } else {
        throw Exception();
      }
    }
  }

  @override
  Future<bool> signOut() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signOut();
    } else {
      return await _firebaseAuthService.signOut();
    }
  }

  @override
  Future<MyUser> signInWithGoogle() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithGoogle();
    } else {
      MyUser _user = await _firebaseAuthService.signInWithGoogle();
      bool result = await _firestoreDBService.saveUser(_user);
      if (result) {
        return await _firestoreDBService.readUser(_user.userId.toString());
      } else {
        throw Exception();
      }
    }
  }

  @override
  Future<MyUser> signInWithFacebook() async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithFacebook();
    } else {
      MyUser _user = await _firebaseAuthService.signInWithFacebook();
      bool result = await _firestoreDBService.saveUser(_user);
      if (result) {
        return await _firestoreDBService.readUser(_user.userId.toString());
      } else {
        throw Exception();
      }
    }
  }

  @override
  Future<MyUser?> createUserWithEmailAndPassword(
      String email, String password) async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.createUserWithEmailAndPassword(
          email, password);
    } else {
      MyUser _user = await _firebaseAuthService.createUserWithEmailAndPassword(
          email, password);
      bool result = await _firestoreDBService.saveUser(_user);
      if (result) {
        return await _firestoreDBService.readUser(_user.userId.toString());
      }
    }
  }

  @override
  Future<MyUser?> signInWithEmailAndPassword(
      String email, String password) async {
    if (_appMode == AppMode.DEBUG) {
      return await _fakeAuthService.signInWithEmailAndPassword(email, password);
    } else {
      MyUser _user = await _firebaseAuthService.signInWithEmailAndPassword(
          email, password);
      return await _firestoreDBService.readUser(_user.userId.toString());
    }
  }

  Future<bool> updateUserName(String newUserName, String userId) async {
    if (_appMode == AppMode.DEBUG) {
      return false;
    } else {
      bool result =
          await _firestoreDBService.updateUserName(userId, newUserName);
      return result;
    }
  }

  Future<String> uploadFile(
      String? userId, String fileType, XFile? profilPhoto) async {
    if (_appMode == AppMode.DEBUG) {
      return "file upload indirme linki";
    } else {
      String _photoUrl = await _firebaseStorageService.uploadFile(
          userId, fileType, profilPhoto!);
      await _firestoreDBService.updateProfilPhoto(userId!, _photoUrl);
      return _photoUrl;
    }
  }

  Future<List<MyUser>> getAllUser() async {
    if (_appMode == AppMode.DEBUG) {
      return [];
    } else {
      _allUsers = await _firestoreDBService.getAllUesr();
      return _allUsers;
    }
  }

  Stream<List<MessageModel>> getMessages(
      String currentUserserId, String sohbetEdilenUserUserId) {
    if (_appMode == AppMode.DEBUG) {
      return Stream.empty(); // boş stream
    } else {
      Stream<List<MessageModel>> allUsers = _firestoreDBService.getMessages(
          currentUserserId, sohbetEdilenUserUserId);
      return allUsers;
    }
  }

  Future<bool> saveMessage(MessageModel mesaj) async {
    if (_appMode == AppMode.DEBUG) {
      return true;
    } else {
      return _firestoreDBService.saveMessage(mesaj);
    }
  }

  Future<List<KonusmaModel>> getAllConversations(String userId) async {
    if (_appMode == AppMode.DEBUG) {
      return [];
    } else {
      DateTime _okunmaZamani = await _firestoreDBService.saatiGoster(userId);
      List<KonusmaModel> konusmaListesi;
      konusmaListesi = await _firestoreDBService.getAllConversations(userId);
      for (KonusmaModel oankiKonusma in konusmaListesi) {
        MyUser? userListesindekikullanici =
            _listedeUserBul(oankiKonusma.kimleKonusuyor.toString());
        if (userListesindekikullanici != null) {
          print("veriler local cacheden okundu");
          oankiKonusma.konusulanUserName = userListesindekikullanici.userName;
          oankiKonusma.konusulanUserProfilURL =
              userListesindekikullanici.profilURL;
          oankiKonusma.sonOkunmaZamani = _okunmaZamani;
        } else {
          print("aranılan userdaha önce getirilmemiş");
          MyUser veritabindanOkunanUser = await _firestoreDBService
              .readUser(oankiKonusma.kimleKonusuyor.toString());
          oankiKonusma.konusulanUserName = veritabindanOkunanUser.userName;
          oankiKonusma.konusulanUserProfilURL =
              veritabindanOkunanUser.profilURL;
          oankiKonusma.sonOkunmaZamani = _okunmaZamani;
        }
        _timeagoHesapla(oankiKonusma, _okunmaZamani);
      }
      return konusmaListesi;
    }
  }

  MyUser? _listedeUserBul(String userId) {
    for (var i = 0; i < _allUsers.length; i++) {
      if (_allUsers[i].userId == userId) {
        return _allUsers[i];
      }
    }
    return null;
  }

  void _timeagoHesapla(KonusmaModel oankiKonusma, DateTime okunmaZamani) {
    timeago.setLocaleMessages("tr", timeago.TrMessages());
    Duration _duration =
        okunmaZamani.difference(oankiKonusma.olusturmaTarihi!.toDate());
    oankiKonusma.aradakiZamanFarki =
        timeago.format(okunmaZamani.subtract(_duration), locale: "tr");
  }
}
