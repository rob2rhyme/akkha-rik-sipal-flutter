import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/subcategory/controllers/subcategory_controller.dart';

class SubCategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubCategoryController>(() => SubCategoryController());
  }
}
