import 'package:flutter/material.dart';
import 'package:flutter_app/models/song_model.dart';

class SongTile extends StatelessWidget {
  final Song song;
  final VoidCallback onTap;
  
  const SongTile({
    Key? key,
    required this.song,
    required this.onTap,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      leading: Hero(
        tag: 'song-cover-${song.id}',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            song.coverUrl,
            width: 56,
            height: 56,
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        song.title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(song.artist),
      trailing: Text(
        _formatDuration(song.duration),
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onTap,
    );
  }
  
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
