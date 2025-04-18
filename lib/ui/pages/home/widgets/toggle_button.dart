import 'package:flutter/material.dart';

class ToggleButton extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onTap;

  const ToggleButton({
    super.key,
    required this.isExpanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: -16,
      child: Material(
        elevation: 6,
        shape: const CircleBorder(),
        color: Colors.transparent,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFFE53935),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              isExpanded ? Icons.arrow_back : Icons.arrow_forward,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
