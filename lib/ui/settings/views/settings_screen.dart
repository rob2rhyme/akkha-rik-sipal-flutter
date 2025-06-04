import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/settings/controller/settings_controller.dart';
import 'package:akkha_rik_lipi_sipal/utils/color.dart';
import 'package:akkha_rik_lipi_sipal/utils/constant.dart';
import 'package:akkha_rik_lipi_sipal/utils/debug.dart';
import 'package:akkha_rik_lipi_sipal/utils/preference.dart';
import 'package:akkha_rik_lipi_sipal/utils/sizer_utils.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatelessWidget {
  final SettingsController settingsController = Get.find<SettingsController>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        settingsController.initRateMyApp(context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColor.colorTheme,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Constant.getAssetIcons() + "btn_back_150.png",
              width: AppSizes.height_4_5,
            ),
          ),
        ),
        title: Text(
          "txtSetting".tr,
          style: TextStyle(
            color: AppColor.colorGreen,
            fontSize: AppFontSize.size_16,
            fontWeight: FontWeight.bold,
            fontFamily: "UrbanistBlack",
          ),
        ),
      ),
      body: GetBuilder<SettingsController>(
        builder: (logic) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GetBuilder<SettingsController>(
                  builder: (logic) {
                    return !Preference.shared.getIsPurchase() && Debug.googleAd
                        ? _proSection()
                        : const SizedBox();
                  },
                ),
                Divider(
                  color: AppColor.colorGray50,
                  thickness: AppSizes.height_1_5,
                  height: AppSizes.height_1_5,
                ),
                settingItem(
                  image: Constant.getAssetIcons() + "ic_sound.png",
                  text: "txtSound".tr,
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: logic.isSound!,
                      onChanged: (value) {
                        logic.sound(value);
                      },
                      thumbColor: AppColor.colorGreen,
                      trackColor: AppColor.colorGreen.withAlpha(
                        (0.4 * 255).toInt(),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AppColor.colorGray50,
                  thickness: AppFontSize.size_1,
                  height: 0,
                ),
                settingItem(
                  image: Constant.getAssetIcons() + "ic_music.png",
                  text: "txtMusic".tr,
                  trailing: Transform.scale(
                    scale: 0.7,
                    child: CupertinoSwitch(
                      value: logic.isMusic!,
                      onChanged: (value) {
                        logic.music(value);
                      },
                      thumbColor: AppColor.colorGreen,
                      inactiveTrackColor: AppColor.colorGreen.withAlpha(
                        (0.4 * 255).toInt(),
                      ),
                    ),
                  ),
                ),
                Divider(
                  color: AppColor.colorGray50,
                  thickness: AppSizes.height_1_5,
                  height: AppSizes.height_1_5,
                ),
                settingItem(
                  image: Constant.getAssetIcons() + "ic_rate.png",
                  onTap: () => logic.rate(context),
                  text: "txtRate".tr,
                ),
                Divider(
                  color: AppColor.colorGray50,
                  thickness: AppFontSize.size_1,
                  height: 0,
                ),
                settingItem(
                  image: Constant.getAssetIcons() + "ic_share.png",
                  onTap: () => logic.share(),
                  text: "txtShare".tr,
                ),
                Divider(
                  color: AppColor.colorGray50,
                  thickness: AppFontSize.size_1,
                  height: 0,
                ),
                settingItem(
                  image: Constant.getAssetIcons() + "ic_feedback.png",
                  onTap: () => logic.sendFeedback(),
                  text: "txtSendFeedback".tr,
                ),
                Divider(
                  color: AppColor.colorGray50,
                  thickness: AppFontSize.size_1,
                  height: 0,
                ),
                settingItem(
                  image: Constant.getAssetIcons() + "ic_policy.png",
                  onTap: () => launchUrl(Uri.parse(Constant.privacyPolicyURL)),
                  text: "txtPrivacyPolicy".tr,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _proSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColor.red,
        image: DecorationImage(
          image: AssetImage(Constant.getAssetIcons() + "setting_bg.png"),
          fit: BoxFit.fill,
        ),
      ),
      child: InkWell(
        onTap: () {
          settingsController.onTapRemoveAds();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.width_4,
            vertical: AppSizes.height_1_5,
          ),
          decoration: const BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              Image.asset(
                Constant.getAssetIcons() + "ic_subscription.png",
                height: AppSizes.height_6_5,
              ),
              SizedBox(width: AppSizes.width_5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subscription".tr.toUpperCase(),
                      style: TextStyle(
                        color: AppColor.redSquare,
                        fontSize: AppFontSize.size_16,
                        fontFamily: "UrbanistBlack",
                      ),
                    ),
                    Text(
                      "txtProversion".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: "Urbanist",
                        color: AppColor.redSquare,
                        fontSize: AppFontSize.size_11,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppSizes.height_0_2),
                child: Icon(
                  Icons.keyboard_double_arrow_right,
                  color: AppColor.colorGreen,
                  size: AppSizes.height_5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

settingItem({
  Function()? onTap,
  String? text,
  String? image,
  Widget? trailing,
  double? margin,
  double? vPadding,
  double? hPadding,
}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      color: AppColor.white,
      padding: EdgeInsets.symmetric(
        vertical: vPadding ?? AppSizes.height_2_5,
        horizontal: hPadding ?? AppSizes.height_2,
      ),
      child: Row(
        children: [
          Image.asset(image ?? "", height: AppSizes.height_6),
          SizedBox(width: AppFontSize.size_10),
          Expanded(
            child: Text(
              text!,
              style: TextStyle(
                color: AppColor.black,
                fontSize: AppFontSize.size_14,
                letterSpacing: 1,
                fontWeight: FontWeight.w800,
                fontFamily: "Urbanist",
              ),
            ),
          ),
          if (trailing != null) ...{trailing},
        ],
      ),
    ),
  );
}
