import 'package:get/get.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  RxBool isLoading = false.obs;
  
  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    
    try {
      final result = await _authService.signInWithGoogle();
      if (result != null) {
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to sign in with Google',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
