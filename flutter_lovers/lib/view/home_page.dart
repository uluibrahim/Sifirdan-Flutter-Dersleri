import 'package:flutter/material.dart';
import 'package:flutter_lovers/models/user_model.dart';

import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final MyUser user;
  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context, listen: true);
    return Scaffold(
      appBar: appBar(_userModel, context),
      body: Center(
        child: Text("Hoşgeldiniz " + user.userId),
      ),
    );
  }

  AppBar appBar(UserViewModel _userModel, BuildContext context) {
    return AppBar(
      title: Text("Home Page"),
      actions: [
        TextButton(
          onPressed: () => _cikisYap(_userModel, context),
          child: Text(
            "Çıkış Yap",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Future<bool> _cikisYap(UserViewModel userModel, BuildContext context) async {
    bool sonuc = await userModel.signOut();
    return sonuc;
  }
}
