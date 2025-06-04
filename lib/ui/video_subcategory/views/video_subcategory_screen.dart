import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/routes/app_routes.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_subcategory/controller/video_subcategory_controller.dart';
import 'package:akkha_rik_lipi_sipal/utils/color.dart';
import 'package:akkha_rik_lipi_sipal/utils/constant.dart';
import 'package:akkha_rik_lipi_sipal/utils/sizer_utils.dart';

class VideoSubCategoryScreen extends StatelessWidget {
  final VideoSubcategoryController videoSubcategoryController =
      Get.find<VideoSubcategoryController>();

  VideoSubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          videoSubcategoryController.title.toString().tr,
          style: TextStyle(
            color: AppColor.colorGreen,
            fontSize: AppFontSize.size_16,
            fontWeight: FontWeight.bold,
            fontFamily: "UrbanistBlack",
          ),
        ),
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
                    mainAxisSpacing: AppFontSize.size_8,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return subcategory(
                      logic.subCategory[index],
                      logic.videoCategory[index],
                      index,
                    );
                  },
                ),
              ),
              // const BannerAdClass()
            ],
          );
        },
      ),
    );
  }

  subcategory(String subcategoryList, String videoCategory, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.videoList, arguments: [videoCategory, index]);
      },
      child: Image.asset(Constant.getAssetSubCategory() + subcategoryList),
    );
  }
}
