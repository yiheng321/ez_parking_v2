class APIInfo {
  final List<Item> items;

  APIInfo({this.items});

  factory APIInfo.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['items'] as List;
    print(list.runtimeType);
    List<Item> itemList = list.map((i) => Item.fromJson(i)).toList();
    //List<CarparkData> carparkdatas = new List();
    // carparkdatas = list.map((i)=>CarparkData.fromJson(i)).toList();
    return APIInfo(items: itemList);
  }
}

class Item {
  final String timestamp;
  final List<CarparkData> carparkData;

  Item({this.timestamp, this.carparkData});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['carpark_data'] as List;
    print(list.runtimeType);
    List<CarparkData> carparkDataList =
        list.map((i) => CarparkData.fromJson(i)).toList();
    return Item(
        timestamp: parsedJson['timestamp'], carparkData: carparkDataList);
  }
}

class CarparkData {
  final String carpark_number, updateDatetime;
  final List<CarparkInfo> carpark_info;

  CarparkData({this.carpark_number, this.updateDatetime, this.carpark_info});

  factory CarparkData.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['carpark_info'] as List;
    print(list.runtimeType);
    List<CarparkInfo> cpInfoList =
        list.map((i) => CarparkInfo.fromJson(i)).toList();
    return CarparkData(
        carpark_number: parsedJson['carpark_number'] as String,
        updateDatetime: parsedJson['update_datetime'],
        carpark_info: cpInfoList);
  }
}

class CarparkInfo {
  final String total_lots, lot_type, lots_available;

  CarparkInfo({this.total_lots, this.lot_type, this.lots_available});

  factory CarparkInfo.fromJson(Map<String, dynamic> parsedJson) {
    return CarparkInfo(
        total_lots: parsedJson['total_lots'],
        lot_type: parsedJson['lot_type'],
        lots_available: parsedJson['lots_available']);
  }
}
