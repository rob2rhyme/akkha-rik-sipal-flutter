import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/paint/controllers/paint_controller.dart';

class PaintBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaintController>(() => PaintController());
  }
}
