 // ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'color.dart';
import 'constant.dart';
import 'debug.dart';
import 'preference.dart';
import 'sizer_utils.dart';
import 'package:intl/intl.dart' as intl;


class Utils {
  static showToast(BuildContext context, String msg) {
    return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      textColor: AppColor.white,
      fontSize: AppFontSize.size_13,
    );
  }

  static isFirstTimeOpenApp() {
    return Preference.shared.getBool(Preference.isFirstTimeOpenApp) ??
        Constant.boolValueTrue;
  }


  static backWidget({Color? iconColor}) {
    return Container(
      margin: EdgeInsets.only(
        left: AppSizes.width_3,
        right: AppSizes.width_3,
      ),
      child: Image.asset(
        Constant.getAssetIcons() + "ic_back.webp",
        color: iconColor,
        height: AppSizes.height_3,
        width: AppSizes.height_3,
      ),
    );
  }

  static decimalNumberFormat(int number) {
    return intl.NumberFormat.decimalPattern().format(number);
  }

  static Future textToSpeech(String speakText, FlutterTts flutterTts) async {
    if (Platform.isAndroid) {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage("en-GB");
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.isLanguageAvailable("en-GB");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(speakText);
    } else {
      await flutterTts.awaitSpeakCompletion(true);
      await flutterTts.setLanguage("en-AU");
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);
      await flutterTts.isLanguageAvailable("en-AU");
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(speakText);
    }
  }
}

