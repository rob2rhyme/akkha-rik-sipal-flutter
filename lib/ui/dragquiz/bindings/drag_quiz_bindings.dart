import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/dragquiz/controllers/drag_quiz_controllers.dart';

class DragQuizBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DragQuizController>(() => DragQuizController());
  }
}
