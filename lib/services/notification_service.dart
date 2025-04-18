import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter_app/models/song_model.dart';

class NotificationService extends GetxService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = 
      FlutterLocalNotificationsPlugin();
  
  Future<NotificationService> init() async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onSelectNotification,
    );
    
    return this;
  }
  
  void _onSelectNotification(NotificationResponse response) {
    final String? payload = response.payload;
    if (payload != null) {
      final List<String> data = payload.split('|');
      final String action = data[0];
      final String songId = data[1];
      
      switch (action) {
        case 'play':
          Get.toNamed('/music-detail', arguments: songId);
          break;
        case 'pause':
          // Handle pause action
          break;
        case 'delete':
          // Handle delete action
          break;
      }
    }
  }
  
  Future<void> showMusicNotification(Song song, bool isPlaying) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'music_player_channel',
      'Music Player',
      channelDescription: 'Notifications for music player controls',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: false,
      ongoing: true,
      actions: [
        if (isPlaying)
          const AndroidNotificationAction(
            'pause',
            'Pause',
            // icon: 'pause',
            showsUserInterface: false,
          )
        else
          const AndroidNotificationAction(
            'play',
            'Play',
            // icon: 'play_arrow',
            showsUserInterface: false,
          ),
        const AndroidNotificationAction(
          'delete',
          'Delete',
          // icon: 'delete',
          showsUserInterface: false,
        ),
      ],
    );
    
    final DarwinNotificationDetails iOSPlatformChannelSpecifics =
        DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );
    
    final NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );
    
    await _flutterLocalNotificationsPlugin.show(
      0,
      song.title,
      song.artist,
      platformChannelSpecifics,
      payload: '${isPlaying ? "pause" : "play"}|${song.id}',
    );
  }
  
  Future<void> cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancel(0);
  }
}
