import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management/models/auth_service.dart';
import 'package:state_management/models/counter.dart';

class ProviderWithCounter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);

    switch (myAuth.userState) {
      case UserState.OturumAcikDegil:
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lütfen oturum açın..."),
                  ElevatedButton(
                    onPressed: () async {
                      myAuth.createWithEmailAndPassword(
                          "ibrahimhalillulu@gmail.com", "123456");
                    },
                    child: Text("Kaydol"),
                    style: ElevatedButton.styleFrom(primary: Colors.teal),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      myAuth.signinWithEmailAndPassword(
                          "ibrahimhalillulu@gmail.com", "123456");
                    },
                    child: Text("Oturum aç"),
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        );
      case UserState.OturumAciliyor:
        return SafeArea(
          child: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      case UserState.OturumAcik:
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text("provider ile sayac"),
            ),
            floatingActionButton: MyFabButtons(),
            body: Center(
              child: MyColumn(),
            ),
          ),
        );
      default:
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("provider ile sayac"),
      ),
      floatingActionButton: MyFabButtons(),
      body: Center(
        child: MyColumn(),
      ),
    );
  }
}

class MyFabButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var myCounter = Provider.of<Counter>(context, listen: false);
    // burada listenfalse yaparak butona her tıklandığında  build olmasını engelledik
    print("fab build");
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FloatingActionButton(
          onPressed: myCounter.arttir,
          heroTag: "fab1",
          child: Icon(Icons.add),
        ),
        SizedBox(height: 10),
        FloatingActionButton(
          onPressed: myCounter.azalt,
          heroTag: "fab2",
          child: Icon(Icons.add),
        )
      ],
    );
  }
}

class MyColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("column build");
    // var myCounter = Provider.of<Counter>(context);
    // buradaki yapı yerine watch kullanılabilir
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "User email: \n " +
              context.read<AuthService>().user!.email.toString() +
              "\n",
          style: TextStyle(fontSize: 17),
        ),
        Text(
          "Counter value: \n ",
          style: TextStyle(fontSize: 25),
        ),
        Text(
          context.watch<Counter>().counter.toString(),
          style: TextStyle(fontSize: 25),
        ),
        SizedBox(height: 40),
        ElevatedButton(
          onPressed: () async {
            context.read<AuthService>().signOut();
          },
          child: Text("Çıkış yap"),
          style: ElevatedButton.styleFrom(primary: Colors.green),
        ),
      ],
    );
  }
}
