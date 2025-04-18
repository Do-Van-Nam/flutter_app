import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'dart:math';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Container(
        color: Color(0xFFF5F5F5),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                            Get.toNamed(Routes.EXPLORE);
                          },
                        child: Row(
                          
                          children: [
                            Icon(Icons.new_releases, color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'Bài phát hành mới',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                            Get.toNamed(Routes.EXPLORE_CATEGORY);
                          },
                        child: Row(
                          children: [
                            Icon(Icons.category, color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'Thể loại',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                            Get.toNamed(Routes.EXPLORE_RANKING);
                          },
                        child: Row(
                          children: [
                            Icon(Icons.bar_chart, color: Colors.black),
                            SizedBox(width: 8),
                            Text(
                              'Bảng xếp hạng',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // New Music Section
              SectionHeader(title: 'Nhạc mới', onSeeAllPressed: () {}),
              const SizedBox(height: 16),
              buildNewMusicSection(),
              const SizedBox(height: 24),

              // category Section
              SectionHeader(
                title: 'Tâm trạng và thể loại',
                onSeeAllPressed: () {},
              ),
              const SizedBox(height: 16),
              buildCategorySection(),
              const SizedBox(height: 24),

              // New Songs Video Section
              SectionHeader(title: 'Video nhạc mới', onSeeAllPressed: () {}),
              const SizedBox(height: 16),
              buildFavoriteSongsSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCategorySection() {
  Color getRandomBoldColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ).withOpacity(0.8);
  }

  List<String> musicCategories = [
    'Nhạc US UK',
    'Thư giãn',
    'EDM',
    'Pop',
    'Rock',
    'Jazz',
    'Classical',
    'Hip Hop',
    'Country',
  ];

  String getRandomCategoryName() {
    final random = Random();
    return musicCategories[random.nextInt(musicCategories.length)];
  }

  List<Map<String, dynamic>> categories = [
    {'title': 'Nhạc US UK', 'color': Color(0xFFAA00FF)},
    {'title': 'Thư giãn', 'color': Color(0xFF00C853)},
    {'title': 'EDM', 'color': Color(0xFF2962FF)},
    {'title': 'Pop', 'color': Color(0xFFFF5722)},
    {'title': 'Rock', 'color': Color(0xFF3F51B5)},
    {'title': 'Jazz', 'color': Color(0xFFFFC107)},
    {'title': 'Classical', 'color': Color(0xFF607D8B)},
    {'title': 'Hip Hop', 'color': Color(0xFFE91E63)},
    {'title': 'Country', 'color': Color(0xFFFFEB3B)},
  ];

  List<Widget> buildCategoryRows() {
    List<Widget> rows = [];
    for (int i = 0; i < 3; i++) {
      rows.add(
        Row(
        children: List.generate(4, (index) { // Increased to 4 items per row
          int categoryIndex = i * 4 + index;
            if (categoryIndex < categories.length) {
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                  right: index < 3 ? 8 : 0, // Adjusted for 4 items per row
                ),
                  child: CustomCategoryItem(
                    text: categories[categoryIndex]['title'],
                  ),
                ),
              );
            } else {
              return Expanded(
                child: Container(),
              ); // Empty container if no category
            }
          }),
        ),
      );
      if (i < 2) {
        rows.add(SizedBox(height: 16));
      }
    }
    return rows;
  }



  return Column(children: buildCategoryRows());
}

class CustomCategoryItem extends StatelessWidget {
  final String text;

  CustomCategoryItem({required this.text});

  Color getRandomBoldColor() {
    final random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    ).withOpacity(0.8);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/explore/category/${text}');
        // Handle tap event
        // For example, navigate to a new screen or show a dialog
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border(
            right: BorderSide(
              // Changed from right to left for left alignment
              color: getRandomBoldColor(),
              width: 6.0, // Thicker border
            ),
          ),
        ),
        padding: EdgeInsets.all(16),
        child: Align(
          // Changed from Left to Align for alignment control
          alignment: Alignment.centerLeft, // Align text to the left
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
