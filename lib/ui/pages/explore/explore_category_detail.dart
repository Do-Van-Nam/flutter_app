import 'package:flutter/material.dart';
import 'package:flutter_app/ui/pages/home/widgets/album_item.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'dart:math';

import 'package:get/get.dart';

class ExploreCategoryDetailScreen extends StatelessWidget {
  const ExploreCategoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final category = Get.parameters['slug'];
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
                category == null
                    ? ""
                    : "$category",
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
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 16,
  runSpacing: 16,
        children: [
          for (int i = 1; i <= 24; i++)

            SizedBox(
              
              child: AlbumItem(
                imageIndex: i >15 ? i - 15 : i,
                title: 'Như Chưa Bao Giờ',
                artistName: 'Channon',
              ),
            ),
        ],
      ),
              const SizedBox(height: 24),

              
            ],
          ),
        ),
      ),
    );
  }
}

