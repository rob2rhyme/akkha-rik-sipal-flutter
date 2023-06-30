import 'package:animate_do/animate_do.dart';
  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kids_playroom/database/tables/item_table.dart';
import 'package:kids_playroom/main.dart';
import 'package:kids_playroom/routes/app_routes.dart';
import 'package:kids_playroom/ui/items/controllers/item_controller.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:kids_playroom/utils/constant.dart';
import 'package:kids_playroom/utils/sizer_utils.dart';
import 'package:kids_playroom/utils/utils.dart';

class ItemScreen extends StatelessWidget {
  ItemScreen({super.key});

  final ItemController _itemController = Get.find<ItemController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(flexibleSpace: topBar(), automaticallyImplyLeading: false),
        body: Stack(
          children: <Widget>[
            Image.asset(Constant.getAssetBackground() + "bg_main.png",
                fit: BoxFit.cover,
                height: AppSizes.fullHeight,
                width: AppSizes.fullWidth),
            GetBuilder<ItemController>(
                id: Constant.idItem,
                builder: (logic) {
                   return GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount:logic.itemList?.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppFontSize.size_8,
                        mainAxisSpacing: AppFontSize.size_8),
                    itemBuilder: (BuildContext context, int index) {
                      return items(logic.itemList![index],index);
                    },
                  );

                })
          ],
        ));
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
      child: Center(
        child: Stack(
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Image.asset(Constant.getAssetIcons() + "btn_back_150.png",
                  height: AppSizes.height_5),
            ),
            Center(
              child: Text(
                _itemController.title.toString().tr,
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
  }

  items(ItemTable itemList, int index) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.singleItem, arguments: index);
        MyApp.flutterTts.stop();
        Utils.textToSpeech(
            itemList.itemNameTts!.tr.toLowerCase(), MyApp.flutterTts);
      },
      child: FadeInUp(
        child: Container(
          padding: EdgeInsets.all(AppSizes.height_2),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: AppColor.colorGray50,
                    blurRadius: 2,
                    offset: Offset(1.5, 1.5),
                    spreadRadius: 1)
              ]),
          child: Image.asset(Constant.getAsset() + itemList.itemImage + ".png"),
        ),
      ),
    );
  }
}

Widget Function(BuildContext context, int index, Animation<double> animation)
    animationItemBuilder(Widget Function(int index) child,
            {EdgeInsets padding = EdgeInsets.zero}) =>
        (BuildContext context, int index, Animation<double> animation) =>
            FadeTransition(
              opacity: Tween<double>(begin: 0, end: 1).animate(animation),
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -0.1),
                  end: Offset.zero,
                ).animate(animation),
                child: Padding(
                  padding: padding,
                  child: child(index),
                ),
              ),
            );
