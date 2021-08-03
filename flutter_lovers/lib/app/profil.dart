import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_lovers/common_widget/platform_duyarli_widgetler/platform_duyarli_alert_dialog.dart';
import 'package:flutter_lovers/common_widget/social_login_in_button.dart';
import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilPage extends StatefulWidget {
  @override
  _ProfilPageState createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  TextEditingController? _userNameController;
  XFile? _profilPhoto;

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    print("User profil:" + _userModel.user.toString());
    _userNameController!.text = _userModel.user!.userName.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
        actions: [
          TextButton(
            onPressed: () => _cikisOnayi(context, _userModel),
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 65,
                    backgroundImage: imageProvider(_userModel),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.25,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            ListTile(
                              leading: Icon(Icons.camera),
                              title: Text("Kameradan seç"),
                              onTap: () {
                                _kameradanFotoSec();
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.image),
                              title: Text("Galeriden seç"),
                              onTap: () {
                                _galeridenFotoSec();
                              },
                            ),
                          ]),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: _userModel.user!.email.toString(),
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _userNameController,
                  decoration: InputDecoration(
                    labelText: "User Nmae",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SocialLoginButton(
                buttonText: "Değişiklikleri kaydet",
                onPressed: () {
                  _userNameGuncelle(context, _userModel);
                  _profilPhotoGuncelle(context, _userModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _cikisYap(UserViewModel userModel, BuildContext context) async {
    bool sonuc = await userModel.signOut();
    return sonuc;
  }

  Future<bool> _cikisOnayi(
      BuildContext context, UserViewModel userModel) async {
    bool result = await PlatformDuyarliAlertDialog(
      title: "Çıkış onayı",
      contentText: "Çıkışı onaylıyor musunuz?",
      basicButtonText: "Onayla",
      cancelButtonText: "Vazgeç",
    ).dialogGoster(context);
    if (result) {
      _cikisYap(userModel, context);
    }
    return result;
  }

  Future<void> _userNameGuncelle(
      BuildContext context, UserViewModel userModel) async {
    if (userModel.user!.userName != _userNameController!.text) {
      bool updateResult = await userModel.updateUserName(
          _userNameController!.text, userModel.user!.userId.toString());

      print("update result profil $updateResult");
      if (updateResult == true) {
        userModel.user!.userName = _userNameController!.text.toString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("user name update işlemi başarılı"),
              duration: Duration(milliseconds: 1200)),
        );
      } else {
        print("başarısız ");
        _userNameController!.text = userModel.user!.userName.toString();
        await PlatformDuyarliAlertDialog(
          title: "User Name Update",
          contentText: "User name zaten kullanılmakta",
          basicButtonText: "Tamam",
        ).dialogGoster(context);
      }
    }
  }

  void _kameradanFotoSec() async {
    Navigator.of(context).pop();
    ImagePicker _picker = ImagePicker();
    XFile? _newPhoto = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _profilPhoto = _newPhoto;
    });
  }

  void _galeridenFotoSec() async {
    Navigator.of(context).pop();
    ImagePicker _picker = ImagePicker();
    XFile? _newPhoto = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _profilPhoto = _newPhoto;
    });
  }

  ImageProvider imageProvider(UserViewModel userModel) {
    if (_profilPhoto == null) {
      return NetworkImage(userModel.user!.profilURL.toString());
    } else {
      return FileImage(File(_profilPhoto!.path));
    }
  }

  void _profilPhotoGuncelle(
      BuildContext context, UserViewModel userModel) async {
    if (_profilPhoto != null) {
      String url = await userModel.uploadFile(
          userModel.user!.userId, "profil_photo", _profilPhoto!);
      print("gelen url: $url");
      if (url != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Profil photo update işlemi başarılı"),
              duration: Duration(milliseconds: 1200)),
        );
      }
    }
  }
}
