import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/ui/settings/controller/settings_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    settingsController.initRateMyApp(context);

    return Scaffold(
      appBar: AppBar(flexibleSpace: topBar(), automaticallyImplyLeading: false),
      body: GetBuilder<SettingsController>(builder: (logic) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Divider(
              color: AppColor.colorGray50,
              thickness: AppSizes.height_2,
              height: AppSizes.height_2,
            ),
            settingItem(
              text: "txtSound".tr,
              trailing: Switch(
                value: logic.isSound!,
                onChanged: (value) {
                  logic.sound(value);
                  print(value);
                },
                activeTrackColor: AppColor.colorGreen.withOpacity(0.2),
                activeColor: AppColor.colorGreen,
              ),
            ),
            Divider(
              color: AppColor.colorGray50,
              thickness: AppSizes.height_2,
              height: AppSizes.height_2,
            ),
            settingItem(onTap: () => logic.rate(context),
              text: "txtRete".tr,
            ),
            Divider(
              color: AppColor.colorGray50,
              thickness: AppFontSize.size_1,
              height: 0,
            ),
            settingItem(
              onTap:()=> logic.share(),
              text: "txtShare".tr,
            ),
            Divider(
              color: AppColor.colorGray50,
              thickness: AppFontSize.size_1,
              height: 0,
            ),
            settingItem(
              onTap: ()=>logic.sendFeedback(),
              text: "txtSendFeedback".tr,
            ),
            Divider(
              color: AppColor.colorGray50,
              thickness: AppFontSize.size_1,
              height: 0,
            ),
            settingItem(
              onTap: () => launchUrl(Uri.parse(Constant.privacyPolicyURL)) ,
              text: "txtPrivacyPolicy".tr,
            ),
          ],
        );
      }),
    );
  }
}

topBar() {
  return Container(
    width: AppSizes.fullWidth,
    color: AppColor.colorTheme,
    padding: EdgeInsets.only(
      left: AppSizes.width_3,
      top: AppSizes.height_5,
      bottom: AppSizes.height_1,
    ),
    child: Stack(
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Image.asset(Constant.getAssetIcons() + "btn_back_150.png",
              height: AppSizes.height_5),
        ),
        Center(
          child: Text(
            "txtSetting".tr,
            style: TextStyle(
                color: AppColor.colorGreen,
                fontSize: AppFontSize.size_16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

settingItem({
  Function()? onTap,
  String? text,
  Widget? trailing,
  double? margin,
  double? vPadding,
  double? hPadding,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      color: AppColor.white,
      // margin: EdgeInsets.symmetric(vertical: margin ?? AppSizes.height_1),
      padding: EdgeInsets.symmetric(
          vertical: vPadding ?? AppSizes.height_2_5,
          horizontal: hPadding ?? AppSizes.height_2),
      child: Row(
        children: [
          Expanded(
              child: Text(
            text!,
            style: TextStyle(
                color: AppColor.black,
                fontSize: AppFontSize.size_14,
                fontWeight: FontWeight.w500),
          )),
          if (trailing != null) ...{
            trailing,
          }
        ],
      ),
    ),
  );
}
