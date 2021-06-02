import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partner_with_us/homePage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp firebaseApp = await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Partner With Us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Partner With Us'),
    );
  }
}
