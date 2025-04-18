import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StorageService extends GetxService {
  late GetStorage _box;
  
  Future<StorageService> init() async {
    _box = GetStorage();
    return this;
  }
  
  // Theme settings
  ThemeMode getThemeMode() {
    final String? theme = _box.read('theme');
    if (theme == 'dark') return ThemeMode.dark;
    if (theme == 'light') return ThemeMode.light;
    return ThemeMode.system;
  }
  
  Future<void> setThemeMode(ThemeMode themeMode) async {
    String theme;
    if (themeMode == ThemeMode.dark) {
      theme = 'dark';
    } else if (themeMode == ThemeMode.light) {
      theme = 'light';
    } else {
      theme = 'system';
    }
    await _box.write('theme', theme);
  }
  
  // Language settings
  String? getLanguage() {
    return _box.read('language');
  }
  
  Future<void> setLanguage(String languageCode) async {
    await _box.write('language', languageCode);
  }
  
  // Played songs history
  List<String> getPlayedSongs() {
    final List<dynamic>? songs = _box.read('played_songs');
    if (songs == null) return [];
    return songs.cast<String>();
  }
  
  Future<void> addPlayedSong(String songId) async {
    final List<String> songs = getPlayedSongs();
    if (!songs.contains(songId)) {
      songs.add(songId);
      await _box.write('played_songs', songs);
    }
  }
  
  Future<void> clearPlayedSongs() async {
    await _box.write('played_songs', []);
  }
  
  // User data
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.write('user_data', userData);
  }
  
  Map<String, dynamic>? getUserData() {
    return _box.read('user_data');
  }
  
  Future<void> clearUserData() async {
    await _box.remove('user_data');
  }
  
  // Check if user is logged in
  bool isLoggedIn() {
    return _box.hasData('user_data');
  }
}
