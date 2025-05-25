import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/upper_lower/controller/upper_lower_controller.dart';

class UpperLowerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpperLowerController>(() => UpperLowerController());
  }
}
