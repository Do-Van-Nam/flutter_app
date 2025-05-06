import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:provider/provider.dart';


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
  int? _hoveredIndex;

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context);
    _songs = appState.songs;
    // _songs = widget.songs ?? _getDefaultSongs();
    _currentlyPlayingIndex = widget.currentlyPlayingIndex;
  }

  @override
  void didUpdateWidget(MusicPlaylistWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.songs != oldWidget.songs) {
      // _songs = widget.songs ?? _getDefaultSongs();
    }
    if (widget.currentlyPlayingIndex != oldWidget.currentlyPlayingIndex) {
      _currentlyPlayingIndex = widget.currentlyPlayingIndex;
    }
  }

  

  void _handleSongTap(int index) {
    // if (widget.onSongTap != null) {
    //   widget.onSongTap!(index);
    // } else {
    //   setState(() {
    //     _currentlyPlayingIndex = index;
    //   });
    // }
  }

  void _handleFavoriteTap(int index, bool isFavorite) {
    // if (widget.onFavoriteTap != null) {
    //   widget.onFavoriteTap!(index, isFavorite);
    // } else {
    //   setState(() {
    //     // _songs[index] = _songs[index].copyWith(isFavorite: isFavorite);
    //   });
    // }
  }

  void _handleOptionsTap(int index) {
    if (widget.onOptionsTap != null) {
      widget.onOptionsTap!(index);
    } else {
      showModalBottomSheet(
        context: context,
        builder: (context) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.playlist_add),
              title: const Text('Thêm vào danh sách phát'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Chia sẻ'),
              onTap: () => Navigator.pop(context),
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
        if (widget.showHeader)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                const SizedBox(width: 40, child: Text('#', style: TextStyle(fontWeight: FontWeight.bold))),
                const SizedBox(width: 60), // image space
                const Expanded(
                  flex: 2,
                  child: Text('Bài hát', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Expanded(
                  flex: 2,
                  child: Text('Lượt phát', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const Expanded(
                  flex: 2,
                  child: Text('Thời lượng', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(
                  width: 100,
                  child: Text('Tùy chọn', style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
        Expanded(
          child: ListView.builder(
            itemCount: _songs.length,
            itemBuilder: (context, index) {
              final song = _songs[index];
              final isPlaying = _currentlyPlayingIndex == index;
              final isHovered = _hoveredIndex == index;

              return MouseRegion(
                onEnter: (_) => setState(() => _hoveredIndex = index),
                onExit: (_) => setState(() => _hoveredIndex = null),
                child: GestureDetector(
                  onTap: () => _handleSongTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isPlaying
                          ? (widget.highlightColor ?? Colors.red.withOpacity(0.1))
                          : isHovered
                              ? Colors.red.withOpacity(0.05)
                              : (index % 2 == 0
                                  ? (widget.alternateRowColor ?? Colors.grey.withOpacity(0.05))
                                  : Colors.white),
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 40,
                          child: isPlaying
                              ? const Icon(Icons.play_arrow, color: Colors.red)
                              : isHovered
                                  ? const Icon(Icons.play_arrow, color: Colors.grey)
                                  : Text('${song.id}', style: const TextStyle(fontSize: 16)),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Image.network(
                            song.avatar,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 50,
                              height: 50,
                              color: Colors.purple,
                              child: const Icon(Icons.music_note, color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(song.songName ?? "", style: const TextStyle(fontWeight: FontWeight.bold)),
                              Text(song.artists.isNotEmpty ? song.artists[0].aliasName ?? "" : "", style: TextStyle(color: Colors.grey[600], fontSize: 13)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(song.totalListens.toString(), style: TextStyle(color: Colors.grey[700])),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(song.duration.toString(), style: TextStyle(color: Colors.grey[700])),
                        ),
                        SizedBox(
                          width: 100,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  song.isLike==1 ? Icons.favorite : Icons.favorite_border,
                                  color: Colors.red,
                                ),
                                onPressed: () => _handleFavoriteTap(index, song.isLike != 1),
                              ),  
                              IconButton(
                                icon: const Icon(Icons.more_vert),
                                color: Colors.black,
                                onPressed: () => _handleOptionsTap(index),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
