import 'package:flutter/material.dart';

class ArtistItem extends StatefulWidget {
  final String artistName;
  final String imageUrl;
  final int songCount;
  final Function()? onViewDetails;
  final Function()? onAddToPlaylist;
  final Function()? onShare;
  const ArtistItem({
    super.key,
    required this.artistName,
    required this.imageUrl,
    required this.songCount,
    this.onViewDetails,
    this.onAddToPlaylist,
    this.onShare,
  });

  @override
  State<ArtistItem> createState() => _ArtistItemState();
}

class _ArtistItemState extends State<ArtistItem> {
  final GlobalKey _key = GlobalKey();
  bool _isHovered = false;

  void _showDropdown() {
    final RenderBox renderBox = _key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx + renderBox.size.width - 200, // Đặt dropdown ở bên phải
        position.dy + renderBox.size.height - 50, // Nâng menu cao lên một chút
        position.dx + renderBox.size.width,
        position.dy + renderBox.size.height + 100,
      ),
      items: [
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.shuffle, color: Colors.black), // Icon cho menu item
              const SizedBox(width: 8),
              const Text(
                'Phát ngẫu nhiên',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onTap: widget.onViewDetails,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.remove_circle_outline, color: Colors.black), // Icon cho menu item
              const SizedBox(width: 8),
              const Text(
                'Bỏ quan tâm',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onTap: widget.onAddToPlaylist,
        ),
        PopupMenuItem(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.share, color: Colors.black), // Icon cho menu item
              const SizedBox(width: 8),
              const Text(
                'Chia sẻ',
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          onTap: widget.onShare,
        ),
      ],
      color: Colors.white, // Dropdown nền trắng
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8), // Bỏ góc
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: InkWell(
        key: _key,
        onTap: _showDropdown,
        child: Container(
          color: _isHovered ? Colors.red[100] : Colors.transparent, // Hover chuyển sang màu đỏ nhạt
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.artistName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      '${widget.songCount} bài hát',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert),
            ],
          ),
        ),
      ),
    );
  }
}