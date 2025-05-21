import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/collection_list_service.dart';
import 'package:flutter_app/services/recommend_song_service.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/pages/ringstone/widgets/ringstone_item.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'dart:math';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class RingstoneScreen extends StatelessWidget {
  RingstoneScreen({super.key});
  final AppState appState = Get.put(AppState());

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;
    late Future<List<SongItem>> _futureContent;
    _futureContent = RecommendSongService().fetchRecommendSongContent();
    return FutureBuilder<List<SongItem>>(
      future: _futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return const Center(child: Text('Error loading recommend music'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No new music available'));
        } else {
          final songs = snapshot.data!;
          print(songs.length);
          return MainLayout(
            content: Container(
              color: Color(0xFFF5F5F5),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ringstone'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        height: 36 / 24, // line-height divided by font-size
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 16),
                    for (int i = 0; i < songs.length / 2 - 1; i++)
                      Container(
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              child: RingstoneItem(
                                title: songs[i * 2].songName,
                                artist: songs[i * 2].artists[0].aliasName,
                                views: songs[i * 2].totalListens,
                                image: songs[i * 2].avatar,
                                songItem: songs[i * 2]! as SongItem?,
                              ),
                            ),
                            Expanded(
                              child: RingstoneItem(
                                title: songs[i * 2 + 1].songName,
                                artist: songs[i * 2 + 1].artists[0].aliasName,
                                views: songs[i * 2 + 1].totalListens,
                                image: songs[i * 2 + 1].avatar,
                                songItem: songs[i * 2 + 1]! as SongItem?,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
