import 'package:get/get.dart';
import 'package:flutter_app/models/song_model.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/music_service.dart';
import 'package:flutter_app/services/storage_service.dart';

class HomeController extends GetxController {
  final MusicService _musicService = Get.find<MusicService>();
  final StorageService _storageService = Get.find<StorageService>();
  
  RxBool isLoading = true.obs;
  RxList<Song> allSongs = <Song>[].obs;
  RxList<Song> filteredSongs = <Song>[].obs;
  RxList<Song> recentSongs = <Song>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadSongs();
    _loadRecentSongs();
  }
  
  Future<void> _loadSongs() async {
    isLoading.value = true;
    
    try {
      // This would typically be an API call
      // For demo purposes, we'll create some mock data
      await Future.delayed(Duration(seconds: 1));
      
      final List<Song> songs = [
        Song(
          id: '1',
          title: 'Blinding Lights',
          artist: 'The Weeknd',
          album: 'After Hours',
          coverUrl: 'https://via.placeholder.com/300',
          url: 'https://example.com/song1.mp3',
          duration: Duration(minutes: 3, seconds: 20),
        ),
        Song(
          id: '2',
          title: 'Dance Monkey',
          artist: 'Tones and I',
          album: 'The Kids Are Coming',
          coverUrl: 'https://via.placeholder.com/300',
          url: 'https://example.com/song2.mp3',
          duration: Duration(minutes: 3, seconds: 29),
        ),
        Song(
          id: '3',
          title: 'Don\'t Start Now',
          artist: 'Dua Lipa',
          album: 'Future Nostalgia',
          coverUrl: 'https://via.placeholder.com/300',
          url: 'https://example.com/song3.mp3',
          duration: Duration(minutes: 3, seconds: 3),
        ),
        Song(
          id: '4',
          title: 'Watermelon Sugar',
          artist: 'Harry Styles',
          album: 'Fine Line',
          coverUrl: 'https://via.placeholder.com/300',
          url: 'https://example.com/song4.mp3',
          duration: Duration(minutes: 2, seconds: 54),
        ),
        Song(
          id: '5',
          title: 'Circles',
          artist: 'Post Malone',
          album: 'Hollywood\'s Bleeding',
          coverUrl: 'https://via.placeholder.com/300',
          url: 'https://example.com/song5.mp3',
          duration: Duration(minutes: 3, seconds: 35),
        ),
      ];
      
      allSongs.value = songs;
      filteredSongs.value = songs;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load songs',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  void _loadRecentSongs() {
    final List<String> recentSongIds = _storageService.getPlayedSongs();
    
    if (recentSongIds.isNotEmpty) {
      // Wait for allSongs to be loaded
      ever(allSongs, (_) {
        if (allSongs.isNotEmpty) {
          final List<Song> recent = [];
          
          for (final id in recentSongIds.reversed) {
            final song = allSongs.firstWhereOrNull((s) => s.id == id);
            if (song != null) {
              recent.add(song);
            }
            
            if (recent.length >= 5) break; // Limit to 5 recent songs
          }
          
          recentSongs.value = recent;
        }
      });
    }
  }
  
  void filterSongs(String query) {
    if (query.isEmpty) {
      filteredSongs.value = allSongs;
    } else {
      filteredSongs.value = allSongs.where((song) {
        return song.title.toLowerCase().contains(query.toLowerCase()) ||
               song.artist.toLowerCase().contains(query.toLowerCase()) ||
               song.album.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }
  
  void onSongTap(Song song) {
    Get.toNamed(Routes.MUSIC_DETAIL, arguments: song);
  }
}
