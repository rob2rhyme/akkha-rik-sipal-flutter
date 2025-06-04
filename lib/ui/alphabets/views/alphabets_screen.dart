//lib/ui/alphabets/views/alphabets_screen.dart
import 'dart:io';

import 'package:floodfill_image/floodfill_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/dialog/complete_dialog/complete_dialog_screen.dart';
import 'package:akkha_rik_lipi_sipal/main.dart';
import 'package:akkha_rik_lipi_sipal/ui/alphabets/controllers/alphabets_controller.dart';
import 'package:akkha_rik_lipi_sipal/utils/color.dart';
import 'package:akkha_rik_lipi_sipal/utils/constant.dart';
import 'package:akkha_rik_lipi_sipal/utils/sizer_utils.dart';
import 'package:akkha_rik_lipi_sipal/utils/utils.dart';

class AlphabetsScreen extends StatelessWidget {
  const AlphabetsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.colorTheme,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Constant.getAssetIcons() + "btn_back_150.png",
              width: AppSizes.height_4_5,
            ),
          ),
        ),
        title: GetBuilder<AlphabetsController>(
          builder: (logic) {
            return Text(
              logic.title ?? "",
              style: TextStyle(
                color: AppColor.colorGreen,
                fontSize: AppFontSize.size_16,
                fontWeight: FontWeight.bold,
                fontFamily: "UrbanistBlack",
              ),
            );
          },
        ),
      ),
      backgroundColor: AppColor.bg,
      body: SafeArea(
        top: false,
        bottom: Platform.isAndroid ? true : false,
        child: _alphabetsScreen(),
      ),
    );
  }
}

_alphabetsScreen() {
  return GetBuilder<AlphabetsController>(
    builder: (logic) {
      return Flex(
        direction: Axis.vertical,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: AppFontSize.size_2,
              ),
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/background/bg_background.webp"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: logic.pageController,
                      scrollDirection: Axis.horizontal,
                      itemCount: logic.alphabetsList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _itemAlphabet(context, index);
                      },
                    ),
                  ),
                  _colorPencils(),
                ],
              ),
            ),
          ),
        ],
      );
    },
  );
}

_itemAlphabet(BuildContext context, int index) {
  return Stack(
    alignment: Alignment.center,
    children: [
      Container(
        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.07),
        child: Image.asset("assets/background/alpha_frame.webp"),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _alphabetColor(context, index),
          _alphabetObject(context, index),
        ],
      ),
    ],
  );
}

_colorPencils() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _color("orange"),
      _color("violet"),
      _color("red"),
      _color("green"),
      _color("cyan"),
      _color("pink"),
      _color("blue"),
      _color("yellow"),
    ],
  );
}

_alphabetColor(BuildContext context, int index) {
  return GetBuilder<AlphabetsController>(
    builder: (logic) {
      if (logic.isShow!) {
        MyApp.flutterTts.stop();
        Utils.textToSpeech(
          logic.alphabetsList![index].ttsText!,
          MyApp.flutterTts,
        );
      }
      return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.13),
        child: FloodFillImage(
          fillColor: logic.currentColor!,
          avoidColor: const [Colors.transparent, Colors.black],
          imageProvider: AssetImage(
            Constant.getAssetDrag() +
                "${logic.alphabetsList![index].alphaImage}.webp",
          ),
          height: (MediaQuery.of(context).size.height * 0.25).toInt(),
          onFloodFillEnd: (value) async {
            logic.isShow = true;
            logic.update();
            await Future.delayed(const Duration(milliseconds: 1500), () {
              if (index != logic.alphabetsList!.length - 1) {
                logic.pageController!.jumpToPage(index + 1);
                logic.isShow = false;
                logic.update();
              } else {
                showDialog(
                  // ignore: use_build_context_synchronously
                  context: context,
                  builder: (context) {
                    return CompleteDialog(
                      restartFunction: () {
                        Navigator.of(context).pop();
                        logic.pageController!.jumpToPage(0);
                        logic.isShow = false;
                        logic.update();
                      },
                    );
                  },
                );
              }
            });
          },
        ),
      );
    },
  );
}

_alphabetObject(BuildContext context, int index) {
  return GetBuilder<AlphabetsController>(
    builder: (logic) {
      return AnimatedOpacity(
        opacity: !logic.isShow! ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 800),
        child: Container(
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.075,
          ),
          child: Column(
            children: [
              Image.asset(
                Constant.getAssetDrag() +
                    "${logic.alphabetsList![index].objectImage}.webp",
                height: MediaQuery.of(context).size.height * 0.25,
              ),
              Text(
                logic.alphabetsList![index].name!,
                style: const TextStyle(color: AppColor.theme, fontSize: 22),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

_color(String color) {
  return GetBuilder<AlphabetsController>(
    builder: (logic) {
      return InkWell(
        onTap: () {
          if (!logic.isShow!) {
            logic.currentColor = Utils.colorList[color];
            logic.update();
          }
        },
        child: Container(
          margin: EdgeInsets.only(
            bottom: logic.currentColor == Utils.colorList[color] ? 10 : 0,
          ),
          child: Image.asset(
            "assets/drag assets/colours/$color.webp",
            height: AppSizes.height_5_5,
          ),
        ),
      );
    },
  );
}
