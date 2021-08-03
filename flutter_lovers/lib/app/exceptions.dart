class Exceptions {
  static String hataGoster(String hataKodu) {
    switch (hataKodu) {
      case "[firebase_auth/emaıl-already-ın-use] The email address is already in use by another account.":
        return "Bu mail adresi zaten kullanılmakta";
      case "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.":
        return "Bu mail adresi ile hesap bulunamadı";
      case "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.":
        return "Hatalı şifre";
      default:
        return "Bir hata oluştu";
    }
  }
}
