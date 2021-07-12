import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginIslemleri extends StatefulWidget {
  LoginIslemleri({Key? key}) : super(key: key);

  @override
  _LoginIslemleriState createState() => _LoginIslemleriState();
}

class _LoginIslemleriState extends State<LoginIslemleri> {
  @override
  void initState() {
    super.initState();
    _auth.userChanges().listen((User? user) {
      if (user == null) {
        print('Kullanıcı oturumu kapattı!');
      } else {
        if (user.emailVerified) {
          print('Kullanıcı oturum açtı ve email onaylı');
        } else
          print('Kullanıcı oturum açtı ve email onaylı değil');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login işlemleri"),
        ),
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _emailSifreKullaniciOlustur();
              },
              child: Text("Email /Şifre  User Create"),
            ),
            ElevatedButton(
              onPressed: () {
                _emailSifreKullaniciLogin();
              },
              child: Text("Email /Şifre  User LogIn"),
            ),
            ElevatedButton(
              onPressed: () {
                _cikisYap();
              },
              child: Text("Çıkış Yap"),
            ),
            ElevatedButton(
              onPressed: () {
                _passwordReset();
              },
              child: Text("Şifremi unuttum"),
            ),
            ElevatedButton(
              onPressed: () {
                _passwordUpdate();
              },
              child: Text("Şifremi güncelle"),
            ),
            ElevatedButton(
              onPressed: () {
                _emailUpdate();
              },
              child: Text("Email güncelle"),
            ),
            ElevatedButton(
              onPressed: () {
                _signInWithGoogle();
              },
              child: Text("Google ile giriş"),
            ),
            ElevatedButton(
              onPressed: () {
                _signInWithPhone();
              },
              child: Text("Telfon ile giriş"),
            ),
          ],
        )));
  }

  void _emailSifreKullaniciOlustur() async {
    String _email = "ibrahimhalillulu@gmail.com";
    String _password = "password";

    try {
      UserCredential _credential = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User? yeniUser = _credential.user;
      await yeniUser!.sendEmailVerification();
      if (_auth.currentUser != null) {
        print("Email gönderildi hesabınızı onaylayın");
        await _auth.signOut();
        print("Kullanıcı oturumdan atıldı.");
      } else {}
      debugPrint(yeniUser.toString());
    } catch (e) {
      print("Hata $e");
    }
  }

  Future<void> _emailSifreKullaniciLogin() async {
    String _email = "ibrahimhalillulu@gmail.com";
    String _password = "password";

    try {
      if (_auth.currentUser == null) {
        User? _oturumAcanUser = (await _auth.signInWithEmailAndPassword(
                email: _email, password: _password))
            .user;
        if (_oturumAcanUser!.emailVerified) {
          print("Oturum açma başarılı");
        } else {
          print("Onayalama işleminizi yapmanız gerekmektedir.");
          _auth.signOut();
        }
      } else {
        print("Zaten oturum açık");
      }
    } catch (e) {
      print("Hatalı email veya şifre $e");
    }
  }

  void _cikisYap() async {
    if (_auth.currentUser != null) {
      await _auth.signOut();
    } else
      print("Oturum Açık Değil");
  }

  _passwordReset() async {
    String _email = "ibrahimhalillulu@gmail.com";
    try {
      await _auth.sendPasswordResetEmail(email: _email);
    } catch (e) {
      print("Password güncellenirken hata oluştu: $e");
    }
  }

  _passwordUpdate() async {
    try {
      await _auth.currentUser!.updatePassword("password2");
      print("Şifreniz güncellendi");
    } catch (e) {
      try {
        String email = 'ibrahimhalillulu@gmail.com';
        String password = 'password2';

        // Create a credential
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);
        // Reauthenticate
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(credential);
        await _auth.currentUser!.updatePassword("password2");
        print("Gücellendi");
      } catch (e) {
        print("Hata oluştu $e");
      }
      print("Şifre güncellenemedi");
    }
  }

  _emailUpdate() async {
    try {
      await _auth.currentUser!.updateEmail("iulu17@posta.pau.edu.tr");
      print("Email güncellendi");
    } on FirebaseAuthException catch (e) {
      try {
        String email = 'ibrahimhalillulu@gmail.com';
        String password = 'password';
        // Create a credential
        AuthCredential credential =
            EmailAuthProvider.credential(email: email, password: password);
        // Reauthenticate
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithCredential(credential);
        print("Girilen eski email ve şifre doğru");
        await _auth.currentUser!.updateEmail("iulu17@posta.pau.edu.tr");
        print("Email Gücellendi");
      } catch (e) {
        print("Hata oluştu $e");
        print("Email güncellenemedi");
      }
    }
  }

  _signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print("Oturum açıldı");
      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return print("Google ile girişte hata oluştu");
    }
  }

  void _signInWithPhone() async {
    //+95 42 542 5422
    //123456
    await _auth.verifyPhoneNumber(
      phoneNumber: '+95 42 542 5422',
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print("Verification failed hatası: $e");
      },
      codeSent: (String verificationId, int? resendToken) async {
        print("Kod Yollandı..");
        try {
          String smsCode = '123456';

          // Create a PhoneAuthCredential with the code
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          // Sign the user in (or link) with the credential
          await _auth.signInWithCredential(credential);
        } catch (e) {
          print("Kod hatası:  $e");
        }
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
