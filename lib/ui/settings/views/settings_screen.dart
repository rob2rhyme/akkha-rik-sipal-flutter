import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(flexibleSpace: topBar(), automaticallyImplyLeading: false),
      body: Column(
        children: [],
      ),
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
