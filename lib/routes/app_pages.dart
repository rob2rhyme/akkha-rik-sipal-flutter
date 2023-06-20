import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:kids_playroom/ui/home/bindings/home_binding.dart';
import 'package:kids_playroom/ui/home/views/home_screen.dart';
import 'package:kids_playroom/ui/items/bindings/item_binding.dart';
import 'package:kids_playroom/ui/items/controllers/item_controller.dart';
import 'package:kids_playroom/ui/items/views/items_screen.dart';
import 'package:kids_playroom/ui/single_item/bindings/single_item_binding.dart';
import 'package:kids_playroom/ui/single_item/controllers/single_item_controller.dart';
import 'package:kids_playroom/ui/single_item/views/single_item_screen.dart';
import 'package:kids_playroom/ui/subcategory/bindings/subcategory_binding.dart';
import 'package:kids_playroom/ui/subcategory/views/subcategory_sceen.dart';
import 'package:kids_playroom/utils/color.dart';
import 'package:sizer/sizer.dart';

import 'app_routes.dart';

class AppPages {
  static var list = [
    GetPage(
      name: AppRoutes.home,
      page: () =>HomeScreen(),
      binding: HomeBinding(),
    ),


    GetPage(
      name: AppRoutes.subcategory,
      page: () => SubCategoryScreen(),
      binding: SubCategoryBinding(),
    ),
    GetPage(
      name: AppRoutes.items,
      page: () => ItemScreen(),
      binding:  ItemBinding(),
    ),  GetPage(
      name: AppRoutes.singleItem,
      page: () => SingleItemScreen(),
      binding:  SingleItemBinding(),
    ),

  ];
}
