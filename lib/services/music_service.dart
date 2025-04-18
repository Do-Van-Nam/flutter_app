import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_app/models/song_model.dart';
import 'package:flutter_app/services/notification_service.dart';
import 'package:flutter_app/services/storage_service.dart';

class MusicService extends GetxService {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final NotificationService _notificationService = Get.find<NotificationService>();
  final StorageService _storageService = Get.find<StorageService>();
  
  Rx<Song?> currentSong = Rx<Song?>(null);
  RxBool isPlaying = false.obs;
  RxDouble progress = 0.0.obs;
  RxDouble duration = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
      if (currentSong.value != null) {
        _notificationService.showMusicNotification(
          currentSong.value!,
          state.playing,
        );
      }
    });
    
    _audioPlayer.positionStream.listen((position) {
      progress.value = position.inMilliseconds.toDouble();
    });
    
    _audioPlayer.durationStream.listen((d) {
      if (d != null) {
        duration.value = d.inMilliseconds.toDouble();
      }
    });
  }
  
  Future<void> playSong(Song song) async {
    if (currentSong.value?.id == song.id && isPlaying.value) {
      await pause();
      return;
    }
    
    currentSong.value = song;
    await _audioPlayer.setUrl(song.url);
    await _audioPlayer.play();
    _storageService.addPlayedSong(song.id);
  }
  
  Future<void> pause() async {
    await _audioPlayer.pause();
  }
  
  Future<void> resume() async {
    await _audioPlayer.play();
  }
  
  Future<void> stop() async {
    await _audioPlayer.stop();
    await _notificationService.cancelNotification();
    currentSong.value = null;
  }
  
  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }
  
  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
