import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/item_table.dart';
import 'package:kids_playroom/utils/constant.dart';

class QuizController extends GetxController {
  dynamic args = Get.arguments;
  String? title;
  int? subId;
  List<ItemTable> learningDataModelArrayList = [];
  Random? random;
  List<ExamQuestionAnswer> examQuestionAnswerList =[];
  int? correctPosition;
  bool isPreviousShow = true;

  ExamQuestionAnswer? trueItem ;
  Color defaultColor = Colors.blue;
  List<Color>? containerColors;

  @override
  Future<void> onInit()async {
    getDataFromArgs();
    await getDataFromDatabase();
    getRandomArray();

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
    }
    update([Constant.idQuiz]);
  }

  Future<void> getDataFromDatabase() async {
    learningDataModelArrayList = await DataBaseHelper().getItemData(subId!);
    update([Constant.idQuiz]);
  }

  void getRandomArray() {
    random = Random();
    examQuestionAnswerList = [];
    correctPosition = random!.nextInt(learningDataModelArrayList.length );
    examQuestionAnswerList.add(ExamQuestionAnswer(
        learningDataModelArrayList[correctPosition!].itemImage ??"", true,learningDataModelArrayList[correctPosition!].itemNameTts,learningDataModelArrayList[correctPosition!].itemName));

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   setState(() {
    //     // Load image using Image.network equivalent in Flutter
    //     // Make sure to replace 'iVQuestion' with the appropriate Image widget
    //     Image.network(learningDataModelArrayList[correctPosition!].image);
    //   });
    // });

    do {
      int number = random!.nextInt(learningDataModelArrayList.length );
      if (!examQuestionAnswerList
          .contains(learningDataModelArrayList[number].itemImage)) {
        examQuestionAnswerList.add(ExamQuestionAnswer(
            learningDataModelArrayList[number].itemImage ?? "", false,learningDataModelArrayList[number].itemName,learningDataModelArrayList[number].itemNameTts));
      }
    } while (examQuestionAnswerList.length != 4);
    examQuestionAnswerList.shuffle();
    trueItem = examQuestionAnswerList
        .firstWhere((item) => item.isTrue == true);
    containerColors = List<Color>.filled(examQuestionAnswerList.length, defaultColor);
    update([Constant.idQuiz,Constant.idImage]);
  }

}



class ExamQuestionAnswer {
  String image;
  String? itemName;
  String? itemNameTts;
  bool isTrue;

  ExamQuestionAnswer(this.image, this.isTrue,this.itemName,this.itemNameTts);
}
