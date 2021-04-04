import 'package:ezparking/Boundary/LandingPage.dart';
import 'package:ezparking/Controller/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:ezparking/Controller/ApiService.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  ApiService().updateCurrentSlot();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(auth: Auth()),
    );
  }
}
