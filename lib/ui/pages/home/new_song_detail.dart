import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/collection_detail_service.dart';
import 'package:flutter_app/services/song_service.dart';
import 'package:flutter_app/ui/pages/home/widgets/album_item.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class NewSongDetailScreen extends StatelessWidget {
  const NewSongDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late Future<List<SongItem>> _futureContent;
    _futureContent = SongService().fetchNewSongContent();
    return FutureBuilder<List<SongItem>>(
      future: _futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(_futureContent);
          print(snapshot.error);
          return const Center(child: Text('Error loading content'));
        } else if (snapshot.hasData) {
          final songs = snapshot.data!;

          Provider.of<AppState>(
            context,
            listen: false,
          ).setSongs(snapshot.data!);

          return MainLayout(
            content: Container(
              color: Color(0xFFF5F5F5),
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // category Section
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'home_newsong'.tr,
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              height:
                                  36 / 24, // line-height divided by font-size
                              letterSpacing: 0,
                            ),
                            // style: const TextStyle(
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: 18,
                            // ),
                          ),
                          const SizedBox(height: 16),
                          Wrap(
                            alignment: WrapAlignment.start,
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              for (int i = 0; i < songs.length; i++)
                                Padding(
                                  padding: const EdgeInsets.only(right: 16),
                                  child: AlbumItem(
                                    image: snapshot.data![i].avatar,
                                    title: snapshot.data![i].songName,
                                    artistName:
                                        snapshot.data![i].artists[0].aliasName,
                                    songItem: snapshot.data![i],
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
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
}
