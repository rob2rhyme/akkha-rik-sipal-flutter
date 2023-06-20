import 'package:flutter/services.dart';
import 'package:kids_playroom/database/tables/item_table.dart';
import 'package:kids_playroom/database/tables/sub_category_table.dart';

import 'package:path/path.dart' as path;
import 'dart:io' as io;

import 'package:sqflite/sqflite.dart';

import 'tables/category_table.dart';

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

  init() async {
    var dbPath = await getDatabasesPath();

    String dbPathKidsAllInOne = path.join(dbPath, "KidsPlayroom.db");

    bool dbExistsEnliven = await io.File(dbPathKidsAllInOne).exists();

    if (!dbExistsEnliven) {
      ByteData data = await rootBundle
          .load(path.join("assets/database", "KidsPlayroom.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      await io.File(dbPathKidsAllInOne).writeAsBytes(bytes, flush: true);
    }

    return _db = await openDatabase(dbPathKidsAllInOne);
  }

  String categoryTable = "CategoryTable";
  String subcategoryTable = "SubCategoryTable";

  String itemTable = "ItemTable";
  String quizTable = "QuizTable";

  Future<List<CategoryTable>> getCategoryData() async {
    List<CategoryTable> categoryList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
    await dbClient.rawQuery("SELECT * FROM $categoryTable");
    if (maps.isNotEmpty) {
      for (var answer in maps) {
        var categoryData = CategoryTable.fromJson(answer);
        categoryList.add(categoryData);
      }

    }

    return categoryList;
  }
  Future<List<SubCategoryTable>> getSubCategoryData() async {
    List<SubCategoryTable> subcategoryList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
    await dbClient.rawQuery("SELECT * FROM $subcategoryTable");
    if (maps.isNotEmpty) {
      for (var answer in maps) {
        var categoryData = SubCategoryTable.fromJson(answer);
        subcategoryList.add(categoryData);
      }
    }

    return subcategoryList;
  }
  Future<List<ItemTable>> getItemData(int subcategoryId) async {
    List<ItemTable> itemList = [];
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
    await dbClient.rawQuery("SELECT * FROM $itemTable where sub_category_id = $subcategoryId");
    if (maps.isNotEmpty) {
      for (var answer in maps) {
        var itemData = ItemTable.fromJson(answer);
        itemList.add(itemData);
      }
    }

    return itemList;
  }
}
