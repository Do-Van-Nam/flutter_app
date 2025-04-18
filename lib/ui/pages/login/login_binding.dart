import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/login/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}
