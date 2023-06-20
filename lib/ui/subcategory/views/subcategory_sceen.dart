import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/tables/sub_category_table.dart';
import 'package:kids_playroom/routes/app_routes.dart';
import 'package:kids_playroom/ui/subcategory/controllers/subcategory_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';

class SubCategoryScreen extends StatelessWidget {
  final SubCategoryController _subCategoryController =
      Get.find<SubCategoryController>();

  SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: topBar(),
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(Constant.getAssetBackground() + "bg_main.png",
              fit: BoxFit.cover,
              height: AppSizes.fullHeight,
              width: AppSizes.fullWidth),
          GetBuilder<SubCategoryController>(
              id: Constant.idSubCategory,
              builder: (logic) {
                return GridView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: logic.subcategoryList?.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppFontSize.size_8,
                      mainAxisSpacing: AppFontSize.size_8),
                  itemBuilder: (BuildContext context, int index) {
                    return subcategory(logic.subcategoryList![index],logic.catId);
                  },
                );
              })
        ],
      ),
    );
  }

  topBar() {
    return Container(
      width: AppSizes.fullWidth,
      color: AppColor.colorTheme,
      padding: EdgeInsets.only(
        left: AppSizes.width_3,
        right: AppSizes.width_3,
        top: AppSizes.height_5,
        bottom: AppSizes.height_2,
      ),
      child: Center(
        child: Row(
          children: [
            InkWell(
              onTap: () => Get.back(),
              child: Image.asset(Constant.getAssetIcons() + "btn_back_150.png",
                  height: AppSizes.height_4_5),
            ),
            Expanded(
              child: Center(
                child: Text(
                  _subCategoryController.title.toString().tr,
                  style: TextStyle(
                      color: AppColor.colorGreen,
                      fontSize: AppFontSize.size_16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  subcategory(SubCategoryTable subcategoryList, int? catId,) {
    return InkWell(
      onTap: () {
        if(catId == 1) {
          Get.toNamed(AppRoutes.items,arguments: [subcategoryList.subcategoryName,subcategoryList.subcategoryId] );
        }
        },
      child: Image.asset(
          Constant.getAssetSubCategory() + subcategoryList.subcategoryImage),
    );
  }
}
