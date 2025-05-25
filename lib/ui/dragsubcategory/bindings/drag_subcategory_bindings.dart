import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/dragsubcategory/controllers/drag_subcategory_controllers.dart';

class DragSubcategoryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DragSubcategoryControllers>(() => DragSubcategoryControllers());
  }
}
