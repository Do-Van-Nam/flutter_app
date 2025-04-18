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
      content: 
      MusicPlaylistScreen(),
      );
  }
}
