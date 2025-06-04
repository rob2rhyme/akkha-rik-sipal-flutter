//lib/ui/home/controllers/home_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:akkha_rik_lipi_sipal/database/database_helper.dart';
import 'package:akkha_rik_lipi_sipal/database/tables/category_table.dart';
import 'package:akkha_rik_lipi_sipal/utils/constant.dart';
import 'package:akkha_rik_lipi_sipal/utils/debug.dart';
import 'package:akkha_rik_lipi_sipal/utils/preference.dart';
import 'package:akkha_rik_lipi_sipal/utils/utils.dart';

class HomeController extends GetxController
    with WidgetsBindingObserver, GetSingleTickerProviderStateMixin {
  List<CategoryTable>? categoryList = [];
  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;

  AnimationController? animationController;
  AnimationController? controller;
  Animation<Offset>? animationLeft;
  Animation<Offset>? animationRight;

  @override
  void onInit() {
    getDataFromDatabase();
    // getInAppPurchase();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..forward();

    animationLeft =
        Tween<Offset>(begin: const Offset(-1.5, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: animationController!, curve: Curves.easeIn),
        );

    animationRight =
        Tween<Offset>(begin: const Offset(1.5, 0.0), end: Offset.zero).animate(
          CurvedAnimation(parent: animationController!, curve: Curves.easeIn),
        );

    super.onInit();
  }

  Future<void> getDataFromDatabase() async {
    categoryList = await DataBaseHelper().getCategoryData();
    print(":: ::: ::: $categoryList");
    update([Constant.idHomePage]);
  }

  addBindingObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  removeBindingObserver() {
    WidgetsBinding.instance.removeObserver(this);
  }

  // void getInAppPurchase() {
  //   MyApp.purchaseStreamController.stream.listen((product) {
  //     try {
  //       if (product.productID == Utils.getProductId()) {
  //         Preference.shared.setIsPurchase(true);
  //       } else {
  //         Preference.shared.setIsPurchase(false);
  //       }
  //     } on Exception catch (e) {
  //       Preference.shared.setIsPurchase(true);
  //       Debug.printLog("error", e.toString());
  //     }
  //   });
  // }

  showAd() async {
    if (interstitialAd != null &&
        Preference.shared.getInterstitialAdCount() %
                Constant.interstitialCount ==
            0) {
      Utils.showHideStatusBar();
      await interstitialAd!.show();
    }
    Preference.shared.setInterstitialAdCount(
      Preference.shared.getInterstitialAdCount() + 1,
    );
  }

  @override
  void dispose() {
    removeBindingObserver();
    try {
      interstitialAd?.dispose();
      interstitialAd = null;
    } catch (ex) {
      Debug.printLog("banner dispose error");
    }
    // interstitialAd?.dispose();
    super.dispose();
  }
}
