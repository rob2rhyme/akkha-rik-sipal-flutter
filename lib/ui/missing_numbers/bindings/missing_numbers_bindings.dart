import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/missing_numbers/controllers/missing_numbers_controller.dart';

class MissingNumbersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MissingNumbersController>(() => MissingNumbersController());
  }
}
