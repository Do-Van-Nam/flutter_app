import 'package:flutter/material.dart';

class LibraryAlbumItem extends StatefulWidget {
  final int imageIndex;
  final String? title;
  final String artistName;

  const LibraryAlbumItem({
    super.key,
    required this.imageIndex,
    this.title,
    required this.artistName,
  });

  @override
  State<LibraryAlbumItem> createState() => _LibraryAlbumItemState();
}

class _LibraryAlbumItemState extends State<LibraryAlbumItem> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600; // Adjust the breakpoint as needed
    return SizedBox(
      width: isMobile ? 140 : 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => _isHovering = true),
            onExit: (_) => setState(() => _isHovering = false),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/Rectangle 6166-${widget.imageIndex}.png',
                    width: isMobile ? 160 : 200,
                    height: isMobile ? 160 : 200,
                    fit: BoxFit.cover,
                  ),
                ),
                if (_isHovering)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite , color: Colors.red, size: 30),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.play_circle_filled, color: Colors.white, size: 30),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert, color: Colors.white, size: 30),
                            iconSize: 30,
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (widget.title != null)
            Text(
              widget.title!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          Text(
            widget.artistName,
            style: TextStyle(
              color: widget.title != null ? const Color(0xFF757575) : Colors.black,
              fontWeight: widget.title != null ? FontWeight.normal : FontWeight.bold,
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
