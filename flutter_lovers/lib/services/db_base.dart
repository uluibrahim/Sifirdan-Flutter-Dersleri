import 'package:flutter_lovers/models/konusma_model.dart';
import 'package:flutter_lovers/models/message.dart';
import 'package:flutter_lovers/models/user_model.dart';

abstract class DBBase {
  Future<bool> saveUser(MyUser user);
  Future<MyUser> readUser(String userId);
  Future<bool> updateUserName(String userId, String newUserName);
  Future<bool> updateProfilPhoto(String userId, String photoUrl);
  Future<List<MyUser>> getAllUesr();
  Future<List<KonusmaModel>> getAllConversations(
      String userId); // konusmaların getirilmesi
  Stream<List<MessageModel>> getMessages(
      String currentUserId, String sohbetEdilenUserId);
  Future<bool> saveMessage(MessageModel mesaj);
}
