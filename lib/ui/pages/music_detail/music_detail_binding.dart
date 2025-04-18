import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/music_detail/music_detail_controller.dart';

class MusicDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MusicDetailController());
  }
}
