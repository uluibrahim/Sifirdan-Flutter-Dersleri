import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefKullanimi extends StatefulWidget {
  SharedPrefKullanimi({Key? key}) : super(key: key);

  @override
  _SharedPrefKullanimiState createState() => _SharedPrefKullanimiState();
}

class _SharedPrefKullanimiState extends State<SharedPrefKullanimi> {
  String? isim;
  int? id;
  var cinsiyet;
  var mySharedPreferences;

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance()
        .then((value) => mySharedPreferences = value);
  }

  @override
  void dispose() {
    mySharedPreferences.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared Preferences'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: isimTextFormField(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: idTextFormField(),
                ),
                cinsiyetRow(),
                elevatedButtonRow()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row elevatedButtonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: _ekle,
          child: Text("Ekle"),
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
        ElevatedButton(
          onPressed: _goster,
          child: Text("Goster"),
          style: ElevatedButton.styleFrom(primary: Colors.blue),
        ),
        ElevatedButton(
          onPressed: _sil,
          child: Text("Sil"),
          style: ElevatedButton.styleFrom(primary: Colors.red),
        ),
      ],
    );
  }

  TextFormField isimTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "isim",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: (value) {
        isim = value;
      },
    );
  }

  TextFormField idTextFormField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "id",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSaved: (value) {
        id = int.parse(value!);
      },
    );
  }

  Row cinsiyetRow() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RadioListTile(
              value: false,
              groupValue: cinsiyet,
              title: Text("Kadın"),
              onChanged: (value) {
                setState(() {
                  cinsiyet = value;
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RadioListTile(
              value: true,
              groupValue: cinsiyet,
              title: Text("Erkek"),
              onChanged: (value) {
                setState(() {
                  cinsiyet = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  void _ekle() async {
    formKey.currentState!.save();
    await (mySharedPreferences as SharedPreferences).setString("myName", isim!);
    await (mySharedPreferences as SharedPreferences).setInt("myId", id!);
    await (mySharedPreferences as SharedPreferences)
        .setBool("myCinsiyet", cinsiyet);
  }

  void _goster() {
    debugPrint((mySharedPreferences as SharedPreferences)
        .getString("myName")
        .toString());
    debugPrint("id: " +
        (mySharedPreferences as SharedPreferences).getInt("myId").toString());
    debugPrint("Cinsiyet erkek mi? : " +
        (mySharedPreferences as SharedPreferences)
            .getBool("myCinsiyet")
            .toString());
  }

  void _sil() {
    (mySharedPreferences as SharedPreferences).remove("myName");
    (mySharedPreferences as SharedPreferences).remove("myId");
    (mySharedPreferences as SharedPreferences).remove("myCinsiyet");
  }
}
