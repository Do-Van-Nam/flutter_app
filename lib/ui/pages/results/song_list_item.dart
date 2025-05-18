import 'package:flutter/material.dart';

class SongListItem extends StatefulWidget {
  final String title;
  final String artist;
  final int? duration;
  final int? numberOfSongs;
  final String image;

  const SongListItem({
    super.key,
    required this.title,
    required this.artist,
     this.duration,
     this.numberOfSongs,
    required this.image,
  });

  @override
  State<SongListItem> createState() => _SongListItemState();
}

class _SongListItemState extends State<SongListItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Container(
        decoration: BoxDecoration(
          color:
              _isHovered
                  ? Colors.red.shade50
                  : const Color(0xFFF5F5F5), // đổi màu khi hover
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: const Color(0xFFE0E0E0)),
        ),
        margin: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                widget.image,
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 56,
                    height: 56,
                    color: Colors.grey.shade200, // Placeholder background color
                    child: const Icon(
                      Icons.broken_image,
                      color: Colors.grey,
                      size: 28, // Icon size
                    ),
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
                    widget.title,
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
                        widget.artist,
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),

                      const Icon(
                        Icons.fiber_manual_record,
                        color: Color(0xFF757575),
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.duration != null ? widget.duration.toString() : '',
                        style: const TextStyle(
                          color: Color(0xFF757575),
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        widget.numberOfSongs != null ? widget.numberOfSongs.toString() : '',
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
            Row(
              children: [
                // IconButton(
                //   icon: const Icon(
                //     Icons.more_vert,
                //     color: Color(0xFF757575),
                //     size: 20,
                //   ),
                //   onPressed: () {},
                //   constraints: const BoxConstraints(),
                //   padding: const EdgeInsets.all(8),
                // ),
                PopupMenuButton(
                  icon: const Icon(
                    Icons.more_vert,
                    color: Color(0xFF757575),
                    size: 20,
                  ),

                  constraints: const BoxConstraints(),
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  offset: const Offset(0, 40),
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'song',
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.network(
                                  widget.image,
                                  width: 56,
                                  height: 56,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 56,
                                      height: 56,
                                      color: Colors.grey.shade200, // Placeholder background color
                                      child: const Icon(
                                        Icons.broken_image,
                                        color: Colors.grey,
                                        size: 28, // Icon size
                                      ),
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
                                      widget.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 2),

                                    Row(
                                      children: [
                                        Text(
                                          widget.artist,
                                          style: const TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.fiber_manual_record,
                                          color: Color(0xFF757575),
                                          size: 12,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          widget.duration != null ? widget.duration.toString() : '',
                                          style: const TextStyle(
                                            color: Color(0xFF757575),
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          widget.numberOfSongs != null ? widget.numberOfSongs.toString() : '',
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

                        PopupMenuItem(
                          value: 'playlist',
                          child: Row(
                            children: const [
                              Icon(
                                Icons.playlist_add,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Thêm vào playlist',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'ringtone',
                          child: Row(
                            children: const [
                              Icon(
                                Icons.music_note,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Cài đặt nhạc chờ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'radio',
                          child: Row(
                            children: const [
                              Icon(Icons.radio, size: 20, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Mở radio của bài hát',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'album',
                          child: Row(
                            children: const [
                              Icon(Icons.album, size: 20, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Xem album',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'artist',
                          child: Row(
                            children: const [
                              Icon(Icons.person, size: 20, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Xem nghệ sĩ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'download',
                          child: Row(
                            children: const [
                              Icon(
                                Icons.download,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Tải về',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          value: 'share',
                          child: Row(
                            children: const [
                              Icon(Icons.share, size: 20, color: Colors.black),
                              SizedBox(width: 8),
                              Text(
                                'Chia sẻ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                  onSelected: (value) {
                    // Handle menu item selection
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
