import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/item_table.dart';
import 'package:kids_playroom/main.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/utils.dart';

class QuizController extends GetxController {
  dynamic args = Get.arguments;
  String? title;
  int? subId;
  int? catId;

  // final Map<int,List< List<ExamQuestionAnswer>>> selectedDataMap = {};
  // final Map<int, List<List<ExamQuestionAnswer>>> selectedDataMap = <int, List<List<ExamQuestionAnswer>>>{};
  List<List<ExamQuestionAnswer>> selectedDataMap = [];

  List<ItemTable> learningDataModelArrayList = [];
  List<ExamQuestionAnswer> examQuestionAnswerList = [];
  int currentQuestionIndex = 0;
  Random? random;
  int? correctPosition;

  ExamQuestionAnswer? trueItem;

  Color? defaultColor = AppColor.colorBlueLight;
  List<Color>? containerColors;
  int? answerIndex;

  List<ExamQuestionAnswer>? lastSelectedData = [];

  List<List<ExamQuestionAnswer>> selectedDataList = [];
  int currentIndex = 0;
  Color? currentColor;
  Color? selectedColour;

  @override
  Future<void> onInit() async {
    getDataFromArgs();
    await getDataFromDatabase();
    getRandomArray();
    selectedDataList.add(examQuestionAnswerList);
    initSound();
    super.onInit();
  }

  getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        title = args[0];
      }
      if (args[1] != null) {
        subId = args[1];
      }
      if (args[2] != null) {
        catId = args[2];
      }
    }
    update([Constant.idQuiz]);
  }

  initSound() {
    if (catId == 3) {
      MyApp.flutterTts.stop();
      Utils.textToSpeech(
          trueItem?.itemNameTts.toString().tr ?? "", MyApp.flutterTts);
    }
  }

  // void onClickPrev() {
  //   if (selectedDataMap.isNotEmpty) {
  //     final lastSelectedIndex = selectedDataMap.length - 1;
  //     if (lastSelectedIndex >= 0) {
  //       lastSelectedData = selectedDataMap[lastSelectedIndex];
  //       if (lastSelectedData!.isNotEmpty) {
  //         examQuestionAnswerList = lastSelectedData!.toList();
  //         trueItem = examQuestionAnswerList.firstWhere((item) => item.isTrue == true);
  //       }
  //     }
  //   }
  //   print("${selectedDataList.length}:::::::");
  //
  //   update([Constant.idColor, Constant.idImage, Constant.idQuiz]);
  // }4`

  void onClickPrev() {
    // selectedDataMap.removeLast(); // Remove the last question from the map
    if (currentQuestionIndex > 0) {
      currentQuestionIndex--;
      print(":::onClickPrev::$currentQuestionIndex");
      print(":::onClickNext::${examQuestionAnswerList.length}");

      examQuestionAnswerList = selectedDataMap[currentQuestionIndex];
      trueItem =
          examQuestionAnswerList.firstWhere((item) => item.isTrue == true);
      initSound();
      containerColors =
          List<Color>.filled(examQuestionAnswerList.length, defaultColor!);
      selectedDataMap.add(examQuestionAnswerList);
    }

    update([Constant.idColor, Constant.idImage, Constant.idQuiz]);
  }

  onClickNext() {
    if (selectedDataMap.isNotEmpty &&
        currentQuestionIndex < selectedDataMap.length - 1) {
      currentQuestionIndex++;
      print(":::onClickNext::$currentQuestionIndex");
      examQuestionAnswerList = selectedDataMap[currentQuestionIndex];
      trueItem =
          examQuestionAnswerList.firstWhere((item) => item.isTrue == true);
      initSound();
      containerColors =
          List<Color>.filled(examQuestionAnswerList.length, defaultColor!);
      selectedDataMap.add(examQuestionAnswerList);
    } else {
      getRandomArray();
      currentQuestionIndex++;
      initSound();
    }
    update([Constant.idColor, Constant.idImage, Constant.idQuiz]);
  }

  // void onClickPrev() {
  //   if (selectedDataMap.length > 0) {
  //     // selectedDataMap.removeLast();
  //     examQuestionAnswerList = selectedDataMap.first;
  //     trueItem = examQuestionAnswerList.firstWhere((item) => item.isTrue == true);
  //     // containerColors = List<Color>.filled(examQuestionAnswerList.length, defaultColor!);
  //     checkAnswer( itemIndex: 0);
  //     checkAnswer( itemIndex: 1);
  //     checkAnswer( itemIndex: 2);
  //     checkAnswer( itemIndex: 3);
  //       print("${selectedDataList.length}:::::::");
  //
  //     update([Constant.idColor, Constant.idImage, Constant.idQuiz]);
  //   }
  // }
  //

  // void onClickPrev() {
  //   final lastSelectedIndex = selectedDataMap.length - 1;
  //   if (lastSelectedIndex >= 0) {
  //     // examQuestionAnswerList.clear();
  //     lastSelectedData = selectedDataMap[0]?[lastSelectedIndex] ?? [];
  //
  //     // lastSelectedData = selectedDataMap[lastSelectedDataedIndex] ?? [];
  //     if (lastSelectedData!.isNotEmpty) {
  //       print(":1:${lastSelectedData?[0].image}");
  //       print(":: ${lastSelectedData?[0].itemNameTts}");
  //       print(":: ${lastSelectedData?[0].itemName}");
  //       print(":: ${lastSelectedData?[0].isTrue}");
  //       print(":: ${lastSelectedData?[1].image}");
  //       print(":: ${lastSelectedData?[1].itemNameTts}");
  //       print(":: ${lastSelectedData?[1].itemName}");
  //       print(":: ${lastSelectedData?[1].isTrue}");
  //       print(":: ${lastSelectedData?[2].image}");
  //       print(":: ${lastSelectedData?[2].itemNameTts}");
  //       print(":: ${lastSelectedData?[2].itemName}");
  //       print(":: ${lastSelectedData?[2].isTrue}");
  //       print(":: ${lastSelectedData?[3].image}");
  //       print(":: ${lastSelectedData?[3].itemNameTts}");
  //       print(":: ${lastSelectedData?[3].itemName}");
  //       print(":: ${lastSelectedData?[3].isTrue}");
  //       print(":: ${lastSelectedData?.length}");
  //
  //      examQuestionAnswerList= lastSelectedData!.toList();
  //       trueItem = examQuestionAnswerList.firstWhere((item) => item.isTrue == true);
  //
  //     }
  //   }
  //   update([Constant.idColor, Constant.idImage, Constant.idQuiz]);
  // }

  Future<void> getDataFromDatabase() async {
    learningDataModelArrayList = await DataBaseHelper().getItemData(subId!);
    update([Constant.idQuiz]);
  }

  void getRandomArray() {
    random = Random();
    examQuestionAnswerList = [];
    correctPosition = random!.nextInt(learningDataModelArrayList.length);
    examQuestionAnswerList.add(ExamQuestionAnswer(
      learningDataModelArrayList[correctPosition!].itemImage ?? "",
      true,
      learningDataModelArrayList[correctPosition!].itemName,
      learningDataModelArrayList[correctPosition!].itemNameTts,
    ));

    Set<String> itemNamesSet = {}; // Store unique item names
    itemNamesSet
        .add(learningDataModelArrayList[correctPosition!].itemName ?? "");

    while (examQuestionAnswerList.length != 4) {
      int number = random!.nextInt(learningDataModelArrayList.length);
      String itemName = learningDataModelArrayList[number].itemName ?? "";
      if (!itemNamesSet.contains(itemName)) {
        examQuestionAnswerList.add(ExamQuestionAnswer(
          learningDataModelArrayList[number].itemImage ?? "",
          false,
          itemName,
          learningDataModelArrayList[number].itemNameTts,
        ));
        itemNamesSet.add(itemName); // Add unique item name to the set
      }
    }

    examQuestionAnswerList.shuffle();
    trueItem = examQuestionAnswerList.firstWhere((item) => item.isTrue == true);
    containerColors =
        List<Color>.filled(examQuestionAnswerList.length, defaultColor!);
    selectedDataMap.add(examQuestionAnswerList);
    print(":::getRandomArray:::$currentQuestionIndex");

    update([Constant.idQuiz, Constant.idImage]);
  }

  void checkAnswer({required int itemIndex}) {
    Color tappedColor =
        examQuestionAnswerList[itemIndex].isTrue ? Colors.green : Colors.red;
    containerColors![itemIndex] = tappedColor;
    currentColor = containerColors![itemIndex];

    update([Constant.idColor]);
  }
}

class ExamQuestionAnswer {
  String image;
  String? itemName;
  String? itemNameTts;
  bool isTrue;

  ExamQuestionAnswer(this.image, this.isTrue, this.itemName, this.itemNameTts);
}
