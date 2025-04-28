import 'package:flutter/material.dart';
import 'package:flutter_app/models/song_item.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/new_song_service.dart';
import 'package:flutter_app/services/recommend_song_service.dart';
import 'package:flutter_app/ui/widgets/search_bar.dart';
import 'section_header.dart';
import 'song_list_item.dart';
import 'chart_item.dart';
import 'category_item.dart';
import 'album_item.dart';
import 'category_chip.dart';
import 'banner_slider.dart';
import 'package:get/get.dart';
import 'search_box.dart';


class MainContent extends StatelessWidget {
  
  const MainContent({super.key});

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
            SectionHeader(title: 'Nhạc mới', onSeeAllPressed: () {}),
            const SizedBox(height: 16),
            buildNewMusicSection(),
            const SizedBox(height: 24),

            // Favorite Songs Section
            SectionHeader(
              title: 'Những bản nhạc yêu thích dần trôi vào quên lãng',
              onSeeAllPressed: () {},
            ),
            const SizedBox(height: 16),
            buildFavoriteSongsSection(),
            const SizedBox(height: 24),

            // Recommendations Section
            SectionHeader(title: 'Đề xuất cho bạn', onSeeAllPressed: () {}),
            const SizedBox(height: 16),
            buildRecommendationsList(),
            const SizedBox(height: 24),

            // Charts Section
            SectionHeader(title: 'Bảng xếp hạng', onSeeAllPressed: () {}),
            const SizedBox(height: 16),
            buildChartsSection(context),
            const SizedBox(height: 24),

            // Themes Section
            SectionHeader(title: 'Chủ đề', onSeeAllPressed: () {}),
            const SizedBox(height: 16),
            buildThemesSection(),
            const SizedBox(height: 24),

            // Featured Artists Section
            SectionHeader(
              title: 'Album nghệ sỹ nổi bật',
              onSeeAllPressed: () {},
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
        return SingleChildScrollView(
    scrollDirection: Axis.horizontal,

    child: Row(
      children: [
        for (int i = 0; i < songs.length/3; i++)
          Column(
            children: [
              for (int j = 0; j < 3; j++)
                SongListItem(
                  title: songs[i * 3 + j].songName,
                  artist: songs[i * 3 + j].artists[0].aliasName,
                  views: songs[i * 3 + j].totalListens, 
                  image: songs[i * 3 + j].avatar,

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
  
  return isMobile ? Column( 
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
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
                        '/explore/ranking/${Uri.encodeComponent('Nhạc Lào')}',
                      ),
                    },
                child: Row(
                  children: [
                    const Text(
                      'Nhạc Lào',
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
            for (int i = 1; i <= 5; i++)
              ChartItem(
                position: i,
                title: 'Beautiful in white',
                artist: 'Hồ Quang Hiếu',
                imageIndex: i,
              ),
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
                        '/explore/ranking/${Uri.encodeComponent('Nhạc Lào')}',
                      ),
                    },
                child: Row(
                  children: [
                    const Text(
                      'Nhạc Lào',
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
            for (int i = 1; i <= 5; i++)
              ChartItem(
                position: i,
                title: 'Beautiful in white',
                artist: 'Hồ Quang Hiếu',
                imageIndex: i,
              ),
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
                          '/explore/ranking/${Uri.encodeComponent('Nhạc Lào')}',
                        ),
                      },
                  child: Row(
                    children: [
                      const Text(
                        'Nhạc Lào',
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
              for (int i = 1; i <= 5; i++)
                ChartItem(
                  position: i,
                  title: 'Beautiful in white',
                  artist: 'Hồ Quang Hiếu',
                  imageIndex: i,
                ),
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
                          '/explore/ranking/${Uri.encodeComponent('Nhạc Lào')}',
                        ),
                      },
                  child: Row(
                    children: [
                      const Text(
                        'Nhạc Lào',
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
                      Icon(Icons.chevron_right, size: 20, color: Colors.black),
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
              for (int i = 1; i <= 5; i++)
                ChartItem(
                  position: i,
                  title: 'Beautiful in white',
                  artist: 'Hồ Quang Hiếu',
                  imageIndex: i + 5,
                ),
            ],
          ),
        ),
      ),
    ],
  );
  

}

Widget buildThemesSection() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: const [
        CategoryItem(
          title: 'Nhạc US UK',
          color: Color(0xFFAA00FF),
          imageUrl: 'assets/images/Rectangle 6166-6.png',
        ),
        SizedBox(width: 16),
        CategoryItem(
          title: 'Thư giãn',
          color: Color(0xFF00C853),
          imageUrl: 'assets/images/Rectangle 6166-6.png',
        ),
        SizedBox(width: 16),
        CategoryItem(
          title: 'EDM',
          color: Color(0xFF2962FF),
          imageUrl: 'assets/images/Rectangle 6166-6.png',
        ),
      ],
    ),
  );
}

Widget buildFeaturedArtistsSection() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AlbumItem(
              image: "1",
              artistName:
                  i == 1
                      ? 'Khánh Linh'
                      : i == 2
                      ? 'Kim Anh Tuấn'
                      : i == 3
                      ? 'Mỹ Lan'
                      : i == 4
                      ? 'Hồ Quang Hiếu'
                      : 'Châu Khải',
            ),
          ),
      ],
    ),
  );
}

Widget buildNewMusicSection() {
  late Future<List<SongItem>> _futureContent;
  _futureContent = NewSongService().fetchNewSongContent();
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
