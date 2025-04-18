import 'package:flutter/material.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(
            color: Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Song Info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.asset(
                    'assets/images/Rectangle 6166-1.png',
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Như Chưa Bao Giờ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Hồ Quang Hiếu • 10 Tr lượt xem',
                      style: TextStyle(
                        color: Color(0xFF757575),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Like Button
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Color(0xFFE53935),
            ),
            onPressed: () {},
          ),
          
          // More Button
          IconButton(
            icon: const Icon(
              Icons.more_horiz,
              color: Color(0xFF757575),
            ),
            onPressed: () {},
          ),
          
          const Spacer(),
          
          // Shuffle Button
          IconButton(
            icon: const Icon(
              Icons.shuffle,
              color: Color(0xFF757575),
            ),
            onPressed: () {},
          ),
          
          // Previous Button
          IconButton(
            icon: const Icon(
              Icons.skip_previous,
              color: Color(0xFF212121),
              size: 28,
            ),
            onPressed: () {},
          ),
          
          // Play Button
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFE53935).withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 28,
            ),
          ),
          
          // Next Button
          IconButton(
            icon: const Icon(
              Icons.skip_next,
              color: Color(0xFF212121),
              size: 28,
            ),
            onPressed: () {},
          ),
          
          // Repeat Button
          IconButton(
            icon: const Icon(
              Icons.repeat,
              color: Color(0xFF757575),
            ),
            onPressed: () {},
          ),
          
          const Spacer(),
          
          // Time
          const Text(
            '1:45 / 4:42',
            style: TextStyle(
              color: Color(0xFF757575),
              fontSize: 12,
            ),
          ),
          
          // Volume
          IconButton(
            icon: const Icon(
              Icons.volume_up,
              color: Color(0xFF757575),
            ),
            onPressed: () {},
          ),
          
          // Progress Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: 100,
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 14,
                  ),
                  activeTrackColor: const Color(0xFFE53935),
                  inactiveTrackColor: const Color(0xFFE0E0E0),
                  thumbColor: const Color(0xFFE53935),
                  overlayColor: const Color(0xFFE53935).withOpacity(0.2),
                ),
                child: Slider(
                  value: 0.4,
                  onChanged: (value) {},
                ),
              ),
            ),
          ),
          
          // Expand Button
          IconButton(
            icon: const Icon(
              Icons.keyboard_arrow_up,
              color: Color(0xFF757575),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
