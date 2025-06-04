import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/compare/controllers/compare_controller.dart';

class CompareBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompareController>(() => CompareController());
  }
}
