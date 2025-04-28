import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_app/ui/pages/explore/explore_screen.dart';

import 'package:get/state_manager.dart';

class ExploreCategoryScreen extends StatelessWidget {
  const ExploreCategoryScreen({super.key});

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
                "Tâm trạng và thể loại",
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
              buildCategorySection(),
              const SizedBox(height: 24),

              // category Section
              Text(
                "Dòng nhạc",
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
              buildCategorySection(),
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

  List<Widget> buildCategoryItems() {
    return List.generate(categories.length, (index) {
      return Container(
        width: 220,
        margin: EdgeInsets.only(
          right: (index + 1) % 4 == 0 ? 0 : 8, // Adjust margin for wrapping
          bottom: 16, // Add bottom margin for spacing between lines
        ),
        child: CustomCategoryItem(
          text: categories[index]['title'],
        ),
      );
    });
  }

  return SizedBox(
    width: double.infinity, // Make the wrap take 100% width of its parent
    child: Wrap(
      alignment: WrapAlignment.spaceBetween,
      spacing: 8, // Horizontal spacing between items
      children: buildCategoryItems(),
    ),
  );
}

class CustomCategoryItem1 extends StatelessWidget {
  final String text;

  CustomCategoryItem1({required this.text});

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
        Get.toNamed('/explore/category/${Uri.encodeComponent(text)}');
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
