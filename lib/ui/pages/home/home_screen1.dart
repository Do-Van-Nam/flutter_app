import 'package:flutter/material.dart';
import 'widgets/sidebar_navigation.dart';
import 'widgets/main_content.dart';
import 'widgets/right_sidebar.dart';
import 'widgets/player_controls.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 1200;
    final bool isMediumScreen = screenWidth > 800 && screenWidth <= 1200;

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Sidebar
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const SidebarNavigation(),
                  ],
                ),

                // Main Content Area
                Expanded(
                  flex: isWideScreen ? 3 : 2,
                  child: const MainContent(),
                ),

                // Right Sidebar (only visible on wide screens)
                if (isWideScreen || isMediumScreen)
                  SizedBox(
                    width: isWideScreen ? 300 : 250,
                    child: const RightSidebar(),
                  ),
              ],
            ),
          ),

          // Bottom Player Controls
          const PlayerControls(),
        ],
      ),
    );
  }
}
