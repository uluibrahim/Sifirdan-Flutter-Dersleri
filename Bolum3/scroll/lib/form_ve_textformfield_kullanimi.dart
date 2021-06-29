import 'package:flutter/material.dart';

class TextFormFieldKullanimi extends StatefulWidget {
  @override
  _TextFormFieldKullanimiState createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
  String _ad, _email, _password;
  AutovalidateMode autoControl = AutovalidateMode.disabled;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: Theme.of(context).copyWith(primaryColor: Colors.indigoAccent),
        child: Scaffold(
          floatingActionButton: fab(),
          appBar: appBar(),
          body: buildBody(),
        ),
      ),
    );
  }

  FloatingActionButton fab() {
    return FloatingActionButton(
      onPressed: () {},
      child: Icon(Icons.save),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Flexible(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              //autovalidate: true,
              autovalidateMode: autoControl,
              child: buildListView(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: _girisBilgileriniOnayla,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Kaydet",
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  ListView buildListView() {
    return ListView(
      children: [
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.account_circle),
            hintText: "Ad",
            labelText: "Adınızı yazınız",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (String value) {
            if (value.length < 6) {
              return "Hatalı giriş";
            } else {
              return null;
            }
          },
          onSaved: (value) => _ad = value,
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.mail),
            hintText: "Emaiil",
            labelText: "E-mail giriniz",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (value) {
            if (!value.contains("@")) {
              return "Hata";
            } else {
              return null;
            }
          },
          onSaved: (value) => _email = value,
        ),
        SizedBox(height: 10),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.lock_open_sharp),
            hintText: "Şifre",
            labelText: "Şifrenizi giriniz",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
          validator: (value) {
            if (value.length < 6) {
              return "Hatalı";
            } else {
              return null;
            }
          },
          onSaved: (value) => _password = value,
        ),
      ],
    );
  }

  void _girisBilgileriniOnayla() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      print("ad: $_ad Email: $_email Şifre $_password");
    }
    setState(() {
      autoControl = AutovalidateMode.onUserInteraction;
    });
  }

  AppBar appBar() => AppBar(title: Text("Text Form Field"));
}
