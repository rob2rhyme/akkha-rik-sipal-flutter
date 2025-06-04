import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/add_subtract/controllers/add_subtract_controller.dart';

class AddSubtractBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSubtractController>(() => AddSubtractController());
  }
}
