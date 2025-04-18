import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/scroll_behavior.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_app/firebase_options.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/notification_service.dart';
import 'package:flutter_app/services/storage_service.dart';
import 'package:flutter_app/translations/app_translations.dart';
import 'package:flutter_app/ui/theme/app_theme.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  
  // // Initialize Firebase
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  
  // // Initialize Crashlytics
  // FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  
  // // Initialize local storage
  // await GetStorage.init();
  
  // // Initialize services
  // await Get.putAsync(() => StorageService().init());
  // await Get.putAsync(() => NotificationService().init());
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final storageService = Get.find<StorageService>();
    // final String initialLocale = storageService.getLanguage() ?? 'en';
    
    return GetMaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      title: 'UMusic',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      // themeMode: storageService.getThemeMode(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      // locale: Locale(initialLocale),
      fallbackLocale: Locale('en'),
      translations: AppTranslations(),
    );
  }
}
