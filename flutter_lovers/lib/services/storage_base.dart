import 'package:image_picker/image_picker.dart';

abstract class StorageBase {
  Future<String> uploadFile(
      String userId, String fileType, XFile yuklenecekDosya);
}
