import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAllPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onSeeAllPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
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
                const SizedBox(width: 8),

        Row(
          children: [
            
          
            TextButton(
              onPressed: onSeeAllPressed,
              child:  Text(
                'Xem tất cả',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Color(0xFFE53935),
                  fontWeight: FontWeight.w500,
                ),
                // style: TextStyle(
                //   color: Color(0xFFE53935),
                //   fontWeight: FontWeight.w500,
                // ),
              ),
            ),
                const SizedBox(width: 8),
            Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 12,
                  ),
                ),
          ],
        ),
        ],
    );
  }
}




// Positioned(
          //   left: 16,
          //   bottom: 16,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Container(
          //         width: 24,
          //         height: 24,
          //         decoration: BoxDecoration(
          //           color: Colors.white.withOpacity(0.3),
          //           shape: BoxShape.circle,
          //         ),
          //         child: const Icon(
          //           Icons.arrow_back_ios,
          //           color: Colors.white,
          //           size: 12,
          //         ),
          //       ),
          //       const SizedBox(width: 8),
          //       Container(
          //         width: 24,
          //         height: 24,
          //         decoration: BoxDecoration(
          //           color: Colors.white.withOpacity(0.3),
          //           shape: BoxShape.circle,
          //         ),
          //         child: const Icon(
          //           Icons.arrow_forward_ios,
          //           color: Colors.white,
          //           size: 12,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),