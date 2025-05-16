import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/models/rank_list.dart';
import 'package:flutter_app/models/recommend_song_item.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/collection_list_service.dart';
import 'package:flutter_app/services/song_service.dart';
import 'package:flutter_app/services/rank_list_service.dart';
import 'package:flutter_app/services/recommend_song_service.dart';
import 'package:flutter_app/ui/widgets/search_bar.dart';
import 'package:provider/provider.dart';
import 'section_header.dart';
import 'song_list_item.dart';
import 'chart_item.dart';
import 'category_item.dart';
import 'album_item.dart';
import 'category_chip.dart';
import 'banner_slider.dart';
import 'package:get/get.dart';
import 'search_box.dart';


class MainContent extends StatefulWidget {
  
  const MainContent({super.key});

  @override
  State<MainContent> createState() => _MainContentState();
}

class _MainContentState extends State<MainContent> {

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  void _loadData() async {
  try {
    List<Collection> collections = await CollectionListService().fetchCollectionListContent();
    Provider.of<AppState>(
      context,
      listen: false,
    ).setCollections(collections);
  } catch (e) {
    // xử lý lỗi nếu cần
    print('Lỗi khi fetch dữ liệu: $e');
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFF5F5F5),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            buildSearchBar(),

            // Banner Slider
            BannerSlider(),
            const SizedBox(height: 24),

            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  CategoryChip(label: 'R&B', isSelected: true),
                  CategoryChip(label: 'LAMVONG', isSelected: false),
                  CategoryChip(label: 'DRIVING', isSelected: false),
                  CategoryChip(label: 'COFFE', isSelected: false),
                  CategoryChip(label: 'SPORT', isSelected: false),
                  CategoryChip(label: 'TẾT', isSelected: false),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // New Music Section
            SectionHeader(title: 'home_newsong'.tr, onSeeAllPressed: () {
              Get.toNamed(
                Routes.NEWSONG,
              );
            }),
            const SizedBox(height: 16),
            buildNewMusicSection(),
            const SizedBox(height: 24),

            // Favorite Songs Section
            SectionHeader(
              title: 'home_favorite'.tr,
              onSeeAllPressed: () {},
            ),
            const SizedBox(height: 16),
            buildFavoriteSongsSection(),
            const SizedBox(height: 24),

            // Recommendations Section
            SectionHeader(title: 'home_recommend'.tr, onSeeAllPressed: () {
              Get.toNamed(Routes.RECOMMEND_SONG);
            }),
            const SizedBox(height: 16),
            buildRecommendationsList(),
            const SizedBox(height: 24),

            // Charts Section
            SectionHeader(title: 'home_ranking'.tr, onSeeAllPressed: () {
              Get.toNamed(Routes.EXPLORE_RANKING);

            }),
            const SizedBox(height: 16),
            buildChartsSection(context),
            const SizedBox(height: 24),

            // Themes Section
            SectionHeader(title: 'home_category'.tr, onSeeAllPressed: () {
              Get.toNamed(Routes.EXPLORE_CATEGORY);
            }),
            const SizedBox(height: 16),
            buildThemesSection(),
            const SizedBox(height: 24),

            // Featured Artists Section
            SectionHeader(
              title: 'home_album'.tr,
              onSeeAllPressed: () {
                Get.toNamed(Routes.LIBRARY);
              },
            ),
            const SizedBox(height: 16),
            buildFeaturedArtistsSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

Widget buildRecommendationsList() {
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
        return SingleChildScrollView(
    scrollDirection: Axis.horizontal,

    child: Row(
      children: [
        for (int i = 0; i < songs.length/3-1; i++)
          Column(
            children: [
              for (int j = 0; j < 3; j++)
                SongListItem(
                  title: songs[i * 3 + j].songName,
                  artist: songs[i * 3 + j].artists[0].aliasName,
                  views: songs[i * 3 + j].totalListens, 
                  image: songs[i * 3 + j].avatar,
                  songItem: songs[i * 3 + j]! as SongItem?,
                ),
              
            ],
          ),
      ],
    ),
  );

      }
    },
  );
  }

Widget buildChartsSection(context) {
  final bool isMobile = MediaQuery.of(context).size.width < 1000;

  Future<List<RankList>> _futureContent;
  _futureContent = RankListService().fetchRankListContent();
  return FutureBuilder<List<RankList>>(
    future: _futureContent,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading charts'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No charts available'));
      } else {
        final charts = snapshot.data!;
        return isMobile ? Column( 
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(

      //  width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF001F3F), Color(0xFFFF4136)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap:
                    () => {
                      Get.toNamed(
                        '/explore/ranking/${Uri.encodeComponent(charts[0].cateName)}',
                      ),
                    },
                child: Row(
                  children: [
                    Text(
                      charts[0].cateName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 10,
                        ),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (int i = 0; i < charts[0].items.length; i++)
              ChartItem(
                position: i+1,
                title: charts[0].items[i].songName,
                artist: charts[0].items[i].artists[0].aliasName,
                imageIndex: charts[0].items[i].avatar,
              ),
      SizedBox(height: 8),
          
          ],
        ),
      ),
      const SizedBox(height: 16),
      Container(
        
                  // width: MediaQuery.of(context).size.width * 0.25,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF001F3F), Color(0xFFFF4136)],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap:
                    () => {
                      Get.toNamed(
                        '/explore/ranking/${Uri.encodeComponent(charts[1].cateName)}',
                      ),
                    },
                child: Row(
                  children: [
                    Text(
                      charts[1].cateName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 10,
                        ),
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            for (int i = 0; i < charts[1].items.length; i++)
              ChartItem(
                position: i+1,
                title: charts[1].items[i].songName,
                artist: charts[1].items[i].artists[0].aliasName,
                imageIndex: charts[1].items[i].avatar,
              ),
      SizedBox(height: 8),

          ],
        ),
      ),
      ],
  ): Row( 
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
          
                    // width: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF001F3F), Color(0xFFFF4136)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap:
                      () => {
                        Get.toNamed(
                          '/explore/ranking/${Uri.encodeComponent(charts[0].cateName)}',
                        ),
                      },
                  child: Row(
                    children: [
                      const Text(
                        'Laos Songs',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 10,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (int i = 0; i < charts[0].items.length; i++)
                ChartItem(
                  position: i+1,
                  title: charts[0].items[i].songName,
                  artist: charts[0].items[i].artists[0].aliasName,
                  imageIndex: charts[0].items[i].avatar,
                ),
      SizedBox(height: 8),

            ],
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Container(
                    // width: MediaQuery.of(context).size.width * 0.25,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF001F3F), Color(0xFFFF4136)],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: GestureDetector(
                  onTap:
                      () => {
                        Get.toNamed(
                          '/explore/ranking/${Uri.encodeComponent(charts[1].cateName)}',
                        ),
                      },
                  child: Row(
                    children: [
                      Text(
                        charts[1].cateName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.white,
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      // Icon(Icons.chevron_right, size: 20, color: Colors.black),
                      const Spacer(),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.1),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 10,
                          ),
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              for (int i = 0; i < charts[1].items.length; i++)
                ChartItem(
                  position: i+1,
                  title: charts[1].items[i].songName,
                  artist: charts[1].items[i].artists[0].aliasName,
                  imageIndex: 'i + 5',
                ),
      SizedBox(height: 8),

            ],
          ),
        ),
      ),
    ],
  );
      }
    },
  );
  
  
  

}

Widget buildThemesSection() {
  Future<List<Collection>> _futureContent;
  _futureContent = CollectionListService().fetchCollectionListContent();
  return FutureBuilder<List<Collection>>(
    future: _futureContent,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading charts'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No charts available'));
      } else {
        final collections = snapshot.data!;
        
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (var collection in collections)
          Row(
            children: [
              CategoryItem(
                title: collection.collectionName,
                color: Color(0xFF2962FF),
                imageUrl: collection.items[0].avatar,
              ),
        SizedBox(width: 16),

            ],
          ),
        
      ],
    ),
  );
      }
      }
  );


}

Widget buildFeaturedArtistsSection() {

  Future<List<Collection>> _futureContent;
  _futureContent = CollectionListService().fetchCollectionListContent();
  return FutureBuilder<List<Collection>>(
    future: _futureContent,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading charts'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No charts available'));
      } else {
        final collections = snapshot.data!;
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < collections.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AlbumItem(
              image: collections[i].items[1].avatar,
              artistName:
                  collections[i].items[1].itemName,
            ),
          ),
      ],
    ),
  );
      }
    },
  );

}

Widget buildNewMusicSection() {
  late Future<List<SongItem>> _futureContent;
  _futureContent = SongService().fetchNewSongContent();
  return FutureBuilder<List<SongItem>>(
    future: _futureContent,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading new music'));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No new music available'));
      } else {
        final songs = snapshot.data!;
        
        Provider.of<AppState>(
          context,
          listen: false,
        ).setSongs(snapshot.data!);
        return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 0; i < songs.length; i++)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AlbumItem(
              image: snapshot.data![i].avatar,
              title: snapshot.data![i].songName,
              artistName: snapshot.data![i].artists[0].aliasName,
                mediaPath: snapshot.data![i].mediaPath,
                songItem: snapshot.data![i],
            ),
          ),
      ],
    ),
  );
      }
    },
  );
  
}

Widget buildFavoriteSongsSection() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,

    child: Row(
      children: [
        for (int i = 1; i <= 3; i++)
          Padding(
            padding: EdgeInsets.only(right: i < 3 ? 6 : 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'assets/images/Rectangle 6166-${i + 0}.png',
                        // width: double.infinity,
                        width: 300,
                        height: 169,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Dancing with your ghost',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Row(
                  children: [
                    const Text(
                      'Alex sander',
                      style: TextStyle(color: Color(0xFF757575), fontSize: 12),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.visibility,
                      color: Color(0xFF757575),
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '10 Tr lượt xem',
                      style: TextStyle(color: Color(0xFF757575), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
