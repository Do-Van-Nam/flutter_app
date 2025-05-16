import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/services/song_service.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/music_playlist.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class PlayingScreen extends StatefulWidget {
  const PlayingScreen({super.key});

  @override
  _CategoryRowState createState() => _CategoryRowState();
}

class _CategoryRowState extends State<PlayingScreen> {
  int selectedIndex = 0; // Track the selected index
  late Future<SongItem> _futureContent; // khởi tạo sớm

  @override
  void initState() {
    super.initState();
    AppState appState = Provider.of<AppState>(context, listen: false);

    _futureContent = SongService().fetchSongInfo(
      params: {
        'timestamp': 1714387200,
        'songId': appState.getSong?.id ?? 2398223,
      },
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<String> categories = ['song'.tr, 'Playlist', 'artist'.tr, 'Album'];
  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

    return FutureBuilder<SongItem>(
      future: _futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error loading song: ' + snapshot.error.toString()),
          );
        } else if (!snapshot.hasData) {
          return const Center(child: Text('No song available'));
        } else {
          final song = snapshot.data!;
          print(song.toJson());
          return MainLayout(
            content: Container(
              color: const Color(0xFFF5F5F5),
              height: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    !isMobile
                        ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Bên trái
                            buildLeftSection(song),

                            const SizedBox(width: 16),

                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = 0;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'next'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 24,
                                                            height: 36 / 24,
                                                            letterSpacing: 0,
                                                            color:
                                                                selectedIndex ==
                                                                        0
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                    ),
                                                    if (selectedIndex == 0)
                                                      Container(
                                                        height: 3,
                                                        width: 100,
                                                        color: Colors.red,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = 1;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'lyric'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 24,
                                                            height: 36 / 24,
                                                            letterSpacing: 0,
                                                            color:
                                                                selectedIndex ==
                                                                        1
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                    ),
                                                    if (selectedIndex == 1)
                                                      Container(
                                                        height: 3,
                                                        width: 100,
                                                        color: Colors.red,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = 2;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "related".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 24,
                                                            height: 36 / 24,
                                                            letterSpacing: 0,
                                                            color:
                                                                selectedIndex ==
                                                                        2
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                    ),
                                                    if (selectedIndex == 2)
                                                      Container(
                                                        height: 3,
                                                        width: 100,
                                                        color: Colors.red,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        switch (selectedIndex) {
                                          0 => SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.7,
                                            child: MusicPlaylistWidget(),
                                          ),
                                          1 => Container(
                                            padding: const EdgeInsets.all(16),
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.7,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "lyric".tr,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 16),
                                                  Text(
                                                    song.lyric.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      height: 1.6,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          2 => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [
                                              Text(
                                                'song_info'.tr,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'song'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song.songName,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Album",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            'Red',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'artist'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song.artists
                                                                .map(
                                                                  (a) =>
                                                                      a.aliasName,
                                                                )
                                                                .join(', '),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'author'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song
                                                                    .author
                                                                    ?.aliasName ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'genre'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song.categories!
                                                                .map(
                                                                  (a) =>
                                                                      a.cateName,
                                                                )
                                                                .join(', '),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 16),

                                              SectionHeader(
                                                title: 'like'.tr,
                                                onSeeAllPressed: () {},
                                              ),
                                              const SizedBox(height: 16),
                                              SingleChildScrollView(
                                                child:
                                                    buildRecommendationsList(),
                                              ),
                                              const SizedBox(height: 16),

                                              SectionHeader(
                                                title: 'artist'.tr,
                                                onSeeAllPressed: () {},
                                              ),
                                              const SizedBox(height: 16),
                                              SizedBox(
                                                height: 120,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      song.numberOfArtists,
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    final artists =
                                                        song.artists;
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Column(
                                                        children: [
                                                          ClipOval(
                                                            child: Image.asset(
                                                              'assets/images/Rectangle 6166-1.png',
                                                              width: 80,
                                                              height: 80,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            artists[index]
                                                                .aliasName,
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

                                              const SizedBox(height: 16),
                                            ],
                                          ),
                                          _ => const Text(
                                            "Chưa có nội dung",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        },
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                            ),
                          ],
                        )
                        : Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Bên trái
                            buildLeftSection(song),
                            const SizedBox(height: 16),

                            Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = 0;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'next'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 24,
                                                            height: 36 / 24,
                                                            letterSpacing: 0,
                                                            color:
                                                                selectedIndex ==
                                                                        0
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                    ),
                                                    if (selectedIndex == 0)
                                                      Container(
                                                        height: 3,
                                                        width: 100,
                                                        color: Colors.red,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = 1;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      'lyric'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 24,
                                                            height: 36 / 24,
                                                            letterSpacing: 0,
                                                            color:
                                                                selectedIndex ==
                                                                        1
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                    ),
                                                    if (selectedIndex == 1)
                                                      Container(
                                                        height: 3,
                                                        width: 100,
                                                        color: Colors.red,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 24),
                                            Expanded(
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    selectedIndex = 2;
                                                  });
                                                },
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "related".tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleLarge
                                                          ?.copyWith(
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 24,
                                                            height: 36 / 24,
                                                            letterSpacing: 0,
                                                            color:
                                                                selectedIndex ==
                                                                        2
                                                                    ? Colors.red
                                                                    : Colors
                                                                        .grey,
                                                          ),
                                                    ),
                                                    if (selectedIndex == 2)
                                                      Container(
                                                        height: 3,
                                                        width: 100,
                                                        color: Colors.red,
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 4,
                                                            ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 16),
                                        switch (selectedIndex) {
                                          0 => SizedBox(
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.7,
                                            child: MusicPlaylistWidget(),
                                          ),
                                          1 => Container(
                                            padding: const EdgeInsets.all(16),
                                            height:
                                                MediaQuery.of(
                                                  context,
                                                ).size.height *
                                                0.7,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "lyric".tr,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 16),
                                                  Text(
                                                    song.lyric.toString(),
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      height: 1.6,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),

                                          2 => Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,

                                            children: [
                                              Text(
                                                'song_info'.tr,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 16),
                                              Container(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'song'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song.songName,
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "Album",
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            'Red',
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'artist'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song.artists
                                                                .map(
                                                                  (a) =>
                                                                      a.aliasName,
                                                                )
                                                                .join(', '),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'author'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song
                                                                    .author
                                                                    ?.aliasName ??
                                                                "",
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(height: 8),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          'genre'.tr,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                            color:
                                                                Colors
                                                                    .grey[700],
                                                          ),
                                                        ),
                                                        SizedBox(width: 8),
                                                        Expanded(
                                                          child: Text(
                                                            song.categories!
                                                                .map(
                                                                  (a) =>
                                                                      a.cateName,
                                                                )
                                                                .join(', '),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 16),

                                              SectionHeader(
                                                title: 'like'.tr,
                                                onSeeAllPressed: () {},
                                              ),
                                              const SizedBox(height: 16),
                                              SingleChildScrollView(
                                                child:
                                                    buildRecommendationsList(),
                                              ),
                                              const SizedBox(height: 16),

                                              SectionHeader(
                                                title: 'artist'.tr,
                                                onSeeAllPressed: () {},
                                              ),
                                              const SizedBox(height: 16),
                                              SizedBox(
                                                height: 120,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount:
                                                      song.numberOfArtists,
                                                  itemBuilder: (
                                                    context,
                                                    index,
                                                  ) {
                                                    final artists =
                                                        song.artists;
                                                    return Container(
                                                      margin:
                                                          const EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                          ),
                                                      child: Column(
                                                        children: [
                                                          ClipOval(
                                                            child: Image.asset(
                                                              'assets/images/Rectangle 6166-1.png',
                                                              width: 80,
                                                              height: 80,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 8,
                                                          ),
                                                          Text(
                                                            artists[index]
                                                                .aliasName,
                                                            style:
                                                                const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),

                                              const SizedBox(height: 16),
                                            ],
                                          ),
                                          _ => const Text(
                                            "Chưa có nội dung",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        },
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              ),
                          ],
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

Widget buildLeftSection(SongItem song) {
  return SizedBox(
    width: 320,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            song.avatar,
            width: 320,
            height: 320,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          song.songName,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),

        Text(
          'by ${song.artists[0].aliasName ?? ""}',
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
            Icon(Icons.favorite, size: 16, color: const Color(0xFF757575)),
            const SizedBox(width: 4),
            Text(
              '${song.totalLiked} Yeu thich',
              style: TextStyle(
                color: const Color(0xFF757575),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(width: 8),
            Icon(Icons.comment, size: 16, color: const Color(0xFF757575)),
            const SizedBox(width: 4),
            Text(
              song.totalComment.toString(),
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

        Container(
          margin: const EdgeInsets.only(top: 16),
          child: ElevatedButton(
            onPressed: () {
              // Add functionality for "Đăng ký nhạc chờ" button
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.yellow,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            child: Text(
              'set_ringtone'.tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
        ),
      ],
    ),
  );
}
