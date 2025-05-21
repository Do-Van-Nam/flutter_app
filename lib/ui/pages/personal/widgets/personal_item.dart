import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/song_model.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../../models/song_item.dart';

class PersonalItem extends StatelessWidget {
  final String title;
  final String artist;
  final int views;
  final String image;
  final SongItem? songItem;

  const PersonalItem({
    super.key,
    required this.title,
    required this.artist,
    required this.views,
    required this.image,
    this.songItem,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (songItem != null) {
          final appState = Provider.of<AppState>(context, listen: false);
          appState.setSong(songItem!);
        }
      },
      child: Container(
        width: 300,
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      placeholder:
                          (context, url) => const CircularProgressIndicator(),
                      errorWidget:
                          (context, url, error) => const Icon(Icons.error),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),

                        Row(
                          children: [
                            Text(
                              artist,
                              style: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(width: 4),

                            const Icon(
                              Icons.visibility,
                              color: Color(0xFF757575),
                              size: 12,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              views.toString(),
                              style: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Color(0xFFFF3956),
                    size: 20,
                  ),
                  onPressed: () {},
                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                ),
                
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
