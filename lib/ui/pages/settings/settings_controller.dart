import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/models/song_model.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/auth_service.dart';
import 'package:flutter_app/services/storage_service.dart';

class SettingsController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final StorageService _storageService = Get.find<StorageService>();
  
  RxString currentLanguage = 'en'.obs;
  Rx<ThemeMode> currentTheme = ThemeMode.system.obs;
  RxList<Song> playedSongs = <Song>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Load current settings
    final String? language = _storageService.getLanguage();
    if (language != null) {
      currentLanguage.value = language;
    }
    
    currentTheme.value = _storageService.getThemeMode();
    
    // Load played songs
    _loadPlayedSongs();
  }
  
  Future<void> _loadPlayedSongs() async {
    final List<String> songIds = _storageService.getPlayedSongs();
    
    // This would typically fetch songs from an API
    // For demo purposes, we'll create some mock data
    final List<Song> songs = [];
    
    for (final id in songIds.reversed) {
      songs.add(Song(
        id: id,
        title: 'Song $id',
        artist: 'Artist',
        album: 'Album',
        coverUrl: 'https://via.placeholder.com/300',
        url: 'https://example.com/song$id.mp3',
        duration: Duration(minutes: 3, seconds: 30),
      ));
    }
    
    playedSongs.value = songs;
  }
  
  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;
    _storageService.setLanguage(languageCode);
    Get.updateLocale(Locale(languageCode));
  }
  
  void changeTheme(ThemeMode themeMode) {
    currentTheme.value = themeMode;
    _storageService.setThemeMode(themeMode);
    Get.changeThemeMode(themeMode);
  }
  
  void clearHistory() {
    _storageService.clearPlayedSongs();
    playedSongs.clear();
  }
  
  Future<void> logout() async {
    await _authService.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }
  
  String getLanguageName() {
    switch (currentLanguage.value) {
      case 'en':
        return 'language_english'.tr;
      case 'es':
        return 'language_spanish'.tr;
      case 'fr':
        return 'language_french'.tr;
      default:
        return 'language_english'.tr;
    }
  }
  
  String getThemeName() {
    switch (currentTheme.value) {
      case ThemeMode.light:
        return 'settings_theme_light'.tr;
      case ThemeMode.dark:
        return 'settings_theme_dark'.tr;
      case ThemeMode.system:
        return 'settings_theme_system'.tr;
      default:
        return 'settings_theme_system'.tr;
    }
  }
}
