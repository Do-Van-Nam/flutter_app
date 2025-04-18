import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/login/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.music_note,
                size: 80,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 32),
              Text(
                'login_title'.tr,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Text(
                'login_subtitle'.tr,
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48),
              ElevatedButton.icon(
                onPressed: controller.signInWithGoogle,
                icon: Icon(Icons.login),
                label: Text('login_with_google'.tr),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
              ),
              SizedBox(height: 24),
              Obx(() => controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink()
              ),
            ],
          ),
        ),
      ),
    );
  }
}
