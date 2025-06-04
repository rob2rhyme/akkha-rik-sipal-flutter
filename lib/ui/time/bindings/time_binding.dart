import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/time/controller/time_controller.dart';

class TimeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TimeController>(() => TimeController());
  }
}
