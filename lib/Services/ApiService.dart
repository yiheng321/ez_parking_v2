import 'dart:async' show Timer;
import 'dart:convert';
import 'package:ezparking/Controller/CarparkDatabase.dart';
import 'package:http/http.dart' as http;

void loadCarparkList() async {
  var carparkDB = CarparkDataBase();
  List firstList;
  List secondList;
  var response = await http.get(
      Uri.encodeFull(
          "https://api.data.gov.sg/v1/transport/carpark-availability"),
      headers: {"Accept": "application/json"});
  if (response.statusCode == 200) {
    var jsonBody = await jsonDecode(response.body) as Map;
    for (var obj in jsonBody["items"][0]["carpark_data"]) {
      firstList.add(obj["carpark_number"]);
      secondList.add(int.parse(obj["carpark_info"][0]["lots_available"]));
    }
    Map map = Map.fromIterables(firstList, secondList);
    carparkDB.updateCarParkSlotbyID(map);
  }
}

void updateCurrentSlot() async {
  const period = const Duration(seconds: 10);
  new Timer.periodic(period, (Timer t) async {
    loadCarparkList();
  });
}
