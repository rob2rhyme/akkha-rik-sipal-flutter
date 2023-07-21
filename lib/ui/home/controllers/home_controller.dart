import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/category_table.dart';
import 'package:kids_playroom/google_ads/ad_helper.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/debug.dart';
import 'package:kids_playroom/utils/preference.dart';
import 'package:kids_playroom/utils/utils.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  List<CategoryTable>? categoryList = [];
  InterstitialAd? interstitialAd;
  bool isInterstitialAdLoaded = false;


  @override
  void onInit() {
    _loadInterstitialAd();
     getDataFromDatabase();
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
  void _loadInterstitialAd() {
    print("::::::object");
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(

            onAdLoaded: (ad) {
              ad.fullScreenContentCallback = FullScreenContentCallback(
                onAdDismissedFullScreenContent: (ad) {
                  ad.dispose();
                  _loadInterstitialAd();

                },
                onAdFailedToShowFullScreenContent: (ad, error) {
                  ad.dispose();

                  _loadInterstitialAd();
                },
          );

          interstitialAd = ad;
              isInterstitialAdLoaded = true;

          update([Constant.idHomePage]);

        },
        onAdFailedToLoad: (err) {
          Debug.printLog('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }
  showAd() async{
    if (interstitialAd != null && Preference.shared.getInterstitialAdCount()%Constant.interstitialCount == 0) {
      Utils.showHideStatusBar();
      await interstitialAd!.show();

    }    Preference.shared.setInterstitialAdCount(Preference.shared.getInterstitialAdCount()+1);
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
