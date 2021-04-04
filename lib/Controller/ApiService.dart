import 'dart:async' show Timer;
import 'dart:convert';
import 'package:ezparking/Controller/CarparkDatabase.dart';
import 'package:http/http.dart' as http;

class ApiService {
  void loadCarparkList() async {
    var _carparkDB = CarparkDataBase();
    List<String> _firstList = [];
    List<int> _secondList = [];
    var _response = await http.get(
        Uri.encodeFull(
            "https://api.data.gov.sg/v1/transport/carpark-availability"),
        headers: {"Accept": "application/json"});
    if (_response.statusCode == 200) {
      var jsonBody = await jsonDecode(_response.body) as Map;
      for (var obj in jsonBody["items"][0]["carpark_data"]) {
        _firstList.add(obj["carpark_number"]);
        _secondList.add(int.parse(obj["carpark_info"][0]["lots_available"]));
      }
      Map<String, int> map = Map.fromIterables(_firstList, _secondList);
      _carparkDB.updateCarParkSlotbyID(map);
    }
  }


  void updateCurrentSlot() async {
    const period = const Duration(seconds: 10);
    new Timer.periodic(period, (Timer t) async {
      loadCarparkList();
    });
  }
}
