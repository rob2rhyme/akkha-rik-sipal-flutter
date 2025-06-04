import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/spelling/controller/spelling_controller.dart';

class SpellingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpellingController>(() => SpellingController());
  }
}
