import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/add_playlist_popup/add_playlist_popup.dart';
import 'package:get/get.dart';

class AddNewPlaylist extends StatelessWidget {
  const AddNewPlaylist({super.key});

  

  @override
  Widget build(BuildContext context) {
    bool isMobile
        = MediaQuery.of(context).size.width < 600; // Adjust the breakpoint as needed
    return GestureDetector(
      onTap: () => showAddPlaylistPopup(context),
      child: SizedBox(
        width: isMobile ? 140 : 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: isMobile ? 140 : 200,
                height: isMobile ? 140 : 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.purple.shade300,
                      Colors.blue.shade300,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.add_circle_outline,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            
              Text(
                'add_new_playlist'.tr,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            
          ],
        ),
      ),
    );
  }
}
