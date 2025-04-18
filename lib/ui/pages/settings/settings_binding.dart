import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/settings/settings_controller.dart';

class SettingsBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(SettingsController());
  }
}
