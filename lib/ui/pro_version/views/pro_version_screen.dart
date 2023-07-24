import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/custom/progress_dialog.dart';
import 'package:kids_playroom/ui/pro_version/controllers/pro_version_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/sizer_utils.dart';

class ProVersionScreen extends StatelessWidget {
  ProVersionScreen({Key? key}) : super(key: key);

  final ProVersionController _proVersionController =
      Get.find<ProVersionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorTheme,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: AppSizes.width_4),
                  width: AppSizes.fullWidth,
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColor.colorGray50,
                          offset: Offset(1, 1.5),
                          blurRadius: 2,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: AppSizes.height_4_5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: AppFontSize.size_35,
                            ),
                            Image.asset(
                                Constant.getAssetIcons() + "ic_diamond.png",
                                height: AppSizes.height_9),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Image.asset(Constant.getAssetIcons() + "ic_close.png",
                                  height: AppSizes.height_5),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppFontSize.size_10,
                      ),
                      Text("txtSubscribe&".tr.toUpperCase(),
                          style: TextStyle(
                              color: AppColor.colorGreen,
                              fontSize: AppFontSize.size_18,
                              fontFamily: "UrbanistBlack")),
                      Text("txtGetPremium".tr.toUpperCase(),
                          style: TextStyle(
                              color: AppColor.redSquare,
                              fontSize: AppFontSize.size_18,
                              fontFamily: "UrbanistBlack")),
                      SizedBox(
                        height: AppFontSize.size_10,
                      ),
                      Text(
                          "txtGetmorepremiumopportunitiesandfeaturestolearntheEnglishlanguagewithfunandpleasure"
                              .tr,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontFamily: "Urbanist",
                              color: Color(0xff4C5354),
                              fontSize: AppFontSize.size_10)),
                      SizedBox(
                        height: AppFontSize.size_18,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSizes.height_3),
                Image.asset(
                  Constant.getAssetIcons() + "ic_kid_vactor.png",
                  height: AppSizes.height_30,
                ),
                SizedBox(height: AppSizes.height_5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Constant.getAssetIcons() + "ic_done.png",
                      height: AppSizes.height_4_5,
                    ),
                    SizedBox(width: AppFontSize.size_10),
                    Text("txtNoAdvertising".tr,
                        style: TextStyle(
                            color: AppColor.colorGreen,
                            fontSize: AppFontSize.size_13,
                            fontFamily: "UrbanistBlack"))
                  ],
                ),
                SizedBox(height: AppFontSize.size_10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      Constant.getAssetIcons() + "ic_done.png",
                      height: AppSizes.height_4_5,
                    ),
                    SizedBox(width: AppFontSize.size_10),
                    Text("txtFullyAccessible".tr,
                        style: TextStyle(
                            color: AppColor.colorGreen,
                            fontSize: AppFontSize.size_13,
                            fontFamily: "UrbanistBlack"))
                  ],
                ),
                SizedBox(height: AppSizes.height_4_5),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22.0),
                  child: InkWell(
                    onTap: () {
                      /// Purchase
                      _proVersionController.onPurchaseClick();
                    },
                    child: Container(
                      width: AppSizes.fullWidth,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.width_3,
                          vertical: AppSizes.height_3),
                      decoration: BoxDecoration(
                        color: AppColor.red,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: AutoSizeText(
                          "${"subscribe to proversion "} - ₹ 999.00".tr,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                              fontSize: AppFontSize.size_11)),
                    ),
                  ),
                ),
                Padding(
                  padding:   EdgeInsets.symmetric(horizontal:AppSizes.width_12,vertical: 18),
                  child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: (){
                          Utils.urlLauncher(Constant.privacyPolicyURL);

                        },
                        child: Text("txtPrivacyPolicy".tr,
                            style: TextStyle(
                                color: AppColor.colorGreen,
                                fontSize: AppFontSize.size_10,
                                fontFamily: "UrbanistBlack")),
                      ),   InkWell(
                        onTap: () {
                          Utils.urlLauncher(Constant.termsAndConditionURL);

                        },
                        child: Text("txtTerms&Conditions".tr,
                            style: TextStyle(
                                color: AppColor.colorGreen,
                                fontSize: AppFontSize.size_10,
                                fontFamily: "UrbanistBlack")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset(Constant.getAssetIcons() + "subscription_bg .png"),
          GetBuilder<ProVersionController>(
            id: Constant.idProVersionProgress,
            builder: (logic) {
              return ProgressDialog(
                inAsyncCall: logic.isShowProgress,
                child: const SizedBox(),
              );
            },
          ),
        ],
      ),
    );
  }



}

