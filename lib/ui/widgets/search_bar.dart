import 'package:flutter/material.dart';

import 'search_box.dart';

Widget buildSearchBar() {
  return Container(
    height: 40,
    margin: const EdgeInsets.only(bottom: 16),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchBox(),
        // ),
        const SizedBox(width: 16),

        //  Các icon bên phải
        Row(
          children: [
            PopupMenuButton(
              icon: const Icon(Icons.language, color: Color(0xFF9E9E9E)),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 40),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'en',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/en.png',
                                width: 24,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'English',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(left: 40),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                              border: Border.all(color: Colors.red, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'vi',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/vn.png',
                                width: 24,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Việt Nam',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(left: 40),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'la',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/la.png',
                                width: 24,
                                height: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Lào',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Container(
                            width: 20,
                            height: 20,
                            margin: const EdgeInsets.only(left: 40),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey, width: 2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                // Handle language selection
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.notifications_none,
                color: Color(0xFF9E9E9E),
              ),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: const Icon(Icons.settings, color: Color(0xFF9E9E9E)),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 40),
              itemBuilder:
                  (context) => [
                    PopupMenuItem(
                      value: 'terms',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Row(
                            children: [
                              Icon(
                                Icons.description,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Điều khoản dịch vụ',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'privacy',
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Row(
                            children: [
                              Icon(
                                Icons.security,
                                size: 20,
                                color: Colors.black,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Chính sách bảo mật',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'language',
                      child: Row(
                        children: const [
                          Icon(Icons.language, size: 20, color: Colors.black),
                          SizedBox(width: 8),
                          Text(
                            'Thay đổi ngôn ngữ',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'logout',
                      child: Row(
                        children: const [
                          Icon(Icons.logout, size: 20, color: Colors.red),
                          SizedBox(width: 8),
                          Text(
                            'Đăng xuất',
                            style: TextStyle(color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ],
              onSelected: (value) {
                // Handle menu item selection
              },
            ),
          ],
        ),
      ],
    ),
  );
}
