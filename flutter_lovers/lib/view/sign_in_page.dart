import 'package:flutter/material.dart';
import 'package:flutter_lovers/common_widget/social_login_in_button.dart';
import 'package:flutter_lovers/models/user_model.dart';

import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  void _misafirGiris(BuildContext context, UserViewModel userModel) async {
    MyUser sonuc = await userModel.signInAnonymously();
    print("Oturum açan user ıd: " + sonuc.userId.toString());
  }

  void _googleIleGirisYap(BuildContext context, UserViewModel userModel) async {
    MyUser sonuc = await userModel.signInWithGoogle();
    //print("Google ile giriş : " + sonuc.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Flutter lovers"), elevation: 0),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text("Oturum Açın", style: TextStyle(fontSize: 30)),
            ),
            SizedBox(height: 5),
            SocialLoginButton(
              buttonText: "Googke ile oturum açın",
              buttonColor: Colors.white,
              textColor: Colors.black54,
              buttonIcon: Image.asset("assets/images/google-logo.png"),
              onPressed: () => _googleIleGirisYap(context, _userModel),
            ),
            SocialLoginButton(
              buttonText: "Facebook ile oturum açın",
              buttonIcon: Image.asset("assets/images/facebook-logo.png",
                  fit: BoxFit.cover),
              onPressed: () {},
            ),
            SocialLoginButton(
              buttonText: "Email ile oturum açın",
              buttonColor: Colors.tealAccent.shade700,
              buttonIcon: Icon(Icons.email),
              onPressed: () {
                print("object");
              },
            ),
            SocialLoginButton(
              buttonText: "Misafir girişi",
              buttonColor: Colors.orange,
              onPressed: () => _misafirGiris(context, _userModel),
            ),
          ],
        ),
      ),
    );
  }
}
