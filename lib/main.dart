import 'package:ezparking/Pages/LoginPage.dart';
import 'package:ezparking/Pages/MapPage.dart';
import 'package:flutter/material.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MapPage(),
    );
  }
}