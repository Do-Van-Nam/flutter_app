import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'dart:math';
import 'package:flutter_app/ui/widgets/music_table.dart';
import 'package:flutter_app/ui/widgets/music_playlist.dart';

class ExploreRankingScreen extends StatelessWidget {
  const ExploreRankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      content: Container(
        height: double.infinity,
        color: Color(0xFFF5F5F5),
        child: 
        ListView(
          padding: const EdgeInsets.all(16),
          // child: 
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,

            children: [
            //   Expanded(child: 
            //   ),

            // Charts Section
            Text(
                "Bảng xếp hạng",
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
            buildChartsSection(context),
            
            const SizedBox(height: 24), 
              // MusicPlaylistWidget(),
            // Expanded(
            //   child: 
            //   // MusicTableScreen(),
            // ), 
            // MusicPlaylistScreen(),
            // MusicPlaylistWidget(),
            SizedBox(
  height:  MediaQuery.of(context).size.height * 0.6,
  child: MusicPlaylistWidget(),
),
            ]
            
            // ),
      ),
    ),
    );
  }
}
