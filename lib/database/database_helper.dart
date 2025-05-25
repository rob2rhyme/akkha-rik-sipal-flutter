//lib/database/database_helper.dart
import 'package:flutter/services.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/alphabets_table.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/drag_item_table.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/item_table.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/paint_table.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/sub_category_table.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/vide_table.dart';
import 'package:path/path.dart' as path;
import 'dart:io' as io;

import 'package:sqflite/sqflite.dart';
import 'tables/category_table.dart';
import 'tables/spelling_table.dart';

class DataBaseHelper {
  static final DataBaseHelper instance = DataBaseHelper.internal();

  factory DataBaseHelper() => instance;

  Database? _db;

  DataBaseHelper.internal();

  Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await init();
    return _db!;
  }

  Future<Database> init() async {
    var dbPath = await getDatabasesPath();
    String dbPathKidsAllInOne = path.join(dbPath, "KidsPlayroom.db");

    bool dbExistsEnliven = await io.File(dbPathKidsAllInOne).exists();

    if (!dbExistsEnliven) {
      ByteData data = await rootBundle.load(
        path.join("assets/database", "KidsPlayroom.db"),
      );
      List<int> bytes = data.buffer.asUint8List(
        data.offsetInBytes,
        data.lengthInBytes,
      );

      await io.File(dbPathKidsAllInOne).writeAsBytes(bytes, flush: true);
    }

    return _db = await openDatabase(dbPathKidsAllInOne);
  }

  String categoryTable = "CategoryTable";
  String dragCategoryTable = "DragCategoryTable";
  String subcategoryTable = "SubCategoryTable";
  String kidVideoTable = "KidsVideoTable";
  String itemTable = "ItemTable";
  String dragItemTable = "DragItemsTable";
  String paintTable = "PaintTable";
  String quizTable = "QuizTable";
  String alphabetsTable = "DragAlphabetsTable";
  String spellingTable = "DragSpellingTable";
  String subCategoryName = "sub_category_name";
  String dragSubCategoryName = "category_name";

  Future<List<CategoryTable>> getCategoryData() async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery("SELECT * FROM $categoryTable");

    return maps.map((e) => CategoryTable.fromJson(e)).toList();
  }

  Future<List<SubCategoryTable>> getSubCategoryData() async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery(
      "SELECT * FROM $subcategoryTable ORDER BY $subCategoryName ASC",
    );

    return maps.map((e) => SubCategoryTable.fromJson(e)).toList();
  }

  Future<List<ItemTable>> getItemData(int subcategoryId) async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery(
      "SELECT * FROM $itemTable WHERE sub_category_id = $subcategoryId",
    );

    return maps.map((e) => ItemTable.fromJson(e)).toList();
  }

  Future<List<PaintTable>> getPaintData() async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery("SELECT * FROM $paintTable");

    return maps.map((e) => PaintTable.fromJson(e)).toList();
  }

  Future<List<CategoryTable>> getDragCategoryData() async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery("SELECT * FROM $dragCategoryTable");

    return maps.map((e) => CategoryTable.fromJson(e)).toList();
  }

  Future<List<DragItemTable>> getDragItemData(int subcategoryId) async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery(
      "SELECT * FROM $dragItemTable WHERE category_id = $subcategoryId",
    );

    return maps.map((e) => DragItemTable.fromJson(e)).toList();
  }

  Future<List<AlphabetsTable>> getAlphabetsData() async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery("SELECT * FROM $alphabetsTable");

    return maps.map((e) => AlphabetsTable.fromJson(e)).toList();
  }

  Future<List<SpellingTable>> getSpellingData() async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery("SELECT * FROM $spellingTable");

    return maps.map((e) => SpellingTable.fromJson(e)).toList();
  }

  Future<List<VideoTable>> getVideo(int catId) async {
    final dbClient = await db;
    final maps = await dbClient.rawQuery(
      "SELECT * FROM $kidVideoTable WHERE id = $catId",
    );

    return maps.map((e) => VideoTable.fromJson(e)).toList();
  }
}
