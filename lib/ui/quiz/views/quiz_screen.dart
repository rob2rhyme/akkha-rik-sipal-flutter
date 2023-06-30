
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/main.dart';
import 'package:kids_playroom/ui/quiz/controller/quiz_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';
import 'package:kids_playroom/utils/utils.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});

  final QuizController quizController = Get.find<QuizController>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 6;
    final double itemWidth = size.width / 1.8;

    return Scaffold(
      appBar: AppBar(flexibleSpace: topBar(), automaticallyImplyLeading: false),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<QuizController>(
                id: Constant.idImage,
                builder: (logic) {
                  return Center(
                      child: logic.catId == 2
                          ? logic.trueItem != null
                              ? Image.asset(
                                  Constant.getAsset() +
                                      logic.trueItem!.image +
                                      ".png",
                                  height: AppSizes.height_20,
                                )
                              : const SizedBox()
                          : logic.catId == 3
                              ? InkWell(
                        onTap: (){MyApp.flutterTts.stop();
                        Utils.textToSpeech(
                          logic.trueItem?.itemNameTts.toString().tr ??"",
                          MyApp.flutterTts,
                        );},
                                child: Image.asset(
                                    Constant.getAssetIcons() + "btn_sound.png",  height: AppSizes.height_20,),
                              )
                              : const SizedBox());
                }),
          ),
          Expanded(
            child: GetBuilder<QuizController>(
                id: Constant.idQuiz,
                builder: (logic) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),

                    padding: const EdgeInsets.all(16),
                    itemCount: logic.allQuestionsList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: (itemWidth / itemHeight),
                        crossAxisSpacing: AppFontSize.size_16,
                        mainAxisSpacing: AppFontSize.size_16),
                    itemBuilder: (BuildContext context, int index) {
                      return items(logic.allQuestionsList[index], index,context);
                    },
                  );
                }),
          ),
          GetBuilder<QuizController>(builder: (logic) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      logic.onClickPrev();
                    },
                    child: Image.asset(
                      Constant.getAssetIcons() + "btn_prev_150.png",
                      height: AppSizes.height_6_5,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      logic.onClickNext();


                    },
                    child: Image.asset(
                      Constant.getAssetIcons() + "btn_next_150.png",
                      height: AppSizes.height_6_5,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );

  }

  topBar() {
    return Container(
      width: AppSizes.fullWidth,
      color: AppColor.colorTheme,
      padding: EdgeInsets.only(
        left: AppSizes.width_3,
        top: AppSizes.height_5,
        bottom: AppSizes.height_1,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(Constant.getAssetIcons() + "btn_back_150.png",
                height: AppSizes.height_5),
          ),
          Center(
            child: Text(
              quizController.title.toString().tr,
              style: TextStyle(
                  color: AppColor.colorGreen,
                  fontSize: AppFontSize.size_16,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

items(ExamQuestionAnswer examQuestionAnswer, int index,BuildContext context) {
  return InkWell(
      onTap: () {
        // Get.find<QuizController>().checkAnswer(itemIndex: index);
        final quizController = Get.find<QuizController>();
        quizController.checkAnswer(context,itemIndex: index);
      },
      child: GetBuilder<QuizController>(
          id: Constant.idColor,
          builder: (logic) {
            logic.currentColor = logic.containerColors![index];
            return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: logic.currentColor,
                  boxShadow: const [
                    BoxShadow(
                        color: AppColor.colorGray50,
                        blurRadius: 1.5,
                        spreadRadius: 2.5,
                        offset: Offset(0.5, 1.5))
                  ]),
              child: Center(
                  child: Text(
                examQuestionAnswer.itemName.toString().tr,
                style: TextStyle(
                    color: AppColor.colorBlueGreen,
                    fontSize: AppFontSize.size_17,
                    fontWeight: FontWeight.bold),
              )),
            );
          }));



}

