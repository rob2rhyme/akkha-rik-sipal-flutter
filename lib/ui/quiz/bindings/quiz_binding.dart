import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/quiz/controller/quiz_controller.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizController>(() => QuizController());
  }
}
