import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/services/collection_list_service.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'dart:math';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatelessWidget {
  ExploreScreen({super.key});
  final AppState appState = Get.put(AppState());

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 800;

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
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.EXPLORE_NEW_RELEASE);
                        },
                        child:
                            !isMobile
                                ? Row(
                                  children: [
                                    Icon(
                                      Icons.new_releases,
                                      color: Colors.black,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'explore_new_release'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.new_releases,
                                      color: Colors.black,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                       'explore_new_release'.tr,
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
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.EXPLORE_CATEGORY);
                        },
                        child:
                            !isMobile
                                ? Row(
                                  children: [
                                    Icon(Icons.category, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'explore_category'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.category, color: Colors.black),
                                    SizedBox(height: 8),
                                    Text(
                                      'explore_category'.tr,
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
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.EXPLORE_RANKING);
                        },
                        child:
                            !isMobile
                                ? Row(
                                  children: [
                                    Icon(Icons.bar_chart, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'explore_ranking'.tr,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                                : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.bar_chart, color: Colors.black),
                                    SizedBox(width: 8),
                                    Text(
                                      'explore_ranking'.tr,
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
              SectionHeader(title: 'explore_newrelease'.tr, onSeeAllPressed: () {
                Get.toNamed(Routes.NEWSONG);
              }),
              const SizedBox(height: 16),
              buildNewMusicSection(),
              const SizedBox(height: 24),

              // category Section
              SectionHeader(title: 'explore_category'.tr, onSeeAllPressed: () {
                Get.toNamed(Routes.EXPLORE_CATEGORY);
              }),
              const SizedBox(height: 16),
              buildCategorySection(context),
              const SizedBox(height: 24),

              // New Songs Video Section
              SectionHeader(title: 'explore_newvideo'.tr, onSeeAllPressed: () {}),
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

Widget buildCategorySection(BuildContext context) {
  bool isMobile = MediaQuery.of(context).size.width < 800;
  final AppState appState = AppState();
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
        Provider.of<AppState>(
          context,
          listen: false,
        ).setCollections(snapshot.data!);

       

        List<Widget> buildCategoryRows() {
          List<Widget> rows = [];
          for (int i = 0; i < 3; i++) {
            rows.add(
              !isMobile
                  ? Row(
                    children: List.generate(3, (index) {
                      return Expanded(
                        child: Container(
                          margin: EdgeInsets.only(
                            right:
                                index < 3
                                    ? 8
                                    : 0, // Adjusted for 4 items per row
                          ),
                          child: CustomCategoryItem(
                            text: collections[i].items[index].itemName,
                            index: collections[i].items[index].id,
                          ),
                        ),
                      );
                    }),
                  )
                  : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(collections[i].items.length, (index) {
                        // 3 items per row for mobile
                        int categoryIndex = i * 3 + index;
                        if (categoryIndex < collections[i].items.length) {
                          return Container(
                            margin: EdgeInsets.only(
                              right:
                                  index < 2
                                      ? 8
                                      : 0, // Adjusted for 3 items per row
                            ),
                            child: SizedBox(
                              width: 160, // Fixed width for mobile
                              child: CustomCategoryItem(
                                text: collections[i].items[index].itemName,
                                index: collections[i].items[index].id,
                              ),
                            ),
                          );
                        } else {
                          return Container(); // Empty container if no category
                        }
                      }),
                    ),
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
    },
  );
}

class CustomCategoryItem extends StatelessWidget {
  final String text;
  final int index;

  CustomCategoryItem({required this.text, required this.index});

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
        Get.toNamed('/explore/category/${Uri.encodeComponent(text)}/${index}');
        // Handle tap event
        // For example, navigate to a new screen or show a dialog
      },
      child: Container(
        width: 169,
        height: 48,
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
        padding: EdgeInsets.all(12),
        child: Align(
          // Changed from Left to Align for alignment control
          alignment: Alignment.centerLeft, // Align text to the left
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
