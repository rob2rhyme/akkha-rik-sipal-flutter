import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/custom/progress_dialog.dart';
import 'package:kids_playroom/in_app_purchase/in_app_purchase_helper.dart';
import 'package:kids_playroom/ui/pro_version/controllers/pro_version_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/utils.dart';
import '../../../utils/sizer_utils.dart';

class ProVersionScreen extends StatelessWidget {
  ProVersionScreen({Key? key}) : super(key: key);

  final ProVersionController _proVersionController =
  Get.find<ProVersionController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorTheme,
      body: GetBuilder<ProVersionController>(id: Constant.idProVersionProgress,builder: (logic) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: AppSizes
                            .width_4),
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
                              padding: EdgeInsets.only(
                                  top: AppSizes.height_4_5),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  SizedBox(
                                    width: AppFontSize.size_35,
                                  ),
                                  Image.asset(
                                      Constant.getAssetIcons() +
                                          "ic_diamond.png",
                                      height: AppSizes.height_9),
                                  const Spacer(),
                                  InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Image.asset(
                                        Constant.getAssetIcons() +
                                            "ic_close.png",
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
                                    color: const Color(0xff4C5354),
                                    fontSize: AppFontSize.size_10)),
                            SizedBox(
                              height: AppFontSize.size_18,
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                          Constant.getAssetIcons() + "subscription_bg .png"),
                      Column(
                        children: [
                          SizedBox(height: AppSizes.height_35
                          ),
                          Image.asset(
                            Constant.getAssetIcons() + "ic_kid_vactor.png",
                            height: AppSizes.height_22,
                          ),
                          SizedBox(height: AppSizes.height_5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                Constant.getAssetIcons() + "ic_done.png",
                                height: AppSizes.height_3_5,
                              ),
                              SizedBox(width: AppFontSize.size_10),
                              Text("txtNoAdvertising".tr,
                                  style: TextStyle(
                                      color: AppColor.colorGreen,
                                      fontSize: AppFontSize.size_12,
                                      fontFamily: "UrbanistBlack")),
                              SizedBox(width: AppFontSize.size_10),
                              Image.asset(
                                Constant.getAssetIcons() + "ic_done.png",
                                height: AppSizes.height_3_5,
                              ),
                              SizedBox(width: AppFontSize.size_10),
                              Text("txtFullyAccessible".tr,
                                  style: TextStyle(
                                      color: AppColor.colorGreen,
                                      fontSize: AppFontSize.size_12,
                                      fontFamily: "UrbanistBlack"))
                            ],
                          ),
                          SizedBox(height: AppFontSize.size_10),

                          //
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 22.0),
                          //   child: InkWell(
                          //     onTap: () {
                          //       /// Purchase
                          //       _proVersionController.onPurchaseClick();
                          //     },
                          //     child: Container(
                          //       width: AppSizes.fullWidth,
                          //       padding: EdgeInsets.symmetric(
                          //           horizontal: AppSizes.width_3,
                          //           vertical: AppSizes.height_3),
                          //       decoration: BoxDecoration(
                          //         color: AppColor.red,
                          //         borderRadius: BorderRadius.circular(100),
                          //       ),
                          //       child: AutoSizeText(
                          //           "${"txtsubscribetoproversion".tr.toUpperCase()} - ₹ 999.00".tr,
                          //           maxLines: 1,
                          //           textAlign: TextAlign.center,
                          //           style: TextStyle(
                          //               fontWeight: FontWeight.w600,
                          //               color: AppColor.white,
                          //               fontSize: AppFontSize.size_11)),
                          //     ),
                          //   ),
                          // ),
                          _accessAllFeatureButtonWidget(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.width_12, vertical: 18),
                            child: Row(

                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Utils.urlLauncher(
                                        Constant.privacyPolicyURL);
                                  },
                                  child: Text("txtPrivacyPolicy".tr,
                                      style: TextStyle(
                                          color: AppColor.colorGreen,
                                          fontSize: AppFontSize.size_10,
                                          fontFamily: "UrbanistBlack")),
                                ), InkWell(
                                  onTap: () {
                                    Utils.urlLauncher(
                                        Constant.termsAndConditionURL);
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

                          SizedBox(height: AppSizes.height_10
                            ,)
                        ],
                      ),
                    ],
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
            ),
            _startButton(logic),


          ],
        );
      }),
    );
  }

  _startButton(ProVersionController logic) {
    return SafeArea(
      child: Container(
        width: AppSizes.fullWidth,
        margin: EdgeInsets.only(
            top: AppSizes.height_4,
            bottom: AppSizes.height_1_8,
            right: AppSizes.width_5,
            left: AppSizes.width_5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColor.red,
              AppColor.red,
            ],
          ),
        ),
        child: TextButton(
          onPressed: () {
            logic.onPurchaseClick();
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100.0),
                side: const BorderSide(
                  color: AppColor.transparent,
                  width: 0.7,
                ),
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: AppSizes.height_1),
            child: Text(
              "txtStart".tr.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.white,
                fontSize: AppFontSize.size_14,
                fontWeight: FontWeight.w700,
                  fontFamily: "UrbanistBlack"
              ),
            ),
          ),
        ),
      ),
    );
  }


}

_accessAllFeatureButtonWidget() {
  return GetBuilder<ProVersionController>(
    id: Constant.idAccessAllFeaturesButtons,
    builder: (logic) {
      return SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                logic.onChangePlanSelection(Constant.boolValueTrue);
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                    horizontal: AppSizes.width_5,vertical: AppSizes.height_1 ),
                child: Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      padding:
                      EdgeInsets.symmetric(vertical: AppSizes.height_1),
                      width: AppSizes.fullWidth,
                      decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                            color: (logic.isSelected)
                                ? AppColor.red
                                : AppColor.txtColor999),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "txtAccessAllFeatures".tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "UrbanistBlack",
                              color: logic.isSelected
                                  ? AppColor.red
                                  : AppColor.txtColor999,
                              fontSize: AppFontSize.size_14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: AppSizes.height_0_5),
                          Text(
                            (InAppPurchaseHelper()
                                .getProductDetail(InAppPurchaseHelper
                                .monthlySubscriptionId)
                                ?.price !=
                                null)
                                ? "${InAppPurchaseHelper()
                                .getProductDetail(InAppPurchaseHelper
                                .monthlySubscriptionId)!
                                .price}/${"txtMonth".tr}"
                                : "${(430.00).toStringAsFixed(2)}/${"txtMonth"
                                .tr}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: "UrbanistBlack",
                              color: logic.isSelected
                                  ? AppColor.red
                                  : AppColor.txtColor999,
                              fontSize: AppFontSize.size_11,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (logic.isSelected) ...{
                      Container(
                        height: AppSizes.height_4,
                        width: AppSizes.height_4,
                        margin: EdgeInsets.only(right: AppSizes.width_5),
                        decoration: const BoxDecoration(
                          color: AppColor.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.done_rounded,
                            color: AppColor.white),
                      ),
                    },
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                logic.onChangePlanSelection(Constant.boolValueFalse);
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: AppSizes.width_5),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Container(
                        padding:
                        EdgeInsets.symmetric(vertical: AppSizes.height_1),
                        margin: EdgeInsets.only(top: AppSizes.height_3),
                        width: AppSizes.fullWidth,
                        decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              color: (!logic.isSelected)
                                  ? AppColor.red
                                  : AppColor.txtColor999),
                        ),
                        child: Column(
                          children: [
                            Text(
                              "txtAccessAllFeatures".tr,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: !logic.isSelected
                                    ? AppColor.red
                                    : AppColor.txtColor999,
                                fontSize: AppFontSize.size_14,
                                fontWeight: FontWeight.w700,
                                  fontFamily: "UrbanistBlack"
                              ),
                            ),
                            SizedBox(height: AppSizes.height_0_5),
                            Text(
                              (InAppPurchaseHelper()
                                  .getProductDetail(InAppPurchaseHelper
                                  .yearlySubscriptionId)
                                  ?.price !=
                                  null)
                                  ? "${InAppPurchaseHelper()
                                  .getProductDetail(InAppPurchaseHelper
                                  .yearlySubscriptionId)!
                                  .price}/${"txtYear".tr}"
                                  : "${(1700.00).toStringAsFixed(2)}/${"txtYear"
                                  .tr}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: !logic.isSelected
                                    ? AppColor.red
                                    : AppColor.txtColor999,
                                fontSize: AppFontSize.size_11,
                                fontWeight: FontWeight.w400,
                                  fontFamily: "UrbanistBlack"
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (!logic.isSelected) ...{
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            height: AppSizes.height_4,
                            width: AppSizes.height_4,
                            margin: EdgeInsets.only(
                                right: AppSizes.width_5,
                                top: AppSizes.height_3),
                            decoration: const BoxDecoration(
                              color: AppColor.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.done_rounded,
                                color: AppColor.white),
                          ),
                        ),
                      },
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
