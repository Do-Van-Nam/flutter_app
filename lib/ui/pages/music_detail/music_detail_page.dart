import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app/ui/pages/music_detail/music_detail_controller.dart';

class MusicDetailPage extends GetView<MusicDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.song.value.title)),
        elevation: 0,
      ),
      body: Obx(() => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : _buildContent(context)
      ),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    final song = controller.song.value;
    
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Album art
                Hero(
                  tag: 'song-cover-${song.id}',
                  child: Container(
                    width: 280,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        song.coverUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32),
                
                // Song info
                Text(
                  song.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  song.artist,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                
                // Song details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildDetailItem(context, 'music_album'.tr, song.album),
                    _buildDetailItem(context, 'music_duration'.tr, _formatDuration(song.duration)),
                  ],
                ),
              ],
            ),
          ),
        ),
        
        // Player controls
        Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            children: [
              // Progress bar
              Obx(() => Slider(
                value: controller.progress.value,
                max: controller.duration.value,
                onChanged: (value) {
                  controller.seekTo(Duration(milliseconds: value.toInt()));
                },
                activeColor: Theme.of(context).primaryColor,
              )),
              
              // Time indicators
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => Text(
                      _formatDuration(Duration(milliseconds: controller.progress.value.toInt())),
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                    Obx(() => Text(
                      _formatDuration(Duration(milliseconds: controller.duration.value.toInt())),
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              
              // Control buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.skip_previous, size: 32),
                    onPressed: () {}, // Not implemented in this demo
                  ),
                  Obx(() => IconButton(
                    icon: Icon(
                      controller.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_filled,
                      size: 64,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: controller.togglePlayPause,
                  )),
                  IconButton(
                    icon: Icon(Icons.skip_next, size: 32),
                    onPressed: () {}, // Not implemented in this demo
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
  
  Widget _buildDetailItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).textTheme.bodyLarge?.color?.withOpacity(0.5),
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
  
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
