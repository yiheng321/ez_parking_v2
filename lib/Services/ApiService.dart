import 'dart:async' show Future, Timer;
import 'dart:convert';
import 'package:ezparking/Entity/CarparkInfo.dart';
import 'package:http/http.dart' as http;

Future<List<CarparkData>> loadCarparkList() async {
  List<CarparkData> _carparkData = [];

  var response = await http.get(
      Uri.encodeFull(
          "https://api.data.gov.sg/v1/transport/carpark-availability"),
      headers: {"Accept": "application/json"});
  var json = await jsonDecode(response.body);
  APIInfo apiInfo = new APIInfo.fromJson(json);

  _carparkData.addAll(apiInfo.items[0].carparkData);

  return _carparkData;
}

void carparkList() async {
  List<CarparkData> _carparks = <CarparkData>[];
  List<String> _total_lots = <String>[];
  List<String> _av_lots = <String>[];
  List<String> _carparkID = <String>[];

  const oneSec = const Duration(seconds: 300);
  new Timer.periodic(oneSec, (Timer t) async {
    _total_lots.clear();
    _av_lots.clear();
    _carparks.clear();
    _carparkID.clear();

    final List<CarparkData> carparks = await loadCarparkList();
    _carparks.addAll(carparks);
    for (int i = 0; i < _carparks.length; i++) {
      _total_lots.add(_carparks[i].carpark_info[0].total_lots);
      _av_lots.add(_carparks[i].carpark_info[0].lots_available);
      _carparkID.add(_carparks[i].carpark_number);
    }

  });
}
