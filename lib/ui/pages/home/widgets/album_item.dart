import 'package:flutter/material.dart';

class AlbumItem extends StatelessWidget {
  final int imageIndex;
  final String? title;
  final String artistName;

  const AlbumItem({
    super.key,
    required this.imageIndex,
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
            child: Image.asset(
              'assets/images/Rectangle 6166-$imageIndex.png',
              width: 200,
              height: 200,
              fit: BoxFit.cover,
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
