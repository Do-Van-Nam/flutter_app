import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:get/get.dart';

PreferredSizeWidget mobileAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 4,
    centerTitle: true,
    iconTheme: const IconThemeData(color: Colors.black),
    title: GestureDetector(
      onTap: () {
        Get.toNamed(Routes.HOME);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFA70C1D), Color(0xFF0153B4)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.cover,
                width: 20,
                height: 20,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Image.asset('assets/images/app_name.png', width: 100, height: 40),
        ],
      ),
    ), // Icon in the center
    actions: <Widget>[
      GestureDetector(
        onTap: () {
          Get.toNamed(Routes.PROFILE);
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/Rectangle 6166-6.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ],
  );
}
