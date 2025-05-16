import 'package:flutter/material.dart';
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

import 'song_list_item.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  final query = '1';
  // final query = (Get.arguments as Map<String, String>)['query'] ?? '';

  int selectedIndex = -1; // Track the selected index

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

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
                          if (index == selectedIndex) {
                            selectedIndex = -1;
                          } else {
                            selectedIndex = index;
                          }
                        });
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 24),

              switch (selectedIndex) {
                0 => songSection(),
                1 => playlistSection(),
                2  => artistSection(),
                3  => albumSection(),
                -1 => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    songSection(),
                    const SizedBox(height: 16), 
                    playlistSection(),
                    const SizedBox(height: 16),
                    artistSection(),
                    const SizedBox(height: 16),
                    albumSection(),
                  ],
                ),
                _ => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Album",
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
                    for (int i = 0; i < 3; i++)
                      Row(
                        children: [
                          Expanded(
                            child: SongListItem(
                              title: 'Như Chưa Bao Giờ',
                              artist: 'Hồ Quang Hiếu',
                              time: 200,
                              imageIndex: i * 2 + 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
  Widget songSection() {
    return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'song'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 36 / 24, // line-height divided by font-size
                        letterSpacing: 0,
                      ),
                    ),
                    SizedBox(height: 16),
                    for (int i = 0; i < 3; i++)
                      Row(
                        children: [
                          Expanded(
                            child: SongListItem(
                              title: 'Như Chưa Bao Giờ',
                              artist: 'Hồ Quang Hiếu',
                              time: 200,
                              imageIndex: i * 2 + 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
                
  }
Widget playlistSection(){
  return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Playlist",
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
                    for (int i = 0; i < 3; i++)
                      Row(
                        children: [
                          Expanded(
                            child: SongListItem(
                              title: 'Như Chưa Bao Giờ',
                              artist: 'Hồ Quang Hiếu',
                              time: 200,
                              imageIndex: i * 2 + 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
}
Widget artistSection(){
  return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nghệ sĩ",
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
                    for (int i = 0; i < 3; i++)
                      Row(
                        children: [
                          Expanded(
                            child: SongListItem(
                              title: 'Như Chưa Bao Giờ',
                              artist: 'Hồ Quang Hiếu',
                              time: 200,
                              imageIndex: i * 2 + 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                ) ;
}
Widget albumSection(){
  return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Album",
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
                    for (int i = 0; i < 3; i++)
                      Row(
                        children: [
                          Expanded(
                            child: SongListItem(
                              title: 'Như Chưa Bao Giờ',
                              artist: 'Hồ Quang Hiếu',
                              time: 200,
                              imageIndex: i * 2 + 1,
                            ),
                          ),
                        ],
                      ),
                  ],
                );
                }
}
