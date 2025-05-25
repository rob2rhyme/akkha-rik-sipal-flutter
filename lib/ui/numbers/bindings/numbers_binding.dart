import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/numbers/controllers/numbers_controller.dart';

class NumbersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NumbersController>(() => NumbersController());
  }
}
