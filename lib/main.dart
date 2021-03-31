import 'package:ezparking/Boundary/LandingPage.dart';
import 'package:ezparking/Services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';

import 'package:ezparking/Services/ApiService.dart';
import 'package:flutter/material.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  updateCurrentSlot();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LandingPage(auth: Auth()),
    );
  }
}
