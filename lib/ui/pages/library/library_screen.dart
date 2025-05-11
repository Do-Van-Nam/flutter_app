import 'package:flutter/material.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/ui/pages/home/widgets/category_chip.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/pages/library/widgets/add_new_playlist_button.dart';
import 'package:flutter_app/ui/pages/library/widgets/artist_item.dart';
import 'package:flutter_app/ui/pages/library/widgets/library_album_item.dart';
import 'package:flutter_app/ui/pages/library/widgets/playlist_item.dart';
import 'package:flutter_app/ui/widgets/music_playlist.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_app/ui/pages/explore/explore_screen.dart';

import 'package:get/state_manager.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<LibraryScreen> {
  int selectedIndex = 0; // Track the selected index

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
final List<Artist> items = [
    Artist(id: 1, aliasName: 'Scotty McCreery', realName: 'Real Artist 1',avatar: 'https://freeimg.umusic.la/cms_upload/artist/2024/01/17/b8027b898bd006ed00ce8c39915e3a74.png'),
    Artist(id: 3, aliasName: 'Lê Hiếu', realName: 'Real Artist 2',avatar: 'https://freeimg.umusic.la/cms_upload/artist/2023/02/04/f3aca1f7f88e470ac98efe8a833e07eb.jpg'),
    Artist(id: 4, aliasName: 'The Men', realName: 'Real Artist 3',avatar: 'https://freeimg.umusic.la/cms_upload/artist/2022/10/28/2f03c1d3ba24b6c233a5be48d6bcd5b8.jpg'),
  ];
  final List<String> categories = ['Bài hát', 'Playlist', 'Nghệ sĩ', 'Album'];
  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Container(
        color: Color(0xFFF5F5F5),
        height: double.infinity,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // category Section
              Text(
                "Thư viện",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  height: 36 / 24, // line-height divided by font-size
                  letterSpacing: 0,
                ),
                // style: const TextStyle(
                //   fontWeight: FontWeight.bold,
                //   fontSize: 18,
                // ),
              ),
              const SizedBox(height: 16),
              // Category Chips
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
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
                      Icon(Icons.favorite, color: Colors.grey),
                      SizedBox(width: 16),
                      Icon(Icons.more_vert, color: Colors.grey),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: DropdownButton<String>(
                      hint: Text(
                        "Hoạt động gần đây",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      underline: SizedBox(),
                      icon: Icon(Icons.arrow_drop_down, color: Colors.black),
                      items: [
                        DropdownMenuItem<String>(
                          value: "recent",
                          child: Text("Hoạt động gần đây"),
                        ),
                        DropdownMenuItem<String>(
                          value: "added",
                          child: Text("Đã thêm gần đây"),
                        ),
                        DropdownMenuItem<String>(
                          value: "alphabetical",
                          child: Text("Theo bảng chữ cái"),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    return CategoryChip(
                      label: categories[index],
                      isSelected: index == selectedIndex,
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),

              switch (selectedIndex) {
                0 => SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: MusicPlaylistWidget(),
                ),
                1 => SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      AddNewPlaylist(),
                      SizedBox(width: 16),
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
                ),
                2 => Column(
                  children: [
                    for (int i = 0; i <= 2; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: ArtistItem(
                          id: items[i].id,
                          imageUrl:
                              items[i].avatar ?? '', // Updated to use a valid image URL
                          artistName: items[i].aliasName,
                          songCount: Random().nextInt(10),
                          onViewDetails: () {},
                          onAddToPlaylist: () {},
                          onShare: () {},
                        ),
                      ),
                  ],
                ),
                3 => Wrap(
                  children: [
                    for (int i = 1; i <= 5; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: LibraryAlbumItem(
                          imageIndex: i + 10,
                          title: 'Như Chưa Bao Giờ',
                          artistName: 'Channon',
                        ),
                      ),
                  ],
                ),
                _ => AddNewPlaylist(),
              },
            ],
          ),
        ),
      ),
    );
  }
}
