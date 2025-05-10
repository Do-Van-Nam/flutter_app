import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_app/models/banner_item.dart';
import 'package:flutter_app/services/banner_service.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  _BannerSliderState createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  late Future<List<BannerItem>> _futureContent;
  int currentIndex = 0;
  bool language = true; // true for English, false for Tetun
  @override
  void initState() {
    super.initState();
    _futureContent = BannerService().fetchBannerContent();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BannerItem>>(
      future: _futureContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading banner'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF001F3F), Color(0xFF0074D9)],
              ),
              image: DecorationImage(
                image: NetworkImage(snapshot.data![currentIndex].file),
                fit: BoxFit.cover,
              ),
            ),

            child: Stack(
              children: [
                Positioned(
                  right: 16,
                  top: 125,
                  // bottom: 0,
                  child: GestureDetector(
                    onTap:
                        () => setState(() {
                          if (currentIndex < snapshot.data!.length - 1) {
                            currentIndex++;
                          } else {
                            currentIndex = 0;
                          }
                        }),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  left: 16,
                  top: 125,
                  // bottom: 0,
                  child: GestureDetector(
                    onTap:
                        () => setState(() {
                          if (currentIndex > 0) {
                            currentIndex--;
                          } else {
                            currentIndex = snapshot.data!.length - 1;
                          }
                        }),
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('No banners available'));
        }
      },
    );
  }
}
