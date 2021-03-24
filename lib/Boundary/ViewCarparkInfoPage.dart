import 'package:ezparking/Services/Auth.dart';
import 'package:ezparking/Utils/NavDrawer.dart';
import 'package:ezparking/Utils/StarDisplay.dart';
import 'package:flutter/material.dart';

import 'package:ezparking/Entity/Carpark.dart';
import 'package:ezparking/Entity/Review.dart';

import 'package:ezparking/Entity/Carpark.dart';


Column buildButtonColumn(Color color, IconData icon, String label, VoidCallback onPress) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      IconButton(icon: Icon(icon), color: color, onPressed: onPress),
      Container(
        margin: const EdgeInsets.only(top: 0),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: color,
          ),
        ),
      ),
    ],
  );
}

class CarparkInfoPage extends StatelessWidget{
  CarparkInfoPage({Key key, @required this.auth, @required this.carpark, @required this.review}) : super(key: key);
  final AuthBase auth;
  final Carpark carpark;
  final Review review;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          drawer: NavDrawer(auth: auth),
          appBar: AppBar(
            title: Text('Carpark Infomation'),
            backgroundColor: Colors.amber.shade300,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                titleSection("Carpark Number", carpark.carParkNo, Icon(
                  Icons.car_rental,
                  color: Colors.red[500],
                ),),
                titleSection("Carpark address", carpark.address, Icon(
                  Icons.home,
                  color: Colors.red[500],
                ),),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Current Slot", style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(carpark.currentSlot.toString(), style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Total capacity", style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(carpark.maxSlot.toString(), style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("Distance", style: TextStyle(fontSize: 10)),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text("0.45km", style: TextStyle(fontSize: 20)),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                titleSection("Carpark Type", carpark.carParkType, Icon(
                  Icons.merge_type,
                  color: Colors.red[500],
                ),),
                titleSection("Short Term Parking", carpark.shortTermParking, Icon(
                  Icons.terrain,
                  color: Colors.red[500],
                ),),
                titleSection("Free Parking", carpark.freeParking, Icon(
                  Icons.money_off,
                  color: Colors.red[500],
                ),),
                titleSection("Night Parking", carpark.nightParking, Icon(
                  Icons.nightlight_round,
                  color: Colors.red[500],
                ),),
                titleSection("Carpark Decks", carpark.carParkDecks.toString()+" layers", Icon(
                  Icons.stairs_rounded,
                  color: Colors.red[500],
                ),),
                titleSection("Gantry height", carpark.gantryHeight.toString()+"m", Icon(
                  Icons.height,
                  color: Colors.red[500],
                ),),
                titleSection("Carpark basement", carpark.carParkBasement, Icon(
                  Icons.stairs_sharp,
                  color: Colors.red[500],
                ),),
                titleSection("Review", "Security", buildStarReview(review.cost)),
                titleSection("Review", "Convenience", buildStarReview(review.convenience)),
                titleSection("Review", "Security", buildStarReview(review.security)),
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButtonColumn(Colors.blue.shade300, Icons.call, 'CALL', (){}),
                      buildButtonColumn(Colors.blue.shade300, Icons.near_me, 'ROUTE', (){}),
                      buildButtonColumn(Colors.blue.shade300, Icons.share, 'SHARE',(){}),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  Widget titleSection(String title, String displaytext, Widget icon){
    return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  displaytext,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          icon,

        ],
      ),
    );
  }
  Widget buildStarReview(int mark){
    return IconTheme(
      data: IconThemeData(
        color: Colors.amber,
        size: 15,
      ),
      child: StarDisplay(value: mark),
    );
  }
}