import 'package:ezparking/Boundary/LandingPage.dart';
import 'package:ezparking/Controller/ReviewDatabse.dart';
import 'package:ezparking/Services/Auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'dart:async';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:ezparking/Entity/Carpark.dart';
import 'dart:async';
import 'package:ezparking/Controller/CarparkDatabase.dart';

Future<List> _loadCSV() async {
  final _rawData = await rootBundle.loadString("assets/hdb-carpark-information.csv");
  List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
  return _listData;
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  LandingPage(auth: Auth()),
    );
  }
}

