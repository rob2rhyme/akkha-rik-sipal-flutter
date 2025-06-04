import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/counting/controllers/counting_controller.dart';

class CountingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CountingController>(() => CountingController());
  }
}
