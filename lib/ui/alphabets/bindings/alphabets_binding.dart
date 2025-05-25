import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/alphabets/controllers/alphabets_controller.dart';

class AlphabetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlphabetsController>(() => AlphabetsController());
  }
}
