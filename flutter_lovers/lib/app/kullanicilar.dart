import 'package:flutter/material.dart';
import 'package:flutter_lovers/models/user_model.dart';
import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

import 'konusma.dart';

class KullanicilarPage extends StatefulWidget {
  const KullanicilarPage({Key? key}) : super(key: key);

  @override
  _KullanicilarPageState createState() => _KullanicilarPageState();
}

class _KullanicilarPageState extends State<KullanicilarPage> {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanicilar"),
      ),
      body: RefreshIndicator(
        onRefresh: () => _kullanicilarPageYenile(),
        child: FutureBuilder<List<MyUser>>(
            future: _userModel.getAllUser(),
            builder:
                (BuildContext context, AsyncSnapshot<List<MyUser>> result) {
              if (result.hasData) {
                List<MyUser>? allUsers = result.data;
                if (allUsers!.length - 1 > 0) {
                  return ListView.builder(
                    itemCount: allUsers.length,
                    itemBuilder: (context, index) {
                      MyUser anlikUser = allUsers[index];
                      if (anlikUser.userId != _userModel.user!.userId) {
                        return ListTile(
                          leading: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                NetworkImage(anlikUser.profilURL.toString()),
                          ),
                          subtitle: Text(anlikUser.email.toString()),
                          title: Text(anlikUser.userName.toString()),
                          onTap: () =>
                              _chatPage(context, _userModel, anlikUser),
                        );
                      } else {
                        return SizedBox();
                      }
                    },
                  );
                } else {
                  return RefreshIndicator(
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.supervised_user_circle,
                                size: 80,
                              ),
                              Text(
                                "Kayıtlı kullanıcı bulunamadı",
                                style: TextStyle(fontSize: 25),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    onRefresh: () => _kullanicilarPageYenile(),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  void _chatPage(
      BuildContext context, UserViewModel userModel, MyUser anlikUser) {
    Navigator.of(context, rootNavigator: true).push(
      MaterialPageRoute(
        builder: (context) => KonusmaPage(
          currentUser: userModel.user!,
          sohbetEdilenUser: anlikUser,
        ),
      ),
    );
  }

  Future<void> _kullanicilarPageYenile() async {
    setState(() {});
  }
}
