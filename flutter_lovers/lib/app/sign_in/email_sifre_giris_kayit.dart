import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lovers/app/exceptions.dart';
import 'package:flutter_lovers/common_widget/platform_duyarli_widgetler/platform_duyarli_alert_dialog.dart';
import 'package:flutter_lovers/common_widget/social_login_in_button.dart';
import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

enum FormType { REGISTER, LOGIN }

class EmailAndPasswordLoginPage extends StatefulWidget {
  @override
  _EmailAndPasswordLoginPageState createState() =>
      _EmailAndPasswordLoginPageState();
}

class _EmailAndPasswordLoginPageState extends State<EmailAndPasswordLoginPage> {
  String? _email;
  String? _password;
  final _formKey = GlobalKey<FormState>();
  String? _butonText;
  String? _linkText;
  FormType _formType = FormType.LOGIN;

  void _formSubmit(UserViewModel _userModel) async {
    _formKey.currentState!.save();
    print("Email: $_email Sifre: $_password");

    if (_formType == FormType.LOGIN) {
      try {
        await _userModel.signInWithEmailAndPassword(_email!, _password!);
      } catch (e) {
        PlatformDuyarliAlertDialog(
          title: "Oturum Açılamadı",
          contentText: Exceptions.hataGoster(e.toString().toString()),
          basicButtonText: 'Tamam',
        ).dialogGoster(context);
      }
    } else {
      try {
        await _userModel.createUserWithEmailAndPassword(_email!, _password!);
      } catch (e) {
        PlatformDuyarliAlertDialog(
          title: "Kayıt olmada hata",
          contentText: Exceptions.hataGoster(e.toString().toString()),
          basicButtonText: 'Tamam',
        ).dialogGoster(context);
      }
    }
  }

  void _formTypeDegistir() {
    setState(() {
      _formType == FormType.REGISTER
          ? _formType = FormType.LOGIN
          : _formType = FormType.REGISTER;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    _butonText = _formType == FormType.LOGIN ? "Giriş Yap" : "Kayıt Ol";
    _linkText = _formType == FormType.LOGIN
        ? "Hesabınız yok mu? Kayıt Ol"
        : "Hesabınız var mı? Giriş Yap ";
    if (_userModel.user != null) {
      Future.delayed(
        Duration(milliseconds: 200),
        () => Navigator.of(context).pop(),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text("Giriş ve Kayıt ol")),
      body: _userModel.state == ViewState.Idle
          ? SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: "abc@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          errorText: _userModel.emailErrorMessage != null
                              ? _userModel.emailErrorMessage
                              : null,
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (girilenEmail) {
                          _email = girilenEmail;
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        initialValue: "password",
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                          errorText: _userModel.passwordErrorMessage != null
                              ? _userModel.passwordErrorMessage
                              : null,
                          prefixIcon: Icon(Icons.lock),
                          labelText: "Password",
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (girirlenSifre) {
                          _password = girirlenSifre;
                        },
                      ),
                      SizedBox(height: 20),
                      SocialLoginButton(
                        buttonText: _butonText!,
                        onPressed: () => _formSubmit(_userModel),
                      ),
                      SizedBox(height: 20),
                      TextButton(
                        onPressed: () => _formTypeDegistir(),
                        child: Text(_linkText!),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
