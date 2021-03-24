import 'dart:io';

import 'package:path/path.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tafseer_hafiz_abdusalam/models/index_model.dart';
import 'package:tafseer_hafiz_abdusalam/assets/constants.dart';
import 'package:tafseer_hafiz_abdusalam/models/ayat_model.dart';

class DbManager {
  static DbManager _db;
  static Database _database;

  DbManager._createInstance();

  factory DbManager() {
    if (_db == null) {
      _db = DbManager._createInstance();
    }
    return _db;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {

    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, Constants.db);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "tafsir.db"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);

    }

    return await openDatabase(path);
  }

  Future<List<IndexModel>> getIndexes(String table) async {
    Database db = await this.database;
    var mapList = await db.query(table);


    List<IndexModel> list = [];

    for (var obj in mapList){
      list.add(IndexModel.fromMapObject(obj));

    }
    return list;

  }

  Future<List<AyatModel>> getAyatList(String where, int equal) async {
    Database db = await this.database;
    var mapList = await db.query(Constants.ayatTable,where: "$where = ?",whereArgs: [equal]);


    List<AyatModel> list = [];

    for (var obj in mapList){
      list.add(AyatModel.fromMapObject(obj));

    }
    return list;

  }


}
