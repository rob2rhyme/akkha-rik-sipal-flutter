import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/video_player/controller/video_player_controller.dart';

class VideoPlayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VideoPlayerController>(() => VideoPlayerController());
  }
}
