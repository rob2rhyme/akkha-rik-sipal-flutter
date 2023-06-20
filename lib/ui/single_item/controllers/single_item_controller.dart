import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/item_table.dart';
import 'package:kids_playroom/main.dart';
import 'package:kids_playroom/ui/items/controllers/item_controller.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/utils.dart';

class SingleItemController extends GetxController {
  int index = Get.arguments;
  List<ItemTable>? itemDataList = Get.find<ItemController>().itemList;

  void previousItem() {
    if (index > 0) {
      index--;
      // MyApp.flutterTts.stop();
      // Utils.textToSpeech(
      //     itemDataList![index]
      //         .itemNameTts!.tr
      //         .toLowerCase(),
      //     MyApp.flutterTts);
    }
    update([Constant.idSingleItem]);
  }

  void nextItem() {
    if (index < itemDataList!.length - 1 ) {
      index++;
      // MyApp.flutterTts.stop();
      // Utils.textToSpeech(
      //     itemDataList![index]
      //         .itemNameTts!.tr
      //         .toLowerCase(),
      //     MyApp.flutterTts);
    }
    update([Constant.idSingleItem]);
  }



}