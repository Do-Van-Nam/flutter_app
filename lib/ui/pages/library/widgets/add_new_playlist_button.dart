import 'package:flutter/material.dart';
import 'package:flutter_app/ui/widgets/add_playlist_popup/add_playlist_popup.dart';

class AddNewPlaylist extends StatelessWidget {
  const AddNewPlaylist({super.key});

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showAddPlaylistPopup(context),
      child: SizedBox(
        width: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                width: 200,
                height: 200,
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
                "Tạo play list phát mới",
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
