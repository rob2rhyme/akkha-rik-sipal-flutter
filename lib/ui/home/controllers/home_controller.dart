import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kids_playroom/database/database_helper.dart';
import 'package:kids_playroom/database/tables/category_table.dart';
import 'package:kids_playroom/google_ads/ad_helper.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/debug.dart';
import 'package:kids_playroom/utils/preference.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  List<CategoryTable>? categoryList = [];
  InterstitialAd? interstitialAd;
  int? interstitialCount;
  bool isInterstitialAdLoaded = false;


  @override
  void onInit() {
    _loadInterstitialAd();
    _getPreference();
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

              interstitialCount = Preference.shared.getInt(Preference.interstitialCount) ?? 1;
          update([Constant.idHomePage]);

        },
        onAdFailedToLoad: (err) {
          Debug.printLog('Failed to load an interstitial ad: ${err.message}');
        },
      ),
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



  _getPreference() {
    interstitialCount =
        Preference.shared.getInt(Preference.interstitialCount) ?? 1;
    Debug.printLog("count : $interstitialCount");
  }

}
