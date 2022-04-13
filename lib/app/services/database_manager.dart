import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tafseer/app/assets/constants.dart';
import 'package:tafseer/app/models/ayat_model.dart';
import 'package:tafseer/app/models/index_model.dart';

class DatabaseManager extends GetxService {
  late Database _database;

  Future<DatabaseManager> initializeDatabase() async {
    String databasesPath;

    databasesPath = await getDatabasesPath();

    final path = join(databasesPath, Constants.db);

    // Check if the database exists
    final exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      final ByteData data = await rootBundle.load(join("assets", Constants.db));
      final List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    }

    _database = await openDatabase(path);
    return this;
  }

  Future<List<IndexModel>> getIndexes(String table) async {
    final mapList = await _database.query(table);

    return mapList.map((e) => IndexModel.fromMapObject(e)).toList();
  }

  Future<List<AyatModel>> getAyatList(String where, int? equal) async {
    final mapList = await _database.query(
      Constants.ayatTable,
      where: "$where = ?",
      whereArgs: [equal],
    );

    return mapList.map((e) => AyatModel.fromMapObject(e)).toList();
  }

  Future<AyatModel> dailyAyah() async {
    final mapList = await _database.rawQuery(
        "SELECT * FROM ${Constants.ayatTable} ORDER BY RANDOM() LIMIT 1");

    return mapList
        .map(
          (e) => AyatModel.fromMapObject(e),
        )
        .toList()
        .first;
  }

  Future<List<AyatModel>> getBookmarks() async {
    final mapList = await _database.query(
      Constants.ayatTable,
      where: "${Constants.isBookmark} = ?",
      whereArgs: ["1"],
    );
    return mapList
        .map(
          (e) => AyatModel.fromMapObject(e),
        )
        .toList();
  }

  Future<int> updateAyat(AyatModel ayatModel) async {
    return _database.update(
      Constants.ayatTable,
      ayatModel.toMap(),
      where: "${Constants.id} = ?",
      whereArgs: [ayatModel.id],
    );
  }

  Future<List<AyatModel>> search(String where, List<dynamic> whereArgs) async {
    final mapList = await _database.query(
      Constants.ayatTable,
      where: where,
      whereArgs: whereArgs,
    );

    return mapList.map((e) => AyatModel.fromMapObject(e)).toList();
  }
}
