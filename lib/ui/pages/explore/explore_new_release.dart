import 'package:flutter/material.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/ui/pages/home/widgets/category_chip.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/music_playlist.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:flutter_app/ui/pages/explore/explore_screen.dart';

import 'package:get/state_manager.dart';

class ExploreNewReleaseScreen extends StatelessWidget {
  const ExploreNewReleaseScreen({super.key});

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
                'explore_new_release'.tr,
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
              // Category Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const [
                    CategoryChip(label: 'R&B', isSelected: true),
                    CategoryChip(label: 'LAMVONG', isSelected: false),
                    CategoryChip(label: 'DRIVING', isSelected: false),
                    CategoryChip(label: 'COFFE', isSelected: false),
                    CategoryChip(label: 'SPORT', isSelected: false),
                    CategoryChip(label: 'TẾT', isSelected: false),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: MusicPlaylistWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
