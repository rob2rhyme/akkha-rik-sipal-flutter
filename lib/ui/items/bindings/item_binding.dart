import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/items/controllers/item_controller.dart';

class ItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ItemController>(() => ItemController());
  }
}
