import 'package:get/get.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/auth_service.dart';

class SplashController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }
  
  Future<void> _checkAuth() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
    
    if (_authService.isLoggedIn()) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.LOGIN);
    }
  }
}
