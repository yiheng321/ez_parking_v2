import 'package:ezparking/Pages/LoginPage.dart';
import 'package:ezparking/Pages/MapPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Pages/LandingPage.dart';
import 'Services/Auth.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  MapPage(
      ),
    );
  }
}