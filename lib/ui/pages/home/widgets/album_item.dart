import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:provider/provider.dart';

class AlbumItem extends StatelessWidget {
  final String image;
  final String? title;
  final String artistName;
  final String? mediaPath;
  final SongItem? songItem;

  const AlbumItem({
    super.key,
    required this.image,
    this.title,
    required this.artistName,
    this.mediaPath,
    this.songItem,
  });

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        MediaQuery.of(context).size.width <
        600; // Adjust the breakpoint as needed
    return GestureDetector(
      onTap: () {
        if (songItem != null) {
          final appState = Provider.of<AppState>(context, listen: false);
          appState.setSong(songItem!);
        }
      },
      child: SizedBox(
        width: isMobile ? 160 : 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),

              child: CachedNetworkImage(
                imageUrl: image,
                width: isMobile ? 160 : 200,
                height: isMobile ? 160 : 200,
                fit: BoxFit.cover,
                placeholder:
                    (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
            if (title != null)
              Text(
                title!,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            Text(
              artistName,
              style: TextStyle(
                color: title != null ? const Color(0xFF757575) : Colors.black,
                fontWeight: title != null ? FontWeight.normal : FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
