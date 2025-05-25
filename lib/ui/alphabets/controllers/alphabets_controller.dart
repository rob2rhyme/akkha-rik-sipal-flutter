import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/database/database_helper.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/alphabets_table.dart';
import 'package:akkha_rik_lipi_sipal/utils/utils.dart';

class AlphabetsController extends GetxController {
  PageController? pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );
  List<AlphabetsTable>? alphabetsList = [];
  bool? isShow = false;
  Color? currentColor = Utils.colorList["orange"];
  dynamic args = Get.arguments;
  String? title;
  int? catId;

  @override
  void onInit() {
    getDataFromArgs();
    getDataFromDatabase();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        title = args[0];
      }
      if (args[1] != null) {
        catId = args[1];
      }
    }
  }

  getDataFromDatabase() async {
    alphabetsList = await DataBaseHelper().getAlphabetsData();
    update();
  }
}
