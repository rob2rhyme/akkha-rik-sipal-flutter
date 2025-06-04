 // ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'color.dart';
import 'constant.dart';
import 'preference.dart';
import 'sizer_utils.dart';
import 'package:intl/intl.dart' as intl;


class Utils {
  static AudioPlayer audioPlayer = AudioPlayer();
  static const audio = "sounds/background_music.mp3";
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




  static decimalNumberFormat(int number) {
    return intl.NumberFormat.decimalPattern().format(number);
  }

  static playAudio() async {
    audioPlayer.play(AssetSource(audio));
    audioPlayer.setReleaseMode(ReleaseMode.loop);
  }

  static Future textToSpeech(String speakText, FlutterTts flutterTts) async {
    bool value = Preference.shared.getBool(Preference.isSOUND) ?? true;
    if (value) {
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
  }else{
      await flutterTts.stop();
    }}

  static Map<String, Color> colorList = const {
    "orange": Color(0XFFED4A0D),
    "violet": Color(0XFF6E3DFA),
    "red": Color(0XFFE30A0A),
    "green": Color(0XFF24DA0F),
    "cyan": Color(0XFF00CFDB),
    "pink": Color(0XFFCC00C1),
    "blue": Color(0XFF4253FF),
    "yellow": Color(0XFFF6D913),
  };
  static List<Color> colorPickerList = const [
    Color(0XFF00C2AF),
    Color(0XFF00B500),
    Color(0XFF7FD200),
    Color(0XFFFEEF00),
    Color(0XFFFAC712),
    Color(0XFFF69F23),
    Color(0XFF97979A),
    Color(0XFFFF2600),
    Color(0XFFD2298E),
    Color(0XFF7421B0),
    Color(0XFF3A48BA),
    Color(0XFF006FC4),
    Color(0XFFBC2B13),
    Color(0XFFFB6312),
  ];
  static isPurchased() {
    // return Preference.shared.getBool(Preference.isPurchased) ?? Constant.boolValueFalse;
  }

  static Future<void> urlLauncher(String value) async {
    var url = Uri.parse(value);
    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw "Cannot load the page";
    }
  }

  static showHideStatusBar({bool isHide = true}) {
    if(!Platform.isIOS) {
      if(isHide) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
      } else {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      }
    }
  }
  static getProductId() {
    if (Platform.isAndroid) {
      return Constant.productIdAndroid;
    } else {
      return Constant.productIdiOS;
    }
  }
}
