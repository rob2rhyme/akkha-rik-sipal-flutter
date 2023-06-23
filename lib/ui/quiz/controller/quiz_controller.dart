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


  List<ItemTable> learningDataModelArrayList = [];
  List<ExamQuestionAnswer> examQuestionAnswerList =[];

  Random? random;
  int? correctPosition;

  ExamQuestionAnswer? trueItem ;
  Color? defaultColor = AppColor.colorBlueLight;
  List<Color>? containerColors;
  int? answerIndex ;


  Color? currentColor;
  Color? selectedColour;

  @override
  Future<void> onInit()async {
    getDataFromArgs();
    await getDataFromDatabase();
    getRandomArray();
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
  initSound(){
   if( catId == 3){
        MyApp.flutterTts.stop();
    Utils.textToSpeech(
        trueItem?.itemNameTts.toString().tr ??"",
        MyApp.flutterTts);}
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
        learningDataModelArrayList[correctPosition!].itemImage ??"", true,learningDataModelArrayList[correctPosition!].itemName,learningDataModelArrayList[correctPosition!].itemNameTts));


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
    containerColors = List<Color>.filled(examQuestionAnswerList.length, defaultColor!);
    update([Constant.idQuiz,Constant.idImage]);
  }

  void checkAnswer({required int itemIndex}) {
    Color tappedColor = examQuestionAnswerList[itemIndex].isTrue ? Colors.green : Colors.red;
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

  ExamQuestionAnswer(this.image, this.isTrue,this.itemName,this.itemNameTts);
}
