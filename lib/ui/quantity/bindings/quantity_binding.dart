import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/quantity/controllers/quantity_controller.dart';

class QuantityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuantityController>(() => QuantityController());
  }
}
