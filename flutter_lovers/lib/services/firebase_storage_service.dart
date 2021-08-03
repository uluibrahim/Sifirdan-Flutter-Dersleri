import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_lovers/services/storage_base.dart';
import 'package:image_picker/image_picker.dart';

// as firebase_storage
class FirebaseStorageService implements StorageBase {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  Reference? _storageReferance;

  @override
  Future<String> uploadFile(
      String? userId, String fileType, XFile? yuklenecekDosya) async {
    _storageReferance = _firebaseStorage
        .ref()
        .child(userId!)
        .child(fileType)
        .child("profil_photo.png");

    UploadTask _uploadTask =
        _storageReferance!.putFile(File(yuklenecekDosya!.path));
    String? _url;
    await _uploadTask.then((s) async {
      _url = await s.ref.getDownloadURL();
      return _url;
    });

    return _url!;
  }
}
