//lib//ui/compare/controllers/compare_controller.dart
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/dialog/complete_dialog/complete_dialog_screen.dart';
import 'package:akkha_rik_lipi_sipal/main.dart';
import 'package:akkha_rik_lipi_sipal/utils/debug.dart';
import 'package:akkha_rik_lipi_sipal/utils/utils.dart';

class CompareController extends GetxController {
  PageController? pageController = PageController(
    viewportFraction: 1.0,
    keepPage: true,
  );

  bool? show1 = false;
  bool? show2 = false;
  int? currentQue = 1;
  int? totalQue = 30;

  List<int> options = [];
  int? countAnswer;
  String? que;

  List<String> questions = ["Which group has less?", "Which group has more?"];
  dynamic args = Get.arguments;
  String? title;
  int? subId;

  @override
  void onInit() {
    getDataFromArgs();
    MyApp.flutterTts.stop();
    Utils.textToSpeech(title ?? '', MyApp.flutterTts);
    getOptions();
    super.onInit();
  }

  void getDataFromArgs() {
    if (args != null) {
      if (args[0] != null) {
        title = args[0];
      }
      if (args[1] != null) {
        subId = args[1];
      }
    }
  }

  void getOptions() {
    do {
      countAnswer = Random().nextInt(totalQue!);
    } while (countAnswer! < 1);

    Debug.printLog("countAnswer : $countAnswer");

    Set<int> opt = {};
    opt.add(countAnswer!);

    do {
      int num;
      do {
        num = Random().nextInt(totalQue!);
      } while (num == 0);
      opt.add(num);
    } while (opt.length != 2);

    int n2 = opt.last;

    que = countAnswer! < n2 ? questions[0] : questions[1];

    Debug.printLog("options: $opt");

    options = opt.toList()..shuffle();

    MyApp.flutterTts.stop();
    Utils.textToSpeech(que ?? '', MyApp.flutterTts);
  }

  Future<void> nextPage(BuildContext context, {int? index}) async {
    Debug.printLog("index : $index --- que: ${totalQue! - 1}");

    await Future.delayed(const Duration(milliseconds: 3000), () {
      if (index != totalQue! - 1) {
        pageController!.jumpToPage(index! + 1);
        getOptions();
        show1 = false;
        show2 = false;
        currentQue = currentQue! + 1;
        update();
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) {
            return CompleteDialog(
              restartFunction: () {
                Navigator.of(context).pop();
                pageController!.jumpToPage(0);
                getOptions();
                show1 = false;
                show2 = false;
                currentQue = 1;
                update();
              },
            );
          },
        );
      }
    });
  }
}
