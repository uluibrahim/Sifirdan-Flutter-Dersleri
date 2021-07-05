import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:json_http/models/gonderi.dart';

class RemoteApiKullanimi extends StatefulWidget {
  RemoteApiKullanimi({Key? key}) : super(key: key);

  @override
  _RemoteApiKullanimiState createState() => _RemoteApiKullanimiState();
}

class _RemoteApiKullanimiState extends State<RemoteApiKullanimi> {
  Future<List<Gonderi>> _gonderiGetir() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
    if (response.statusCode == 200) {
      //return Gonderi.fromJson(jsonDecode(response.body));
      return (json.decode(response.body) as List)
          .map((tekSatirGonderi) => Gonderi.fromJson(tekSatirGonderi))
          .toList();
    } else {
      throw Exception("Bağlanamadık ${response.statusCode}");
    }
  }

  Gonderi? gonderi1;

  @override
  void initState() {
    super.initState();
    /**
  _gonderiGetir().then((value) {
      gonderi1 = value;
      print(gonderi1!.id);
    });
     */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Remote api kullanımı")),
      body: Container(
        child: FutureBuilder(
          builder: (context, AsyncSnapshot<List<Gonderi>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title.toString()),
                    subtitle: Text(snapshot.data![index].body.toString()),
                    leading: CircleAvatar(
                      child: Text(snapshot.data![index].id.toString()),
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
            } else if (snapshot.hasError) {
              throw Exception("Bağlanamadık ");
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: _gonderiGetir(),
        ),
      ),
    );
  }
}
