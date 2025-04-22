import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Screen',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                        'https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-arSQPQZZ8AFG1N48ApRByBX2EzQPD1.png'),
                  ),
                  const SizedBox(width: 16),
                  // Profile Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Kim Tae-hyung',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '100k quan tâm',
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
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Phát nhạc'),
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.person_add_outlined),
                              label: const Text('Quan tâm'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.black,
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
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
                        image: NetworkImage('https://hebbkx1anhila5yf.public.blob.vercel-storage.com/image-bjbBMiJau0mAmg4ubLQ73GFNDgL3IS.png'),
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
                          const Text(
                            'Thông tin',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow('Tên thật', 'Benzen'),
                          _buildInfoRow('Ngày sinh', '2 tháng 5, 1988'),
                          _buildInfoRow('Quốc gia', 'Hoa Kỳ'),
                          _buildInfoRow('Thể loại', 'Pop, Salad, Gái cưới'),
                          const SizedBox(height: 12),
                          const Text(
                            'Cuộc sống của anh trước khi gặp em là một đường thẳng sau khi gặp em rồi thì nó thành Đường Tăng: không bịa, không rượu, không thuốc lá và đặc biệt không gặp lưu kết bạn với tất cả các sinh vật mang giới tính nữ hay đi tùng.',
                            style: TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Xem thêm',
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
    );
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
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}








// Container(
//               height: 40,
//               margin: const EdgeInsets.only(bottom: 16),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   //  Ô tìm kiếm
//                   // Expanded(
//                   //   child:
//                   // Container(
//                   //   width: 600,
//                   //   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   //   decoration: BoxDecoration(
//                   //     color: const Color(0xFFF5F5F5),
//                   //     borderRadius: BorderRadius.circular(8),
//                   //     border: Border.all(color: const Color(0xFFE0E0E0)),
//                   //   ),
//                   //   child: Row(
//                   //     children: const [
//                   //       Icon(Icons.search, color: Color(0xFF9E9E9E)),
//                   //       SizedBox(width: 8),
//                   //       Expanded(
//                   //         child: TextField(
//                   //           textAlignVertical: TextAlignVertical.center,
//                   //           decoration: InputDecoration(
//                   //             hintText: 'Search (Ctrl+/)',
//                   //             hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
//                   //             border: InputBorder.none,
//                   //             isDense: true, // Giúp thu gọn TextField
//                   //             contentPadding: EdgeInsets.symmetric(
//                   //               vertical: 10,
//                   //             ), // Căn giữa dọc
//                   //           ),
//                   //         ),
//                   //       ),
//                   //     ],
//                   //   ),
//                   // ),
//                   SearchBox(),
//                   // ),
//                   const SizedBox(width: 16),

//                   //  Các icon bên phải
//                   Row(
//                     children: [
//                       PopupMenuButton(
//                         icon: const Icon(
//                           Icons.language,
//                           color: Color(0xFF9E9E9E),
//                         ),
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         offset: const Offset(0, 40),
//                         itemBuilder:
//                             (context) => [
//                               PopupMenuItem(
//                                 value: 'en',
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Image.asset(
//                                           'assets/images/en.png',
//                                           width: 24,
//                                           height: 16,
//                                         ),
//                                         const SizedBox(width: 8),
//                                         const Text(
//                                           'English',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       width: 20,
//                                       height: 20,
//                                       margin: const EdgeInsets.only(left: 40),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         color: Colors.red,
//                                         border: Border.all(
//                                           color: Colors.red,
//                                           width: 2,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'vi',
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Image.asset(
//                                           'assets/images/vn.png',
//                                           width: 24,
//                                           height: 16,
//                                         ),
//                                         const SizedBox(width: 8),
//                                         const Text(
//                                           'Việt Nam',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       width: 20,
//                                       height: 20,
//                                       margin: const EdgeInsets.only(left: 40),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                           color: Colors.grey,
//                                           width: 2,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'la',
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Image.asset(
//                                           'assets/images/la.png',
//                                           width: 24,
//                                           height: 16,
//                                         ),
//                                         const SizedBox(width: 8),
//                                         const Text(
//                                           'Lào',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                     Container(
//                                       width: 20,
//                                       height: 20,
//                                       margin: const EdgeInsets.only(left: 40),
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                           color: Colors.grey,
//                                           width: 2,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                         onSelected: (value) {
//                           // Handle language selection
//                         },
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.notifications_none,
//                           color: Color(0xFF9E9E9E),
//                         ),
//                         onPressed: () {},
//                       ),
//                       PopupMenuButton(
//                         icon: const Icon(
//                           Icons.settings,
//                           color: Color(0xFF9E9E9E),
//                         ),
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         offset: const Offset(0, 40),
//                         itemBuilder:
//                             (context) => [
//                               PopupMenuItem(
//                                 value: 'terms',
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.description,
//                                           size: 20,
//                                           color: Colors.black,
//                                         ),
//                                         SizedBox(width: 8),
//                                         Text(
//                                           'Điều khoản dịch vụ',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                     Icon(
//                                       Icons.chevron_right,
//                                       size: 20,
//                                       color: Colors.black,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'privacy',
//                                 child: Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: const [
//                                     Row(
//                                       children: [
//                                         Icon(
//                                           Icons.security,
//                                           size: 20,
//                                           color: Colors.black,
//                                         ),
//                                         SizedBox(width: 8),
//                                         Text(
//                                           'Chính sách bảo mật',
//                                           style: TextStyle(color: Colors.black),
//                                         ),
//                                       ],
//                                     ),
//                                     Icon(
//                                       Icons.chevron_right,
//                                       size: 20,
//                                       color: Colors.black,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'language',
//                                 child: Row(
//                                   children: const [
//                                     Icon(
//                                       Icons.language,
//                                       size: 20,
//                                       color: Colors.black,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Thay đổi ngôn ngữ',
//                                       style: TextStyle(color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               PopupMenuItem(
//                                 value: 'logout',
//                                 child: Row(
//                                   children: const [
//                                     Icon(
//                                       Icons.logout,
//                                       size: 20,
//                                       color: Colors.red,
//                                     ),
//                                     SizedBox(width: 8),
//                                     Text(
//                                       'Đăng xuất',
//                                       style: TextStyle(color: Colors.red),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                         onSelected: (value) {
//                           // Handle menu item selection
//                         },
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),