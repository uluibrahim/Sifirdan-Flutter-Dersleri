import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lovers/models/konusma_model.dart';
import 'package:flutter_lovers/viewmodel/user_viewmodel.dart';
import 'package:provider/provider.dart';

class KonusmalarimPage extends StatefulWidget {
  const KonusmalarimPage({Key? key}) : super(key: key);

  @override
  _KonusmalarimPageState createState() => _KonusmalarimPageState();
}

class _KonusmalarimPageState extends State<KonusmalarimPage> {
  @override
  Widget build(BuildContext context) {
    final _userModel = Provider.of<UserViewModel>(context);
    _konusmalarimiGetir(_userModel);
    return Scaffold(
      appBar: AppBar(
        title: Text("Konusmalarim"),
      ),
      body: FutureBuilder<List<KonusmaModel>>(
        future:
            _userModel.getAllConversations(_userModel.user!.userId.toString()),
        builder: (context, AsyncSnapshot<List<KonusmaModel>> snapshot) {
          print("snapshot boyutu   " + snapshot.data!.length.toString());
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].sonYollananMesaj.toString());
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> _konusmalarimiGetir(UserViewModel userModel) async {
    QuerySnapshot<Map<String, dynamic>> konusmalarim = await FirebaseFirestore
        .instance
        .collection("konusmalarim")
        .where("konusma_sahibi", isEqualTo: userModel.user!.userId)
        .orderBy("olusturulma_tarihi", descending: true)
        .get();
    for (var konusma in konusmalarim.docs) {
      print("konusma: " + konusma.data().toString());
    }
  }
}
