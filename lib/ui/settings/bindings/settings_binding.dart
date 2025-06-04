import 'package:get/get.dart';
import 'package:akkha_rik_lipi_sipal/ui/settings/controller/settings_controller.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
