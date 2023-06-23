import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/tables/category_table.dart';
import 'package:kids_playroom/routes/app_routes.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController _homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: topBar(),
        elevation: 0.5,
      ),
      backgroundColor: AppColor.white,
      body: Column(
        children: [
          GetBuilder<HomeController>(
              id: Constant.idHomePage,
              builder: (logic) {
                return Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(AppFontSize.size_8_5),
                    itemCount: logic.categoryList!.length,
                    itemBuilder: (context, index) =>
                        categoryItem(logic.categoryList![index]),
                  ),
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
        right: AppSizes.width_3,
        top: AppSizes.height_5,
        bottom: AppSizes.height_1,
      ),
      child: Center(
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "txtAppName".tr,
                  style: TextStyle(
                      color: AppColor.colorGreen,
                      fontSize: AppFontSize.size_16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Image.asset(Constant.getAssetIcons() + "ic_setting.png",
                height: AppSizes.height_5),
          ],
        ),
      ),
    );
  }

  categoryItem(CategoryTable categoryList) {
    return InkWell(
      onTap: ()=>  Get.toNamed(AppRoutes.subcategory,arguments: [categoryList.categoryName,categoryList.categoryId] ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(Constant.getAsset() + categoryList.categoryImage),
        ),
      ),
    );
  }
}
