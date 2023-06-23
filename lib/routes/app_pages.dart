import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kids_playroom/ui/home/bindings/home_binding.dart';
import 'package:kids_playroom/ui/home/views/home_screen.dart';
import 'package:kids_playroom/ui/items/bindings/item_binding.dart';
import 'package:kids_playroom/ui/items/controllers/item_controller.dart';
import 'package:kids_playroom/ui/items/views/items_screen.dart';
import 'package:kids_playroom/ui/quiz/bindings/quiz_binding.dart';
import 'package:kids_playroom/ui/quiz/views/quiz_screen.dart';
import 'package:kids_playroom/ui/single_item/bindings/single_item_binding.dart';
import 'package:kids_playroom/ui/single_item/controllers/single_item_controller.dart';
import 'package:kids_playroom/ui/single_item/views/single_item_screen.dart';
import 'package:kids_playroom/ui/subcategory/bindings/subcategory_binding.dart';
import 'package:kids_playroom/ui/subcategory/views/subcategory_sceen.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:sizer/sizer.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      page: () =>HomeScreen(),
      binding: HomeBinding(),
    ),


    GetPage(
      name: AppRoutes.subcategory,
      page: () => SubCategoryScreen(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.items,
      page: () => ItemScreen(),
      binding:  ItemBinding(),
    ),  GetPage(
      name: AppRoutes.singleItem,
      page: () => SingleItemScreen(),
      binding:  SingleItemBinding(),
    ),GetPage(
      name: AppRoutes.quiz,
      page: () => QuizScreen(),
      binding:  QuizBinding(),
    ),

  ];
}
// import 'dart:math';
//
// import 'package:get/get.dart';
//
// class QuizController extends GetxController {
//   String title = Get.arguments;
//   List<LearningDataModel> examQuestionAnswerList;
//   ExamQuestionAdapter examQuestionAdapter;
//   LearningDataModel learningDataModel;
//   Random? random;
//
//   @override
//   void onInit() {
//     getRandomArray();
//     super.onInit();
//   }
//
//   void getRandomArray() {
//     random = Random();
//     examQuestionAnswerList = [];
//     int correctPosition = random!.nextInt(learningDataModelArrayList.length);
//     examQuestionAnswerList.add(learningDataModelArrayList[correctPosition]);
//     loadImage(learningDataModelArrayList[correctPosition].image);
//
//     do {
//       int number = random.nextInt(learningDataModelArrayList.length);
//       if (!examQuestionAnswerList.contains(learningDataModelArrayList[number])) {
//         examQuestionAnswerList.add(learningDataModelArrayList[number]);
//         examQuestionAnswerList[examQuestionAnswerList.length - 1].setTrue(false);
//       }
//     } while (examQuestionAnswerList.length != 4);
//     examQuestionAnswerList.shuffle();
//     setRvAdapter(isPreviousShow);
//   }
//
//
//   void setRvAdapter(bool isPreviousShow) {
//     if (isPreviousShow) {
//       LearningDataModel learningDataModel;
//       for (int i = 0; i < examQuestionAnswerList.length; i++) {
//         if (examQuestionAnswerList[i].isTrue()) {
//           learningDataModel = examQuestionAnswerList[i];
//           break;
//         }
//       }
//       examQuestionAdapter = ExamQuestionAdapter(context, examQuestionAnswerList, learningDataModel);
//     } else {
//       examQuestionAdapter = ExamQuestionAdapter(context, examQuestionAnswerList, learningDataModelArrayList[correctPosition]);
//     }
//     // Set the adapter for your RecyclerView equivalent
//     // Example:
//     // rv_exam.setAdapter(examQuestionAdapter);
//   }
//
//   void onClickNext() {
//     getRandomArray();
//   }
//
//   void onClickPrev() {
//     getRandomArray();
//   }
//
//
//
//
// }class LearningDataModel {
//   String? image;
//   bool? isTrue() {
//     // Implement the isTrue() method logic
//   }
// }
//
// class ExamQuestionAdapter {
//   // Implement the ExamQuestionAdapter class
//   // with the necessary constructors and methods
// }