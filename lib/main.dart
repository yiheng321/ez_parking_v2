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
  var carparkDB = CarparkDataBase();
  // get all carparks
  final allCarparks = await carparkDB.getAllCarpark();
  // update all the carpark's maxSlot from 0 to 10
  for (var i =0; i < allCarparks.length; i++){
    var tmpcarPark = allCarparks[i];
    tmpcarPark.maxSlot = 10;
    carparkDB.updateCarPark(tmpcarPark);
  }
  // validate the updating result
  for (var i =0; i < allCarparks.length; i++){
    var tmpcarPark = allCarparks[i];
    var carparkNo = tmpcarPark.carParkNo;
    var maxSlot = tmpcarPark.maxSlot;
    print("$carparkNo's maxSlot update to: $maxSlot");
  }

  // demo to get all carpark within certain radius
  final allCarparksInRadius = await carparkDB.getCarparkByRadius(28000, 38000, 29000, 39000);
  for(var carpark in allCarparksInRadius){
    var carparkNo = carpark.carParkNo;
    var xCoord = carpark.xCoord;
    var yCoord = carpark.yCoord;
    var address = carpark.address;
    print("$carparkNo xCoord: $xCoord, yCoord: $yCoord address: $address");
  }

  // demo for the review, similiar as the carpark database
  var reviewDB = ReviewDataBase();
  final allReviews = await reviewDB.getAllReview();
  for (var review in allReviews){
    var carparkNo = review.carParkNo;
    var cost = review.cost;
    print("$carparkNo's cost review is $cost");
  }

}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home:  LandingPage(auth: Auth()),
    );
  }
}

