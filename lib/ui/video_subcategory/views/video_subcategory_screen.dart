import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/routes/app_routes.dart';
import 'package:kids_playroom/ui/video_subcategory/controller/video_subcategory_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';
import 'package:kids_playroom/google_ads/custom_ad.dart';

class VideoSubCategoryScreen extends StatelessWidget {
  final VideoSubcategoryController videoSubcategoryController =
      Get.find<VideoSubcategoryController>();

  VideoSubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: topBar(),
      ),
      body: GetBuilder<VideoSubcategoryController>(
          id: Constant.idSubCategory,
          builder: (logic) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: logic.subCategory.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppFontSize.size_12,
                        mainAxisSpacing: AppFontSize.size_8),
                    itemBuilder: (BuildContext context, int index) {
                      return subcategory(
                        logic.subCategory[index],
                        logic.videoCategory[index],
                        index
                      );
                    },
                  ),
                ),
                const BannerAdClass()
              ],
            );
          }),
    );
  }

  topBar() {
    return Container(
      width: AppSizes.fullWidth,
      color: AppColor.colorTheme,
      padding: EdgeInsets.only(
        left: AppSizes.width_3,
        top: AppSizes.height_5_5,
        bottom: AppSizes.height_1,
      ),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Image.asset(Constant.getAssetIcons() + "btn_back_150.png",
                height: AppSizes.height_5),
          ),
          Center(
            child: Text(
              videoSubcategoryController.title.toString().tr,
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

  subcategory(String subcategoryList, String videoCategory,int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.videoList, arguments: [
          videoCategory,
          index
        ]);
      },
      child: Image.asset(Constant.getAssetSubCategory() + subcategoryList),
    );
  }
}
