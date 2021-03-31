import 'dart:async' show Future, Timer;
import 'dart:convert';
import 'package:ezparking/Controller/CarparkDatabase.dart';
import 'package:http/http.dart' as http;


void loadCarparkList() async {
  var carparkDB = CarparkDataBase();
  var response = await http.get(
      Uri.encodeFull(
          "https://api.data.gov.sg/v1/transport/carpark-availability"),
      headers: {"Accept": "application/json"});
  if(response.statusCode == 200){
    var jsonBody = await jsonDecode(response.body) as Map;
    for(var obj in jsonBody["items"][0]["carpark_data"]){
      carparkDB.updateCarParkSlotbyID(obj["carpark_number"], int.parse(obj["carpark_info"][0]["lots_available"]));
    }
    var carparks = await carparkDB.getAllCarpark();
    for(var carpark in carparks){
      print(carpark.carParkNo+ ": "+carpark.currentSlot.toString());
    }
  }
}

void updateCurrentSlot() async {

  const period = const Duration(seconds: 15);
  new Timer.periodic(period, (Timer t) async {
      loadCarparkList();
    }
    );
}
