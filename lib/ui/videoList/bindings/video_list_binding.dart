import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/videoList/controller/video_list_controller.dart';

class VideoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoListController>(() => VideoListController());
  }
}
