import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/single_item/controllers/single_item_controller.dart';

class SingleItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SingleItemController>(() => SingleItemController());
  }
}
