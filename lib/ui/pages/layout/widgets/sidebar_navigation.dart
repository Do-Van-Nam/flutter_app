import 'package:flutter/material.dart';
import 'package:flutter_app/AppState.dart';
import 'package:flutter_app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class SidebarNavigation extends StatefulWidget {
  const SidebarNavigation({super.key});

  @override
  State<SidebarNavigation> createState() => _SidebarNavigationState();
}

class _SidebarNavigationState extends State<SidebarNavigation> {
  late AppState appState;
  
  @override
  void initState() {
    super.initState();
    appState = Provider.of<AppState>(context, listen: false);
    var selectedIndex = appState.selectedIndex;
  }
  bool isExpanded = true;
final List<String> routeNames = [
  Routes.HOME,
  Routes.EXPLORE,
  Routes.LIBRARY,
    Routes.HOME,
  Routes.HOME,

];

  int get selectedIndex => appState.selectedIndex;

  void _toggleSidebar() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void _onNavItemTapped(int index) {
    setState(() {
      appState.selectedIndex = index; // Update the selected index
    });
    // Chuyển đến trang tương ứng
  Get.toNamed(routeNames[index]);

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? 200 : 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none, //
        children: [
          Column(
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFA70C1D), Color(0xFF0153B4)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.cover,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    if (isExpanded) ...[
                      const SizedBox(width: 4),
                      Image.asset(
                        'assets/images/app_name.png',
                        width: 100,
                        height: 40,
                      ),
                    ],
                  ],
                ),
              ),

              // Menu Items
              _buildNavItem(Icons.home, 'Trang chủ', 0),
              _buildNavItem(Icons.explore, 'Khám phá', 1),
              _buildNavItem(Icons.library_books, 'Thư viện', 2),
              _buildNavItem(Icons.music_note, 'Đoạn nhạc', 3),
              _buildNavItem(Icons.upgrade, 'Nâng cấp', 4),

              const SizedBox(height: 16),

              // Create Playlist Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFDD6F7A),
                        Color(0xFF6FA0D6)
                      ], // Even lighter shades
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: isExpanded
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB71C1C), // A lighter shade of red
                              Color(0xFF1976D2) // A lighter shade of blue
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          // color: const Color(0xFFE91E63).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.playlist_add,
                          color: Color(0xFFE91E63),
                          size: 16,
                        ),
                      ),
                      if (isExpanded) ...[
                        const SizedBox(width: 8),
                        const Text(
                          'Tạo playlist',
                          style: TextStyle(
                            color: Color(0xFF333333),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Toggle Button
    //       Positioned(
    //         top: 16,
    //         right: -16 ,
    //         child: Material(
    //           elevation: 6, // tăng z-index
    // shape: const CircleBorder(),
    // color: Colors.transparent,
    //           child: GestureDetector(
    //             onTap: _toggleSidebar,
    //             child: Container(
    //               width: 32,
    //               height: 32,
    //               decoration: BoxDecoration(
    //                 color: const Color(0xFFE53935),
    //                 borderRadius: BorderRadius.circular(16),
    //               ),
    //               child: Icon(
    //                 isExpanded ? Icons.arrow_back : Icons.arrow_forward,
    //                 color: Colors.white,
    //                 size: 18,
    //               ),
    //             ),
    //           ),
    //         ),
    //       ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, int index) {
    bool isSelected =
        selectedIndex == index; // Determine if the item is selected
    return GestureDetector(
      onTap: () =>
          _onNavItemTapped(index), // Handle tap to update selected index
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(
                  colors: [Color(0xFFA70C1D), Color(0xFF0153B4)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : const Color(0xFF757575),
                size: 20,
              ),
              if (isExpanded) ...[
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color:
                            isSelected ? Colors.white : const Color(0xFF333333),
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
