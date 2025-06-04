import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_subcategory/controller/video_subcategory_controller.dart';

class VideoSubcategoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoSubcategoryController>(() => VideoSubcategoryController());
  }
}
