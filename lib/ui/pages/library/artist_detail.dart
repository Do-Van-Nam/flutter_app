import 'package:flutter/material.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:flutter_app/services/artist_service.dart';
import 'package:flutter_app/ui/pages/home/widgets/album_item.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';
import 'package:flutter_app/ui/pages/home/widgets/main_content.dart';
import 'package:flutter_app/ui/widgets/section_header.dart';
import 'dart:math';

import 'package:get/get.dart';

class ArtistDetailScreen extends StatelessWidget {
  const ArtistDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.parameters['slug'];
    final Future<Artist> futureContent = ArtistService().fetchArtistInfo(
      params: {'timestamp': 1714387200, 'artistId': id},
    );
    return FutureBuilder<Artist>(
      future: futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          print(futureContent);
          print(snapshot.error);
          return const Center(child: Text('Error loading content'));
        } else if (snapshot.hasData) {
          final artist = snapshot.data!;
          return MainLayout(
            content: Container(
              color: Color(0xFFF5F5F5),
              height: double.infinity,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    // Profile Header Section
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      color: const Color(0xFFF0F2F5),
                      child: Row(
                        children: [
                          // Profile Image
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: NetworkImage(
                              artist.avatar ??
                                  'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-bjbBMiJau0mAmg4ubLQ73GFNDgL3IS.png',
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Profile Info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  artist.realName ?? 'Kim Tae-hyung',
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'artist_followers'.tr,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 12),
                                // Action Buttons
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                      child: Text('artist_play_music'.tr),
                                    ),
                                    const SizedBox(width: 8),
                                    OutlinedButton.icon(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.person_add_outlined,
                                      ),
                                      label: Text('artist_follow'.tr),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.black,
                                        side: const BorderSide(
                                          color: Colors.grey,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.share_outlined),
                                      color: Colors.black54,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    SectionHeader(
                      title: 'recommend_for_you'.tr,
                      onSeeAllPressed: () {
                        Get.toNamed(Routes.RECOMMEND_SONG);
                      },
                    ),
                    const SizedBox(height: 16),
                    buildRecommendationsList(),
                    const SizedBox(height: 24),

                    // New Music Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'featured_album'.tr,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildNewMusicSection(),
                    const SizedBox(height: 24),

                    // New Music Section
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'appears_in'.tr,
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
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
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildNewMusicSection(),
                    const SizedBox(height: 24),
                    // Profile Details Section
                    Container(
                      color: Colors.white,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Profile Image
                          Container(
                            width: 220,
                            height: 220,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  artist.avatar ??
                                      'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-bjbBMiJau0mAmg4ubLQ73GFNDgL3IS.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // Profile Details
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Text(
                                    'information'.tr,
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  _buildInfoRow(
                                    'real_name'.tr,
                                    artist.realName ?? 'Kim Tae-hyung',
                                  ),
                                  _buildInfoRow(
                                    'birthday'.tr,
                                    artist.birthday ?? '30/12/1995',
                                  ),
                                  _buildInfoRow(
                                    'country'.tr,
                                    artist.countryName ?? 'Hoa Kỳ',
                                  ),
                                  _buildInfoRow(
                                    'genre'.tr,
                                    'Pop, Salad, Gỏi cuốn',
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'description'.tr,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const SizedBox(height: 12),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      'see_more'.tr,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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

Widget _buildInfoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 70,
          child: Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    ),
  );
}
