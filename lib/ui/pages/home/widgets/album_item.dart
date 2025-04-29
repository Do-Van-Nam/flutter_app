import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AlbumItem extends StatelessWidget {
  final String image;
  final String? title;
  final String artistName;

  const AlbumItem({
    super.key,
    required this.image,
    this.title,
    required this.artistName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),

            child: CachedNetworkImage(
              imageUrl: image,
              width: 200,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
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
    );
  }
}
