import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/months_days/controllers/months_days_controller.dart';

class MonthsDaysBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MonthsDaysController>(() => MonthsDaysController());
  }
}
