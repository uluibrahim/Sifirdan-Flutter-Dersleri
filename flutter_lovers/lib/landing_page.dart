import 'package:flutter/material.dart';

import 'package:flutter_lovers/app/home_page.dart';
import 'package:flutter_lovers/app/sign_in/sign_in_page.dart';
import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    if (_userModel.state == ViewState.Idle) {
      if (_userModel.user != null) {
        return HomePage(user: _userModel.user!);
      } else {
        return SignInPage();
      }
    } else {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
