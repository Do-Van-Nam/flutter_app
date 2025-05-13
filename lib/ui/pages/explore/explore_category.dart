import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/collection_item.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_app/ui/pages/explore/explore_screen.dart';

import 'package:get/state_manager.dart';
import 'package:provider/provider.dart';

class ExploreCategoryScreen extends StatelessWidget {
  ExploreCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final collection = appState.collections;
    
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
              ...collection.asMap().entries.map((entry) {
                int index = entry.key;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      collection[index].collectionName,
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
                    buildCategorySection(collection[index].items),
                    const SizedBox(height: 24),
                  ],
                );
              }).toList(),

             
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCategorySection(List<CollectionItem> items) {
  
  List<Widget> buildCategoryItems() {
    return List.generate(items.length, (index) {
      return Container(
        width: 140,
        margin: EdgeInsets.only(
          right: (index + 1) % 4 == 0 ? 0 : 8, // Adjust margin for wrapping
          bottom: 16, // Add bottom margin for spacing between lines
        ),
        child: CustomCategoryItem(text: items[index].itemName, index: items[index].id), // Updated to use items[index].title
      );
    });
  }

  return SizedBox(
    width: double.infinity, // Make the wrap take 100% width of its parent
    child: Wrap(
      alignment: WrapAlignment.start,
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
