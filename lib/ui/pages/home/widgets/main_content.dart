import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'section_header.dart';
import 'song_list_item.dart';
import 'chart_item.dart';
import 'category_item.dart';
import 'album_item.dart';
import 'category_chip.dart';
import 'banner_slider.dart';
import 'package:get/get.dart';

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
            Container(
              height: 40,
              margin: const EdgeInsets.only(bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //  Ô tìm kiếm
                  // Expanded(
                  //   child:
                  Container(
                    width: 600,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Color(0xFF9E9E9E)),
                        SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            textAlignVertical: TextAlignVertical.center,
                            decoration: InputDecoration(
                              hintText: 'Search (Ctrl+/)',
                              hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
                              border: InputBorder.none,
                              isDense: true, // Giúp thu gọn TextField
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 10,
                              ), // Căn giữa dọc
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ),
                  const SizedBox(width: 16),

                  //  Các icon bên phải
                  Row(
                    children: [
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.language,
                          color: Color(0xFF9E9E9E),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        offset: const Offset(0, 40),
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                value: 'en',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/en.png',
                                          width: 24,
                                          height: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'English',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(left: 40),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.red,
                                        border: Border.all(
                                          color: Colors.red,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'vi',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/vn.png',
                                          width: 24,
                                          height: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Việt Nam',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(left: 40),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'la',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/la.png',
                                          width: 24,
                                          height: 16,
                                        ),
                                        const SizedBox(width: 8),
                                        const Text(
                                          'Lào',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      margin: const EdgeInsets.only(left: 40),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                        onSelected: (value) {
                          // Handle language selection
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.notifications_none,
                          color: Color(0xFF9E9E9E),
                        ),
                        onPressed: () {},
                      ),
                      PopupMenuButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Color(0xFF9E9E9E),
                        ),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        offset: const Offset(0, 40),
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                value: 'terms',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.description,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Điều khoản dịch vụ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'privacy',
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.security,
                                          size: 20,
                                          color: Colors.black,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          'Chính sách bảo mật',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                    Icon(
                                      Icons.chevron_right,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'language',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.language,
                                      size: 20,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Thay đổi ngôn ngữ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 'logout',
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      size: 20,
                                      color: Colors.red,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Đăng xuất',
                                      style: TextStyle(color: Colors.red),
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

            // Banner Slider
            const BannerSlider(),
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
            buildChartsSection(),
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
  return Column(
    children: [
      for (int i = 0; i < 3; i++)
        Row(
          children: [
            Expanded(
              child: SongListItem(
                title: 'Như Chưa Bao Giờ',
                artist: 'Hồ Quang Hiếu',
                views: '10 Tr lượt xem',
                imageIndex: i * 2 + 1,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SongListItem(
                title: 'Như Chưa Bao Giờ',
                artist: 'Hồ Quang Hiếu',
                views: '10 Tr lượt xem',
                imageIndex: i * 2 + 2,
              ),
            ),
          ],
        ),
    ],
  );
}

Widget buildChartsSection() {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Container(
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
                  imageIndex: i,
                ),
            ],
          ),
        ),
      ),
      const SizedBox(width: 16),
      Expanded(
        child: Container(
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
  return Row(
    children: const [
      Expanded(
        child: CategoryItem(
          title: 'Nhạc US UK',
          color: Color(0xFFAA00FF),
          imageUrl: 'assets/images/Rectangle 6166-6.png',
        ),
      ),
      SizedBox(width: 16),
      Expanded(
        child: CategoryItem(
          title: 'Thư giãn',
          color: Color(0xFF00C853),
          imageUrl: 'assets/images/Rectangle 6166-6.png',
        ),
      ),
      SizedBox(width: 16),
      Expanded(
        child: CategoryItem(
          title: 'EDM',
          color: Color(0xFF2962FF),
          imageUrl: 'assets/images/Rectangle 6166-6.png',
        ),
      ),
    ],
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
              imageIndex: i,
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
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: [
        for (int i = 1; i <= 5; i++)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: AlbumItem(
              imageIndex: i + 10,
              title: 'Như Chưa Bao Giờ',
              artistName: 'Channon',
            ),
          ),
      ],
    ),
  );
}

Widget buildFavoriteSongsSection() {
  return Row(
    children: [
      for (int i = 1; i <= 3; i++)
        Expanded(
          child: Padding(
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
        ),
    ],
  );
}
