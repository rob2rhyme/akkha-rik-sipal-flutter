import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/custom/progress_dialog.dart';
import 'package:kids_playroom/ui/pro_version/controllers/pro_version_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import '../../../utils/sizer_utils.dart';

class ProVersionScreen extends StatelessWidget {
  ProVersionScreen({Key? key}) : super(key: key);

  final ProVersionController _proVersionController =
      Get.find<ProVersionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: AppColor.colorTheme,
        flexibleSpace:topBar(),automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: AppSizes.width_4, vertical: AppSizes.height_4),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: AppSizes.height_5),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppSizes.width_4),
                          width: AppSizes.fullWidth,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Get.theme.cardColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15.0)),
                            boxShadow: [
                              BoxShadow(
                                  color: Get.context!.theme.primaryColor
                                      .withOpacity(0.1),
                                  blurRadius: 4),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: AppSizes.height_10),
                              Text(
                                "txtProVersionDescription".tr,
                                textAlign: TextAlign.center,
                                style:
                                TextStyle(fontWeight: FontWeight.w400,color: AppColor.colorGreen.withOpacity(0.6),fontSize: AppFontSize.size_12)

                              ),
                              SizedBox(height: AppSizes.height_1),
                              _divider(),
                              _proVersionList(
                                /*  AppAsset.icRemoveAd*/ "", "txtNoAdvertising".tr),
                              _divider(),

                              SizedBox(height: AppSizes.height_1),
                              Text(
                                (Platform.isAndroid == true)
                                    ? "txtProVersionDescription2Android".tr
                                    : "txtProVersionDescription2iOS".tr,
                                textAlign: TextAlign.left,
                                style:
                                     TextStyle(
                                      color: AppColor.colorGreen.withOpacity(0.8),
                                       fontSize: AppFontSize.size_10,
                                       fontWeight: FontWeight.w400
                                    )

                              ),
                              SizedBox(height: AppSizes.height_2_5),
                              Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _proVersionController
                                            .onClickPrivacyPolicy();
                                      },
                                      child: Text(
                                        "txtPrivacyPolicy".tr,
                                        maxLines: 1,
                                        textAlign: TextAlign.start,
                                        style:
                                        TextStyle(
                                          fontSize: AppFontSize.size_9,
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.colorGreen.withOpacity(0.8)

                                        )

                                      ),
                                    ),
                                  ),
                                  if (Platform.isIOS) ...{
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          _proVersionController
                                              .onClickRestore();
                                        },
                                        child: Text("txtRestore".tr,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: AppColor.colorGreen,
                                                fontSize: AppFontSize.size_12)),
                                      ),
                                    ),
                                  },
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        _proVersionController
                                            .onClickTermsAndCondition();
                                      },
                                      child: Text("txtTermsAndConditions".tr,
                                          textAlign: TextAlign.end,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: AppFontSize.size_9,
                                              color: AppColor.colorGreen
                                                  .withOpacity(0.8),
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: AppSizes.height_1_5),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: AppColor.colorTheme,
                            borderRadius:
                                BorderRadius.all(Radius.circular(100))),
                        padding: EdgeInsets.symmetric(
                            horizontal: AppSizes.width_4,
                            vertical: AppSizes.width_4),
                        child: Icon(Icons.ads_click),
                        /// child: Image.asset(
                        ///   AppAsset.icPro,
                        ///   height: AppSizes.height_8,
                        ///   width: AppSizes.height_8,
                        ///   color: AppColor.colorGreen,
                        /// ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.height_3),
                  InkWell(
                    onTap: () {
                      /// Purchase
                      _proVersionController.onPurchaseClick();
                    },
                    child: Container(
                      width: AppSizes.fullWidth,
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.width_3,
                          vertical: AppSizes.height_1_5),
                      decoration: BoxDecoration(
                        color: AppColor.colorTheme,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: AutoSizeText(
                          "${"txtContinueWithProVersion".tr} - ₹ 999.00",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColor.colorGreen,
                              fontSize: AppFontSize.size_13)),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
  topBar() {
    return GetBuilder<ProVersionController>(builder: (logic) {
      return Container(
        width: AppSizes.fullWidth,
        color: AppColor.colorTheme,
        padding: EdgeInsets.only(
          left: AppSizes.width_3,
          top: AppSizes.height_5,
          bottom: AppSizes.height_1,
        ),
        child: Center(
          child: Stack(
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                    Constant.getAssetIcons() + "btn_back_150.png",
                    height: AppSizes.height_5),
              ),
              Center(
                child: Text("txtProVersion".tr ??"",
                  style: TextStyle(
                      color: AppColor.colorGreen,
                      fontSize: AppFontSize.size_16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  _proVersionList(String icon, String text) {
    return Row(
      children: [
        /*Container(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.width_3, vertical: AppSizes.width_3),
          decoration: const BoxDecoration(
            color: AppColor.colorTheme,
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          child: Image.asset(
            icon,
            height: AppSizes.height_3,
            width: AppSizes.height_3,
            color: AppColor.white,
          ),
        ),*/
        SizedBox(width: AppSizes.width_3),
        Expanded(
          child: Text(text,
              maxLines: 2,
              style: TextStyle(
                  fontSize: AppFontSize.size_13,
                  color: AppColor.colorGreen,
                  fontWeight: FontWeight.w500)),
        ),
      ],
    );
  }

  _divider() {
    return Divider(
      color: Get.theme.primaryColor.withOpacity(0.5),
      height: AppSizes.height_4,
    );
  }
}
