import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/settings/settings_controller.dart';

class SettingsPage extends GetView<SettingsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings_title'.tr),
      ),
      body: ListView(
        children: [
          // Language settings
          ListTile(
            title: Text('settings_language'.tr),
            trailing: Obx(() => Text(controller.getLanguageName())),
            onTap: () => _showLanguageDialog(context),
          ),
          Divider(),
          
          // Theme settings
          ListTile(
            title: Text('settings_theme'.tr),
            trailing: Obx(() => Text(controller.getThemeName())),
            onTap: () => _showThemeDialog(context),
          ),
          Divider(),
          
          // Playback history
          ListTile(
            title: Text('settings_history'.tr),
            subtitle: Obx(() => Text('${controller.playedSongs.length} songs')),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showHistoryDialog(context),
          ),
          Divider(),
          
          // About
          ListTile(
            title: Text('settings_about'.tr),
            trailing: Icon(Icons.chevron_right),
            onTap: () => _showAboutDialog(context),
          ),
          Divider(),
          
          // Logout
          ListTile(
            title: Text(
              'settings_logout'.tr,
              style: TextStyle(color: Colors.red),
            ),
            leading: Icon(Icons.logout, color: Colors.red),
            onTap: controller.logout,
          ),
        ],
      ),
    );
  }
  
  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings_language'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('language_english'.tr),
              onTap: () {
                controller.changeLanguage('en');
                Navigator.pop(context);
              },
              trailing: Obx(() => controller.currentLanguage.value == 'en'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : SizedBox.shrink()
              ),
            ),
            ListTile(
              title: Text('language_spanish'.tr),
              onTap: () {
                controller.changeLanguage('es');
                Navigator.pop(context);
              },
              trailing: Obx(() => controller.currentLanguage.value == 'es'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : SizedBox.shrink()
              ),
            ),
            ListTile(
              title: Text('language_french'.tr),
              onTap: () {
                controller.changeLanguage('fr');
                Navigator.pop(context);
              },
              trailing: Obx(() => controller.currentLanguage.value == 'fr'
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : SizedBox.shrink()
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings_theme'.tr),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('settings_theme_light'.tr),
              onTap: () {
                controller.changeTheme(ThemeMode.light);
                Navigator.pop(context);
              },
              trailing: Obx(() => controller.currentTheme.value == ThemeMode.light
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : SizedBox.shrink()
              ),
            ),
            ListTile(
              title: Text('settings_theme_dark'.tr),
              onTap: () {
                controller.changeTheme(ThemeMode.dark);
                Navigator.pop(context);
              },
              trailing: Obx(() => controller.currentTheme.value == ThemeMode.dark
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : SizedBox.shrink()
              ),
            ),
            ListTile(
              title: Text('settings_theme_system'.tr),
              onTap: () {
                controller.changeTheme(ThemeMode.system);
                Navigator.pop(context);
              },
              trailing: Obx(() => controller.currentTheme.value == ThemeMode.system
                ? Icon(Icons.check, color: Theme.of(context).primaryColor)
                : SizedBox.shrink()
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void _showHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('settings_history'.tr),
        content: Container(
          width: double.maxFinite,
          child: Obx(() => controller.playedSongs.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No played songs'),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: controller.playedSongs.length,
                itemBuilder: (context, index) {
                  final song = controller.playedSongs[index];
                  return ListTile(
                    title: Text(song.title),
                    subtitle: Text(song.artist),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: Image.network(
                        song.coverUrl,
                        width: 40,
                        height: 40,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              )
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
          TextButton(
            onPressed: () {
              controller.clearHistory();
              Navigator.pop(context);
            },
            child: Text('settings_clear_history'.tr),
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
  
  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'app_name'.tr,
      applicationVersion: '1.0.0',
      applicationIcon: Icon(
        Icons.music_note,
        size: 50,
        color: Theme.of(context).primaryColor,
      ),
      children: [
        SizedBox(height: 16),
        Text('A Flutter music app with Google login, multi-language support, and Firebase integration.'),
      ],
    );
  }
}
