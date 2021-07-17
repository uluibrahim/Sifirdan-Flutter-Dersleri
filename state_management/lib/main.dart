import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:state_management/models/auth_service.dart';
import 'package:state_management/models/counter.dart';

import 'view/bloc_kullanimi.dart';
import 'view/provider_with_counter.dart';
import 'package:provider/provider.dart';

import 'view/stream_kullanimi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Material App Bar')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                _multiProviderPage();
              },
              child: Text("Provider ile sayac app"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => StreamKullanimi()));
              },
              child: Text("Sream kullanımı"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BlocKullanimi()));
              },
              child: Text("Bloc kullanımı"),
            ),
          ],
        ),
      ),
    );
  }

  void _multiProviderPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => Counter(0)),
            ChangeNotifierProvider(create: (context) => AuthService()),
          ],
          child: ProviderWithCounter(),
        ),
      ),
    );
  }
}
