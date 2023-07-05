import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:kids_playroom/localization/localizations_delegate.dart';
import 'package:kids_playroom/routes/app_pages.dart';
import 'package:kids_playroom/routes/app_routes.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/preference.dart';
import 'package:kids_playroom/utils/utils.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  await Preference().instance();
  await Future.delayed(const Duration(milliseconds: 2200));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.colorTheme
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static final navigatorKey = GlobalKey<NavigatorState>();
  static final FlutterTts flutterTts = FlutterTts();

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool? isMusic;


  @override
  void initState() {
    _getPreference();
    if (isMusic!) {
      Utils.playAudio();
    }
    super.initState();
  }
  void _getPreference() {
    isMusic = Preference.shared.getBool(Preference.isMusic) ?? true;
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _getPreference();
      if (isMusic!) {
        Utils.audioPlayer.resume();
      }
    } else {
      _getPreference();
      if (isMusic!) {
        Utils.audioPlayer.pause();
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          navigatorKey: MyApp.navigatorKey,
          debugShowCheckedModeBanner: false,
          color: AppColor.white,
          themeMode: ThemeMode.light,
          locale: const Locale("en"),
          translations: AppLanguages(),
          fallbackLocale:  const Locale(Constant.languageEn, Constant.countryCodeEn),
          getPages: AppPages.list,
          defaultTransition: Transition.fade,
          transitionDuration: const Duration(milliseconds: 200),
          initialRoute:  AppRoutes.home,

        );
      },
    );

  }
}


