import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Ubuntu"),
      title: 'Tasarım',
      home: SafeArea(
        child: Scaffold(
          drawer: Drawer(
            semanticLabel: "saknlcmasşl",
            child: Column(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text("İbrahim Halil ULU"),
                  accountEmail: Text("ibrahimhalillulu@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage:
                        NetworkImage("https://picsum.photos/200/300"),
                  ),
                  currentAccountPictureSize: Size.square(80),
                  otherAccountsPictures: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text("HU"),
                    ),
                    CircleAvatar(
                      child: Text("İU"),
                      backgroundColor: Colors.white,
                    ),
                  ],
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade400,
                  ),
                  onDetailsPressed: () {
                    print("Detail");
                  },
                ),
                Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                          leading: Icon(Icons.account_box),
                          title: Text("Profil")),
                      ListTile(
                          leading: Icon(Icons.home), title: Text("Anasayfa")),
                      ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Ayarlar")),
                      ListTile(
                          leading: Icon(Icons.account_box),
                          title: Text("Profil")),
                      ListTile(
                          leading: Icon(Icons.home), title: Text("Anasayfa")),
                      InkWell(
                        onTap: () {},
                        splashColor: Colors.red,
                        child: ListTile(
                          leading: Icon(Icons.settings),
                          title: Text("Ayarlar"),
                        ),
                      ),
                    ],
                  ),
                ),
                AboutListTile(
                  applicationName: "Tasarım App",
                  applicationIcon: Icon(Icons.palette),
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: Text(
              'Tasarımı kolaylaştıran yapılar',
              style: TextStyle(fontFamily: "Dancing", fontSize: 25),
            ),
          ),
          body: Center(
            child: Container(
              child: Column(
                children: [
                  Text(
                    'Hello World',
                    style: TextStyle(
                      fontFamily: "Ubuntu",
                      fontSize: 35,
                    ),
                  ),
                  Text(
                    'Hello World',
                    style: TextStyle(
                        fontFamily: "Ubuntu",
                        fontSize: 35,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Hello World',
                    style: TextStyle(
                        fontFamily: "Dancing",
                        fontSize: 35,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'theme da tanımlanan tip ',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
