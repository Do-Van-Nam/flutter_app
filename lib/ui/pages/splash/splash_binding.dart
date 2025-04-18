import 'package:get/get.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/ui/pages/splash/splash_controller.dart';

class SplashBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthService());
    Get.put(SplashController());
  }
}
