import 'package:get/get.dart';
import 'package:flutter_app/services/music_service.dart';
import 'package:flutter_app/ui/pages/home/home_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MusicService());
    Get.put(HomeController());
  }
}
