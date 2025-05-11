import 'package:flutter/material.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/services/collection_detail_service.dart';
import 'package:flutter_app/ui/pages/home/widgets/album_item.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:get/get.dart';

class ExploreCategoryDetailScreen extends StatelessWidget {
  const ExploreCategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.parameters['collectionName'];
    final id = Get.parameters['collectionId'];
    // final collectionId = Get.parameters['collectionId'] ?? '';
    final collectionId = int.tryParse(Get.parameters['collectionId'] ?? '');
    if (collectionId == null) {
      return const Center(child: Text("Invalid collection ID"));
    }

    final Future<Collection> futureContent = CollectionDetailService()
        .fetchCollectionDetailContent(
          params: {'timestamp': 1714387200, 'collectionId': collectionId},
        );

    return FutureBuilder<Collection>(
      future: futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(futureContent);
          print(snapshot.error);
          return const Center(child: Text('Error loading content'));
        } else if (snapshot.hasData) {
          final _collection = snapshot.data!;

          return 
          MainLayout(
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
                    Text(
                      category == null ? "" : "${category}",
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
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceAround,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          for (int i = 0; i < _collection.items.length; i++)
                            SizedBox(
                              child: AlbumItem(
                                image: _collection.items[i].avatar,
                                title: _collection.items[i].itemName,
                                artistName: _collection.items[i].itemName,
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
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
