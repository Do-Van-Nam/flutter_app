import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/ui/pages/home/widgets/category_chip.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/pages/library/widgets/add_new_playlist_button.dart';
import 'package:flutter_app/ui/pages/library/widgets/artist_item.dart';
import 'package:flutter_app/ui/pages/library/widgets/library_album_item.dart';
import 'package:flutter_app/ui/pages/library/widgets/playlist_item.dart';
import 'package:flutter_app/ui/widgets/comment_popup/comment_popup.dart';
import 'package:flutter_app/ui/widgets/music_playlist.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_app/ui/pages/explore/explore_screen.dart';

import 'package:get/state_manager.dart';

class LibraryPlaylistDetailScreen extends StatefulWidget {
  const LibraryPlaylistDetailScreen({super.key});

  @override
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<LibraryPlaylistDetailScreen> {
  int selectedIndex = 0; // Track the selected index

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<String> categories = ['song'.tr, 'Playlist', 'artist'.tr, 'Album'];
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 800;
    return MainLayout(
      content: Container(
        color: const Color(0xFFF5F5F5),
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
                !isMobile
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
            children:
                !isMobile
                    ? [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Bên trái
                          buildPlaylistInfo(context),
                          const SizedBox(width: 16),

                          // Bên phải: 2 phần tử xếp theo cột
                          Expanded(
                            child: Column(
                              children: [
                                buildPlaylistItem(context),
                                const SizedBox(height: 16),
                                buildRecommendList(context),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Bottom Section
                      buildRelatedPlaylist(context),
                    ]
                    : [
                      buildPlaylistInfo(context),
                      const SizedBox(height: 16),
                      buildPlaylistItem(context),
                      const SizedBox(height: 16),
                      buildRecommendList(context),
                      const SizedBox(height: 16),
                      buildRelatedPlaylist(context),
                    ],
          ),
        ),
      ),
    );
  }
}

Widget buildPlaylistInfo(context) {
  return SizedBox(
    width: 320,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            'assets/images/Rectangle 6166-1.png',
            width: 320,
            height: 320,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Taylor Swift",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),

        Text(
          'by Taylor Swift',
          style: TextStyle(
            color: const Color(0xFF757575),
            fontWeight: FontWeight.normal,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.access_time, size: 16, color: const Color(0xFF757575)),
            const SizedBox(width: 4),
            Text(
              '2 gio 54 phut',
              style: TextStyle(
                color: const Color(0xFF757575),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            Icon(Icons.favorite, size: 16, color: const Color(0xFF757575)),
            const SizedBox(width: 4),
            Text(
              '10k Yeu thich',
              style: TextStyle(
                color: const Color(0xFF757575),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const SizedBox(height: 8),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.comment, color: Colors.grey),
              onPressed: () {
                showBlurPopup(context);
              },
            ),
            SizedBox(width: 16),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.play_arrow, color: Colors.white),
            ),
            SizedBox(width: 16),

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
                      value: 'playlist',
                      child: Row(
                        children: [
                          Icon(
                            Icons.playlist_add,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'random_play'.tr,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'ringtone',
                      child: Row(
                        children:  [
                          Icon(Icons.music_note, size: 20, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'set_ringtone'.tr,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),

                    PopupMenuItem(
                      value: 'download',
                      child: Row(
                        children:  [
                          Icon(Icons.download, size: 20, color: Colors.black),
                          SizedBox(width: 8),
                          Text('download'.tr, style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'share',
                      child: Row(
                        children: [
                          Icon(Icons.share, size: 20, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'share'.tr,
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
  );
}

Widget buildPlaylistItem(context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: MusicPlaylistWidget(),
        ),
      ],
    ),
  );
}

Widget buildRecommendList(context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'recommend_songs'.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 36 / 24, // line-height divided by font-size
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: MusicPlaylistWidget(),
        ),
      ],
    ),
  );
}

Widget buildRelatedPlaylist(context) {
  return Container(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'recommend_playlist'.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 36 / 24, // line-height divided by font-size
            letterSpacing: 0,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          children: [
            // AddNewPlaylist(),
            for (int i = 1; i <= 5; i++)
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    '/library/playlist/${Uri.encodeComponent('Như Chưa Bao Giờ')}',
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: PlaylistItem(
                    imageIndex: i + 10,
                    title: 'Như Chưa Bao Giờ',
                    artistName: 'Channon',
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}
