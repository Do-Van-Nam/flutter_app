import 'package:flutter/material.dart';
import 'package:flutter_app/models/search_result.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/search_result_service.dart';
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
  final keyword = Get.arguments['query'] ?? '';
  int selectedIndex = -1; // Track the selected index
  late Future<List<Group>> _futureContent;

  @override
  void initState() {
    super.initState();
    _futureContent = SearchResultService().fetchSearchResultContent(
      params: {'timestamp': 1714387200, 'qrTxt': keyword},
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<String> categories = ['Bài hát', 'Playlist', 'Nghệ sĩ', 'Album'];
  @override
  Widget build(BuildContext context) {
    // late Future<List<Group>> _futureContent;
    // _futureContent = SearchResultService().fetchSearchResultContent(
    //   params: {'timestamp': 1714387200, 'qrTxt': keyword},
    // );
    return FutureBuilder<List<Group>>(
      future: _futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(_futureContent);
          print(snapshot.error);
          return const Center(child: Text('Error loading content'));
        } else if (snapshot.hasData) {
          final groups = snapshot.data!;

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
                    selectedIndex == 0 || selectedIndex == -1
                        ? songSection(groups)
                        : SizedBox(height: 0),
                    selectedIndex == 1 || selectedIndex == -1
                        ? playlistSection(groups)
                        : SizedBox(height: 0),
                    selectedIndex == 2 || selectedIndex == -1
                        ? artistSection(groups)
                        : SizedBox(height: 0),
                    selectedIndex == 3 || selectedIndex == -1
                        ? albumSection(groups)
                        : SizedBox(height: 0),
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }

  Widget songSection(groups) {
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
        for (int i = 0; i < groups[1].items.length; i++)
          Row(
            children: [
              Expanded(
                child: SongListItem(
                  title: groups[1].items[i].songInfo.songName,
                  artist:
                      groups[1].items[i].songInfo?.artists[0].aliasName ?? '',
                  duration: groups[1].items[i].songInfo.duration ?? 0,
                  image: groups[1].items[i].avatar,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget playlistSection(groups) {
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
        for (int i = 0; i < groups[2].items.length; i++)
          Row(
            children: [
              Expanded(
                child: SongListItem(
                  title: groups[2].items[i].itemName,
                  artist: groups[2].items[i].itemName ?? '',
                  numberOfSongs:
                      groups[2].items[i].albumInfo != null
                          ? groups[2].items[i].albumInfo?.numberOfSongs ?? 0
                          : groups[2].items[i].playlistInfo?.numberOfSongs ?? 0,
                  image: groups[2].items[i].avatar,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget artistSection(groups) {
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
        for (int i = 0; i < groups[3].items.length; i++)
          Row(
            children: [
              Expanded(
                child: SongListItem(
                  title: groups[3].items[i].itemName,
                  artist: groups[3].items[i].artistInfo?.realName ?? '',
                  numberOfSongs:
                      groups[3].items[i].artistInfo?.numberOfSongs ?? 0,
                  image: groups[3].items[i].avatar,
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget albumSection(groups) {
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
        for (int i = 0; i < groups[2].items.length; i++)
          Row(
            children: [
              Expanded(
                child: SongListItem(
                  title: groups[2].items[i].itemName,
                  artist: groups[2].items[i].itemName ?? '',
                  numberOfSongs:
                      groups[2].items[i].albumInfo != null
                          ? groups[2].items[i].albumInfo?.numberOfSongs ?? 0
                          : groups[2].items[i].playlistInfo?.numberOfSongs ?? 0,
                  image: groups[2].items[i].avatar,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
