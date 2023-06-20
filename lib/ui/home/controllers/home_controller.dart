import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/category_table.dart';
import 'package:kids_playroom/utils/constant.dart';

class HomeController extends GetxController {
  List<CategoryTable>? categoryList = [];


  @override
  void onInit() {
     getDataFromDatabase();
    super.onInit();
  }

  Future<void> getDataFromDatabase() async {
    categoryList = await DataBaseHelper().getCategoryData();
    print(":: ::: ::: $categoryList");
    update([Constant.idHomePage]);
  }

}
