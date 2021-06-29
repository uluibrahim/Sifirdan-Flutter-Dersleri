import 'package:flutter/material.dart';

class TextFormFieldKullanimi extends StatefulWidget {
  @override
  _TextFormFieldKullanimiState createState() => _TextFormFieldKullanimiState();
}

class _TextFormFieldKullanimiState extends State<TextFormFieldKullanimi> {
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
    return Padding(
      padding: EdgeInsets.all(20),
      child: buildListView(),
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
        ),
      ],
    );
  }

  AppBar appBar() => AppBar(title: Text("Text Form Field"));
}
