import 'package:get/get.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/category_table.dart';
import 'package:kids_playroom/main.dart';
import 'package:kids_playroom/routes/app_routes.dart';
import 'package:kids_playroom/utils/utils.dart';

class DragSubcategoryControllers extends GetxController {
  List<CategoryTable>? categoryList = [];

  getDataFromDatabase() async {
    categoryList = await DataBaseHelper().getDragCategoryData();
    update();
  }

  @override
  void onInit() {
    getDataFromDatabase();
    super.onInit();
  }

  Future<void> moveToNextScreen(int index) async {
    if (categoryList![index].categoryName == "Numbers") {
      Get.toNamed(AppRoutes.numbers, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);    } else if (categoryList![index].categoryName == "Counting") {
      Get.toNamed(AppRoutes.counting, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);
    } else if (categoryList![index].categoryName == "Addition" ||
        categoryList![index].categoryName == "Subtraction") {
      Get.toNamed(AppRoutes.addSubtract, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);

    } else if (categoryList![index].categoryName == "Compare") {
      Get.toNamed(AppRoutes.compare, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);

    } else if (categoryList![index].categoryName == "Missing Numbers") {
      Get.toNamed(AppRoutes.missingNum, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);
    } else if (categoryList![index].categoryName == "Time") {
      Get.toNamed(AppRoutes.time, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);
    } else if (categoryList![index].categoryName == "Months" ||
        categoryList![index].categoryName == "Days") {
      Get.toNamed(AppRoutes.month, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);

    } else if (categoryList![index].categoryName == "Quantity") {
    } else if (categoryList![index].categoryName == "Alphabets") {
    } else if (categoryList![index].categoryName == "Upper & Lower") {
    } else if (categoryList![index].categoryName == "Spelling") {
    } else {
      MyApp.flutterTts.stop();
      Utils.textToSpeech(categoryList![index].categoryName!, MyApp.flutterTts);
      Get.toNamed(AppRoutes.dragQuiz, arguments: [
        categoryList![index].categoryName,
        categoryList![index].categoryId
      ]);
      // Navigator.of(context).push(MaterialPageRoute(
      //     builder: (context) => QuizScreen(
      //         categoryId: categoryList![index].categoryId,
      //         categoryName: categoryList![index].categoryName)));
    }
  }
}
