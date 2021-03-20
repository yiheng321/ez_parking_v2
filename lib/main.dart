// import 'dart:io';
// import 'dart:convert';
//
// import 'package:csv/csv.dart';
// import 'package:ezparking/Boundary/LoginPage.dart';
// import 'package:ezparking/Boundary/MapPage.dart';
// import 'package:flutter/services.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
//
// import 'package:ezparking/Boundary/LandingPage.dart';
// import 'package:ezparking/Services/Auth.dart';
//
// import 'package:file_picker/file_picker.dart';
// import 'dart:async';
//
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   final Future<Database> database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'car_park.db'),
//     // When the database is first created, create a table to store dogs.
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         "CREATE TABLE carparkss()",
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );
//   final csvData = await _loadCSV();
//   for(var i =0; i < csvData.length; i++){
//     print(csvData[i]);
//   }
//   runApp(MyApp());
// }
//
// Future<List> _loadCSV() async {
//   final _rawData = await rootBundle.loadString("assets/hdb-carpark-information.csv");
//   List<List<dynamic>> _listData = CsvToListConverter().convert(_rawData);
//   return _listData;
// }
// class MyApp extends StatelessWidget {
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:  LandingPage(
//         auth: Auth(),
//       ),
//     );
//   }
// }
//
//
import 'package:ezparking/Boundary/LandingPage.dart';
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

  final csvData = await _loadCSV();
  for(var i =0; i < csvData.length; i++){
    print(csvData[i]);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  LandingPage(auth: Auth()),
    );
  }
}

