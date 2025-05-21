import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import '../models/song_item.dart'; 

class AudioPlayerController extends GetxController {
  final AudioPlayer player = AudioPlayer();
  Rx<Duration> position = Duration.zero.obs;
  Rx<Duration> duration = Duration.zero.obs;
  RxBool isPlaying = false.obs;
  Rxn<SongItem> currentSong = Rxn<SongItem>();

  @override
  void onInit() {
    super.onInit();

    player.positionStream.listen((pos) {
      position.value = pos;
    });

    player.durationStream.listen((dur) {
      duration.value = dur ?? Duration.zero;
    });

    player.playingStream.listen((playing) {
      isPlaying.value = playing;
    });
  }

  Future<void> loadAndPlay(SongItem song) async {
    if (currentSong.value?.mediaPath == song.mediaPath) return;

    try {
      await player.setUrl(song.mediaPath ?? '');
      await player.play();
      currentSong.value = song;
    } catch (e) {
      print("Error loading song: $e");
    }
  }

  void pause() {
    player.pause();
  }

  void resume() {
    player.play();
  }

  @override
  void onClose() {
    player.dispose();
    super.onClose();
  }
}
