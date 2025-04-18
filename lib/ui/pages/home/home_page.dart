import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/models/song_model.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/ui/pages/home/home_controller.dart';
import 'package:flutter_app/ui/widgets/song_tile.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home_title'.tr),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Get.toNamed(Routes.SETTINGS),
          ),
        ],
      ),
      body: Obx(() => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : _buildContent(context)
      ),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'home_search'.tr,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: controller.filterSongs,
          ),
          SizedBox(height: 24),
          
          // Recently played section
          Text(
            'home_recent'.tr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12),
          Obx(() => controller.recentSongs.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('No recent songs'),
                ),
              )
            : SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.recentSongs.length,
                  itemBuilder: (context, index) {
                    final song = controller.recentSongs[index];
                    return _buildRecentSongCard(context, song);
                  },
                ),
              )
          ),
          
          SizedBox(height: 24),
          
          // Popular songs section
          Text(
            'home_popular'.tr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(height: 12),
          Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.filteredSongs.length,
            itemBuilder: (context, index) {
              final song = controller.filteredSongs[index];
              return SongTile(
                song: song,
                onTap: () => controller.onSongTap(song),
              );
            },
          )),
        ],
      ),
    );
  }
  
  Widget _buildRecentSongCard(BuildContext context, Song song) {
    return GestureDetector(
      onTap: () => controller.onSongTap(song),
      child: Container(
        width: 140,
        margin: EdgeInsets.only(right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                song.coverUrl,
                width: 140,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Text(
              song.title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              song.artist,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
