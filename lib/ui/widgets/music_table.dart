import 'package:flutter/material.dart';

class MusicPlaylistScreen extends StatefulWidget {
  const MusicPlaylistScreen({super.key});

  @override
  State<MusicPlaylistScreen> createState() => _MusicPlaylistScreenState();
}

class _MusicPlaylistScreenState extends State<MusicPlaylistScreen> {
  int currentlyPlayingIndex = 2; // Index of the currently playing song (0-based)

  final List<SongItem> songs = List.generate(
    10,
    (index) => SongItem(
      id: index + 1,
      title: 'Như Chưa Bao Giờ',
      artist: 'Hồ Quang Hiếu',
      playCount: '1.923.929',
      duration: '05:24',
      isFavorite: false,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return  Column(
        children: [
          // Header row
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              children: [
                SizedBox(width: 40, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]))),
                const Expanded(
                  flex: 3,
                  child: Text('Bài hát', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Lượt phát', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                ),
                Expanded(
                  flex: 2,
                  child: Text('Thời lượng', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700])),
                ),
                SizedBox(
                  width: 100,
                  child: Text('Tùy chọn', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[700]), textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          
          // Song list
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) {
                final song = songs[index];
                final isPlaying = index == currentlyPlayingIndex;
                
                return Container(
                  decoration: BoxDecoration(
                    color: isPlaying ? Colors.red.withOpacity(0.1) : (index % 2 == 0 ? Colors.grey.withOpacity(0.05) : Colors.white),
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade200),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    dense: false,
                    leading: SizedBox(
                      width: 40,
                      child: isPlaying 
                        ? const Icon(Icons.play_arrow, color: Colors.red)
                        : Text('${song.id}', style: const TextStyle(fontSize: 16)),
                    ),
                    title: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-t3xrEk9aPc7EBWsyugb2cBvuCqg7hh.png', // Using the image as a placeholder for the album art
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: 50,
                                height: 50,
                                color: Colors.purple,
                                child: const Icon(Icons.music_note, color: Colors.white),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                song.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                song.artist,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    subtitle: null,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100,
                          child: Text(
                            song.playCount,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            song.duration,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            song.isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: song.isFavorite ? Colors.red : Colors.red,
                          ),
                          onPressed: () {
                            setState(() {
                              songs[index] = song.copyWith(isFavorite: !song.isFavorite);
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            // Show options menu
                          },
                        ),
                      ],
                    ),
                    onTap: () {
                      setState(() {
                        currentlyPlayingIndex = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      );
    
  }
}

class SongItem {
  final int id;
  final String title;
  final String artist;
  final String playCount;
  final String duration;
  final bool isFavorite;

  const SongItem({
    required this.id,
    required this.title,
    required this.artist,
    required this.playCount,
    required this.duration,
    required this.isFavorite,
  });

  SongItem copyWith({
    int? id,
    String? title,
    String? artist,
    String? playCount,
    String? duration,
    bool? isFavorite,
  }) {
    return SongItem(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      playCount: playCount ?? this.playCount,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}