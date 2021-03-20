import 'dart:async';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ezparking/Entity/Carpark.dart';

class DBHelper {
  static Database _db;
  static const String id = 'id';
  static const String carParkNo = 'carParkNo';
  static const String address = 'address';
  static const String xCoord = 'xCoord';
  static const String yCoord = 'yCoord';
  static const String carParkType = 'carParkType';
  static const String shortTermParking = 'shortTermParking';
  static const String freeParking = 'freeParking';
  static const String nightParking = 'nightParking';
  static const String carParkDecks = 'carParkDecks';
  static const String gantryHeight = 'gantryHeight';
  static const String carParkBasement = 'carParkBasement';
  static const String maxSlot = 'maxSlot';
  static const String currentSlot = 'currentSlot';
  static const String TABLE = 'Carpark';
  static const String DB_NAME = 'Carpark.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {

    String path = join("assets", DB_NAME);
    var db = await openDatabase(path, version: 1);
    return db;
  }

  Future<Carpark> save(Carpark carpark) async {
    var dbClient = await db;
    carpark.id = await dbClient.insert(TABLE, carpark.toMap());
    return carpark;
    /*
    await dbClient.transaction((txn) async {
      var query = "INSERT INTO $TABLE ($NAME) VALUES ('" + employee.name + "')";
      return await txn.rawInsert(query);
    });
    */
  }

  Future<List<Carpark>> getCarpark() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [id, carParkNo, address,xCoord,yCoord,carParkType,shortTermParking,freeParking,nightParking,carParkDecks,gantryHeight,carParkBasement,maxSlot,currentSlot]);
    //List<Map> maps = await dbClient.rawQuery("SELECT * FROM $TABLE");
    List<Carpark> carparks = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        carparks.add(Carpark.fromMap(maps[i]));
      }
    }
    return carparks;
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$id = ?', whereArgs: [id]);
  }

  Future<int> update(Carpark carpark) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, carpark.toMap(),
        where: '$id = ?', whereArgs: [carpark.id]);
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}