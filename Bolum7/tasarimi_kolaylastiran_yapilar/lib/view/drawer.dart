import 'package:flutter/material.dart';

class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: "saknlcmasşl",
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("İbrahim Halil ULU"),
            accountEmail: Text("ibrahimhalillulu@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://picsum.photos/200/300"),
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
                    leading: Icon(Icons.account_box), title: Text("Profil")),
                ListTile(leading: Icon(Icons.home), title: Text("Anasayfa")),
                ListTile(leading: Icon(Icons.settings), title: Text("Ayarlar")),
                ListTile(
                    leading: Icon(Icons.account_box), title: Text("Profil")),
                ListTile(leading: Icon(Icons.home), title: Text("Anasayfa")),
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
    );
  }
}
