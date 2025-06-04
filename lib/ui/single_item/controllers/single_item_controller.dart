// import 'package:get/get.dart';
// import 'package:akkha_rik_lipi_sipal/database/tables/item_table.dart';
// import 'package:akkha_rik_lipi_sipal/main.dart';
// import 'package:akkha_rik_lipi_sipal/ui/items/controllers/item_controller.dart';
// import 'package:akkha_rik_lipi_sipal/utils/constant.dart';
// import 'package:akkha_rik_lipi_sipal/utils/utils.dart';
//
// class SingleItemController extends GetxController {
//   int index = Get.arguments;
//   List<ItemTable>? itemDataList = Get.find<ItemController>().itemList;
//   // bool launchAnimation = false;
//   RxBool showAnimation = RxBool(false);
//
//   @override
//   void onInit() {
//     // launchAnimation = !launchAnimation;
//     super.onInit();
//   }
//
//     void previousItem() {
//       if (index > 0) {
//         index--;
//
//         MyApp.flutterTts.stop();
//         Utils.textToSpeech(
//             itemDataList![index]
//                 .itemNameTts!.tr
//                 .toLowerCase(),
//             MyApp.flutterTts);
//       }
//       showAnimation.value = !showAnimation.value;
//
//       update([Constant.idSingleItem]);
//     }
//
//   void nextItem() {
//     if (index < itemDataList!.length - 1 ) {
//       index++;
//
//       MyApp.flutterTts.stop();
//       Utils.textToSpeech(
//           itemDataList![index]
//               .itemNameTts!.tr
//               .toLowerCase(),
//           MyApp.flutterTts);
//     }
//     showAnimation.value = !showAnimation.value;
//     update([Constant.idSingleItem]);
//   }
//
//
//
// }
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/item_table.dart';
import 'package:akkha_rik_lipi_sipal/main.dart';
import 'package:akkha_rik_lipi_sipal/ui/items/controllers/item_controller.dart';
import 'package:akkha_rik_lipi_sipal/utils/constant.dart';
import 'package:akkha_rik_lipi_sipal/utils/utils.dart';

class SingleItemController extends GetxController {
  int index = Get.arguments;
  List<ItemTable>? itemDataList = Get.find<ItemController>().itemList;
  var showAnimation = false;

  void previousItem() {
    if (index > 0) {
      index--;
      showAnimation = !showAnimation;
      animateController;
      MyApp.flutterTts.stop();
      Utils.textToSpeech(
        itemDataList![index].itemNameTts!.tr.toLowerCase(),
        MyApp.flutterTts,
      );
    }

    update([Constant.idSingleItem]);
  }

  void nextItem() {
    if (index < itemDataList!.length - 1) {
      index++;
      showAnimation = !showAnimation;
      animateController;
      MyApp.flutterTts.stop();
      Utils.textToSpeech(
        itemDataList![index].itemNameTts!.tr.toLowerCase(),
        MyApp.flutterTts,
      );
    }

    update([Constant.idSingleItem]);
  }

  AnimationController? animateController;

  @override
  void onInit() {
    showAnimation = !showAnimation;

    super.onInit();
  }
}
