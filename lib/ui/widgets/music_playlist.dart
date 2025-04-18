import 'package:flutter/material.dart';

// Model class for song items
class SongItem {
  final int id;
  final String title;
  final String artist;
  final String playCount;
  final String duration;
  final bool isFavorite;
  final String? imageUrl;

  const SongItem({
    required this.id,
    required this.title,
    required this.artist,
    required this.playCount,
    required this.duration,
    required this.isFavorite,
    this.imageUrl,
  });

  SongItem copyWith({
    int? id,
    String? title,
    String? artist,
    String? playCount,
    String? duration,
    bool? isFavorite,
    String? imageUrl,
  }) {
    return SongItem(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      playCount: playCount ?? this.playCount,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}

class MusicPlaylistWidget extends StatefulWidget {
  final List<SongItem>? songs;
  final int? currentlyPlayingIndex;
  final Function(int)? onSongTap;
  final Function(int, bool)? onFavoriteTap;
  final Function(int)? onOptionsTap;
  final Color? highlightColor;
  final Color? alternateRowColor;
  final bool showHeader;
  final String? headerTitle;
  
  const MusicPlaylistWidget({
    super.key,
    this.songs,
    this.onSongTap,
    this.onFavoriteTap,
    this.onOptionsTap,
    this.currentlyPlayingIndex,
    this.highlightColor,
    this.alternateRowColor,
    this.showHeader = true,
    this.headerTitle,
  });

  @override
  State<MusicPlaylistWidget> createState() => _MusicPlaylistWidgetState();
}

class _MusicPlaylistWidgetState extends State<MusicPlaylistWidget> {
  late List<SongItem> _songs;
  int? _currentlyPlayingIndex;
  
  @override
  void initState() {
    super.initState();
    // Initialize with provided songs or default songs
    _songs = widget.songs ?? _getDefaultSongs();
    _currentlyPlayingIndex = widget.currentlyPlayingIndex;
  }
  
  @override
  void didUpdateWidget(MusicPlaylistWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.songs != oldWidget.songs) {
      _songs = widget.songs ?? _getDefaultSongs();
    }
    if (widget.currentlyPlayingIndex != oldWidget.currentlyPlayingIndex) {
      _currentlyPlayingIndex = widget.currentlyPlayingIndex;
    }
  }
  
  // Default song list if none is provided
  List<SongItem> _getDefaultSongs() {
    return List.generate(
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
  }

  // Default handlers if none are provided
  void _handleSongTap(int index) {
    if (widget.onSongTap != null) {
      widget.onSongTap!(index);
    } else {
      setState(() {
        _currentlyPlayingIndex = index;
      });
    }
  }
  
  void _handleFavoriteTap(int index, bool isFavorite) {
    if (widget.onFavoriteTap != null) {
      widget.onFavoriteTap!(index, isFavorite);
    } else {
      setState(() {
        _songs[index] = _songs[index].copyWith(isFavorite: isFavorite);
      });
    }
  }
  
  void _handleOptionsTap(int index) {
    if (widget.onOptionsTap != null) {
      widget.onOptionsTap!(index);
    } else {
      // Default implementation - show a simple options menu
      showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Thêm vào danh sách phát'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Chia sẻ'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header row (optional)
        if (widget.showHeader)
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
            itemCount: _songs.length,
            itemBuilder: (context, index) {
              final song = _songs[index];
              final isPlaying = _currentlyPlayingIndex != null && index == _currentlyPlayingIndex;
              
              return Container(
                decoration: BoxDecoration(
                  color: isPlaying 
                    ? (widget.highlightColor ?? Colors.red.withOpacity(0.1)) 
                    : (index % 2 == 0 
                        ? (widget.alternateRowColor ?? Colors.grey.withOpacity(0.05)) 
                        : Colors.white),
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
                          song.imageUrl ?? 'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-t3xrEk9aPc7EBWsyugb2cBvuCqg7hh.png',
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
                          _handleFavoriteTap(index, !song.isFavorite);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_vert),
                        onPressed: () {
                          _handleOptionsTap(index);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    _handleSongTap(index);
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