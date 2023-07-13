
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/localization/localizations_delegate.dart';
import 'package:kids_playroom/ui/change_language/controllers/change_language_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';

class ChangeLanguageScreen extends StatelessWidget {
  ChangeLanguageScreen({Key? key}) : super(key: key);

  final ChangeLanguageController _changeLanguageController =
      Get.find<ChangeLanguageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(flexibleSpace: topBar(), automaticallyImplyLeading: false),

        backgroundColor: AppColor.colorBgWhite,
        body: Column(
          children: [
            GetBuilder<ChangeLanguageController>(
                id: Constant.idChangeLanguage,
                builder: (logic) {
                  return Expanded(
                    child: Container(
                      // margin: EdgeInsets.symmetric(
                      //     vertical: AppSizes.height_2,
                      //     horizontal: AppSizes.width_4),
                      padding:
                          EdgeInsets.symmetric(horizontal: AppSizes.width_2),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Get.theme.cardColor,

                      ),
                      child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.only(top: AppSizes.height_2),
                        shrinkWrap: true,
                        itemCount: languages.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              logic.onChangeLanguage(languages[index]);
                            },
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            AppColor.colorBlack,
                                      ),
                                      child: Radio(
                                        value: languages[index],
                                        groupValue: logic.languagesChosenValue!,
                                        onChanged: (LanguageModel? value) {
                                          logic.onChangeLanguage(value!);
                                        },
                                        activeColor: AppColor.colorGreen,
                                      ),
                                    ),
                                    Text(
                                      " ${languages[index].language}",
                                      style: TextStyle(
                                        fontSize: AppFontSize.size_12_5,
                                        color: AppColor.colorBlack,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      languages[index].symbol,
                                      style: TextStyle(
                                        fontSize: AppFontSize.size_22,
                                      ),
                                    ),
                                    SizedBox(width: AppSizes.width_4),
                                  ],
                                ),
                                _divider(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ));
  }



  topBar() {
    return Container(
      width: AppSizes.fullWidth,
      color: AppColor.colorTheme,
      padding: EdgeInsets.only(
        right: AppSizes.width_3,
        top: AppSizes.height_5,
        bottom: AppSizes.height_1,
        left: AppSizes.width_3,

      ),
      child: Center(
        child: Stack(
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Image.asset(Constant.getAssetIcons() + "btn_back_150.png",
                  height: AppSizes.height_5),
            ),
            Center(
              child: Text(
                  "txtLanguageOption".tr,
                style: TextStyle(
                    color: AppColor.colorGreen,
                    fontSize: AppFontSize.size_15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(onPressed: (){_changeLanguageController.onLanguageSave();},icon: const Icon(Icons.done,color: AppColor.colorGreen),
            )),
          ],
        ),
      ),
    );
  }


  _divider() {
    return Divider(
      color: Get.theme.primaryColor.withOpacity(0.5),
      height: AppSizes.height_1,
    );
  }
}
