import 'package:get/get.dart';
import 'package:flutter_app/models/song_model.dart';
import 'package:flutter_app/services/music_service.dart';

class MusicDetailController extends GetxController {
  final MusicService _musicService = Get.find<MusicService>();
  
  Rx<Song> song = Song(
    id: '',
    title: '',
    artist: '',
    album: '',
    coverUrl: '',
    url: '',
    duration: Duration.zero,
  ).obs;
  
  RxBool isLoading = true.obs;
  RxBool isPlaying = false.obs;
  RxDouble progress = 0.0.obs;
  RxDouble duration = 0.0.obs;
  
  @override
  void onInit() {
    super.onInit();
    
    // Get song from arguments
    final songArg = Get.arguments;
    if (songArg is Song) {
      song.value = songArg;
    }
    
    // Listen to music service
    ever(_musicService.isPlaying, (playing) {
      isPlaying.value = playing;
    });
    
    ever(_musicService.progress, (value) {
      progress.value = value;
    });
    
    ever(_musicService.duration, (value) {
      duration.value = value;
    });
    
    // Start playing the song
    _playSong();
    
    isLoading.value = false;
  }
  
  Future<void> _playSong() async {
    await _musicService.playSong(song.value);
  }
  
  void togglePlayPause() {
    if (isPlaying.value) {
      _musicService.pause();
    } else {
      _musicService.resume();
    }
  }
  
  void seekTo(Duration position) {
    _musicService.seekTo(position);
  }
  
  @override
  void onClose() {
    // Don't stop the music when leaving the page
    super.onClose();
  }
}
