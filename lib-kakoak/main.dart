import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'landing_content_model.dart';
import 'api_service.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kakoak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green, fontFamily: 'Poppins'),
      home: const KakoakHomePage(),
    );
  }
}

class KakoakHomePage extends StatefulWidget {
  const KakoakHomePage({super.key});

  @override
  State<KakoakHomePage> createState() => _KakoakHomePageState();
  // @override
  // Widget build(BuildContext context) {
  // return Scaffold(
  //   body: Stack(
  //     // children: [
  //     //   Padding(
  //     // padding: const EdgeInsets.only(top: 100),
  //     children: [
  //       SingleChildScrollView(
  //         child: Column(
  //           children: [
  //             // NavBar(),
  //             HeroSection(),
  //             DownloadSection(),
  //             AppFeaturesSection(),
  //             SecuritySection(),
  //             Footer(),
  //           ],
  //         ),
  //       ),
  //       // ),
  //       const Positioned(top: 20, left: 0, right: 0, child: NavBar()),
  //     ],
  //   ),
  // );
  // }
}

class _KakoakHomePageState extends State<KakoakHomePage> {
  late Future<List<LandingContentItem>> _futureContent;

  bool language = true; // true for English, false for Tetun
  @override
  void initState() {
    super.initState();
    _futureContent = ApiService().fetchLandingContent();
  }

  void _changeLanguage() {
    setState(() {
      language = !language;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<LandingContentItem>>(
        future: _futureContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Lỗi: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có dữ liệu'));
          }

          final items = snapshot.data!;
        
          final headerMenuItems = items.where((item) => item.key == 'header_menu').toList();
          final footerMenuItems = items.where((item) => item.key == 'footer_menu').toList();
          final contentIntro = items.where((item) => item.key == 'content_intro').toList();
         
          logger.i( headerMenuItems.toString());
          final Map<String, LandingContentItem> mapData = {
            for (var item in items) item.key: item,
          };
          return Scaffold(
            body: Stack(
              // children: [
              //   Padding(
              // padding: const EdgeInsets.only(top: 100),
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // NavBar(),
                      HeroSection(data: mapData, language: language),
                      DownloadSection(data: mapData, language: language),
                      AppFeaturesSection(data: mapData, language: language,content:contentIntro[0]),
                      SecuritySection(data: mapData, language: language,content:contentIntro[1]),
                      Footer(data: mapData, language: language,footerMenuItems: footerMenuItems),
                    ],
                  ),
                ),
                // ),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: NavBar(
                    data: mapData,
                    setLanguage: _changeLanguage,
                    language: language,
                    headerMenuItems: headerMenuItems,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class NavBar extends StatelessWidget {
  final Map<String, LandingContentItem> data;
final List<LandingContentItem> headerMenuItems;
  final Function setLanguage;
  bool language;
  NavBar({
    Key? key,
    required this.data,
    required this.setLanguage,
    required this.language,
    required this.headerMenuItems,
  }) : super(key: key);
  // print(data);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;



    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo + tên
          Row(
            children: [
               Image.network(data['logo']?.image ?? '', height: 40,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
               ),

              const SizedBox(width: 8),

            ],
          ),

          // Menu (theo responsive)
          isMobile
              ? Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.download),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.menu),
                    itemBuilder:
                        (BuildContext context) => [
                          ...headerMenuItems.map(
    (entry) => PopupMenuItem(
      value: entry.key,
      child: Text(
        language
            ? entry.title ?? ''
            : entry.titleTetun ?? '',
      ),
    ),
  ),
                          
                        ],
                    onSelected: (value) {
                      // TODO: handle menu selection
                    },
                  ),
                ],
              )
              : Row(
                children: [
                  ...headerMenuItems.map(
    (entry) => _navItem(
      
        language
            ? entry.title ?? ''
            : entry.titleTetun ?? '',
      
    ),
  ),
                  
                  _navItem('What Our Client Say\'s'),
                ],
              ),

          // Nút EN
          if (!isMobile)
            GestureDetector(
              onTap: () => setLanguage(),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(20),
                ),
                child:  Text(
                   language ? 'EN':"TT",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}


class HeroSection extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  final bool language;
  const HeroSection({Key? key, required this.data, this.language = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: const EdgeInsets.only(top: 120, left: 40, right: 20, bottom: 40),
      
      decoration:  BoxDecoration(
        image: DecorationImage(
      image: NetworkImage(data['header_background']?.image ?? '',
  //  filterQuality: FilterQuality.high, // chất lượng lọc cao
  // isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
      
      ),
      fit: BoxFit.cover, // để ảnh phủ toàn bộ container
    ),
      ),
      child: Column(
        children: [
          if (!isMobile)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          children: [
                            const TextSpan(
                              text: 'KAKOAK – CARE MORE: ',
                              style: TextStyle(color: Color(0xFFFFF012)),
                            ),
                            TextSpan(
                              text:
                                  language
                                      ? (data['header_content']?.title
                                                  ?.contains(':') ??
                                              false
                                          ? data['header_content']!.title
                                              ?.split(':')
                                              .sublist(1)
                                              .join(':')
                                              .trim()
                                          : data['header_content']?.titleTetun
                                                  ?.split(':')
                                                  .sublist(1)
                                                  .join(':')
                                                  .trim() ??
                                              '')
                                      : data['header_content']?.titleTetun
                                                  ?.split(':')
                                                  .sublist(1)
                                                  .join(':')
                                                  .trim() ??
                                              '',

                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        language
                            ? data['header_content']?.content ?? ''
                            : data['header_content']?.contentTetun ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child:  Text(
                          language
                            ? data['header_note']?.title ?? ''
                            : data['header_note']?.titleTetun ?? '',
                          style: TextStyle(
                            color: Color(0xFFFFF012),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Image.network(
                    data['header_content']?.image??'',
                    fit: BoxFit.contain,
  filterQuality: FilterQuality.high, 
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)

                  ),
                ),
              ],
            ),
          if (isMobile)
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(
                            text: 'KAKOAK – CARE MORE: ',
                            style: TextStyle(color: Color(0xFFFFF012)),
                          ),
                          TextSpan(
                            text: 'BUAT HOTU IHA APLIKASAUN IDA',
                            style: TextStyle(color: Color(0xFFFFF012)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'KAKOAK – CARE MORE: Bonus 15% banihira sosa pakote internet husi Aplikasaun Kakoak',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Data charges may apply. Contact your provider for details.',
                        style: TextStyle(
                          color: Color(0xFFFFF012),
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Image.asset('assets/images/phones.png', fit: BoxFit.contain,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class DownloadSection extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  final bool language;
  const DownloadSection({Key? key, required this.data, required this.language})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
      child:
          isMobile
              ? Column(
                children: [
                  _buildDownloadCard(
                    language
                            ? data['qr_google_play']?.title ?? ''
                            : data['qr_google_play']?.titleTetun ?? '',
                    data['qr_google_play']?.image ?? "",
                    'assets/images/google_play.png',
                    data['img_qr_google_play']?.image ?? "",
                    'GET IT ON',
                    'Google Play',
                  ),
                  const SizedBox(height: 20),
                  _buildDownloadCard(
                    language
                            ? data['qr_app_store']?.title ?? ''
                            : data['qr_app_store']?.titleTetun ?? '',
                    data['qr_app_store']?.image ?? "",
                    'assets/images/app_store.png',
                     data['img_qr_app_store']?.image ?? "",
                    'Download on the',
                    'App Store',
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child:  _buildDownloadCard(
                    language
                            ? data['qr_google_play']?.title ?? ''
                            : data['qr_google_play']?.titleTetun ?? '',
                    data['qr_google_play']?.image ?? "",
                    'assets/images/google_play.png',
                    data['img_qr_google_play']?.image ?? "",
                    'GET IT ON',
                    'Google Play',
                  ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildDownloadCard(
                    language
                            ? data['qr_app_store']?.title ?? ''
                            : data['qr_app_store']?.titleTetun ?? '',
                    data['qr_app_store']?.image ?? "",
                    'assets/images/app_store.png',
                     data['img_qr_app_store']?.image ?? "",
                    'Download on the',
                    'App Store',
                  ),
                  ),
                ],
              ),
    );
  }

  Widget _buildDownloadCard(
    String title,
    String qrImage,
    String storeImage,
    String personImage,
    String status,
    String os,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: os == 'Google Play' ? Color(0xFFFFEEE6) : Color(0xFFE9E9EF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),
                Image.network(qrImage, height: 120,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                ),
                const SizedBox(height: 20),
                InkWell(
                  // onTap: onPressed,
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color:
                          os == 'Google Play'
                              ? Colors.green
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(storeImage, height: 30,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              status,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              os,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: 
              Image.network(
  personImage,
  fit: BoxFit.contain,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
)
              // Image.network(personImage, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}

class AppFeaturesSection extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  final bool language;
  final LandingContentItem content;
  const AppFeaturesSection({
    Key? key,
    required this.data,
    required this.language,
    required this.content,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 10 : 160,
        vertical: 60,
      ),
      child: Column(
        children: [
          isMobile
              ? Column(
                children: [
                  _buildFeatureText(),
                  const SizedBox(height: 30),
                  Image.network(content?.image ?? ' ', height: 400,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                  ),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child:                   Image.network(content?.image ?? ' ', height: 400,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                    
                    ),

                  ),
                  Expanded(flex: 7, child: _buildFeatureText()),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildFeatureIcons() {
    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green.withOpacity(0.3),
                width: 2,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Positioned(
            top: 0,
            child: _buildIconCircle(Icons.document_scanner, 'Share'),
          ),
          Positioned(
            bottom: 0,
            left: 30,
            child: _buildIconCircle(Icons.videocam, 'Video'),
          ),
          Positioned(
            bottom: 0,
            right: 30,
            child: _buildIconCircle(Icons.phone_android, 'Mobile'),
          ),
        ],
      ),
    );
  }

  Widget _buildIconCircle(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }

  Widget _buildFeatureText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:  [
        Text(
          language ? content?.title ?? '' : 
          
          content?.titleTetun ?? '',

          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D1E5F),
          ),
        ),
        const SizedBox(height: 40),

        Text(
          language ? content?.content ?? '' : 
          
          content?.contentTetun ?? '',
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
        // SizedBox(height: 20),
        // Text(
        //   'Aplikasaun Kakoak mós bele ajuda negosiadór média no grande fornese suporta kliente no entrega notifikasaun importante hotu ba klientes.',
        //   style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        // ),
      ],
    );
  }
}

class SecuritySection extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  final bool language;
  final LandingContentItem content;

  const SecuritySection({Key? key, required this.data, required this.language,required this.content})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      color: const Color(0xFFFFF5F0),
      child: Column(
        children: [
          isMobile
              ? Column(
                children: [
                  _buildSecurityText(),
                  const SizedBox(height: 30),
                  _buildSecurityImage(),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 140),
                      child: _buildSecurityText(),
                    ),
                  ),

                  Expanded(flex: 6, child: _buildSecurityImage()),
                ],
              ),
        ],
      ),
    );
  }

  Widget _buildSecurityText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          language ? content?.title ?? '' : 
          
          content?.titleTetun ?? '',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D1E5F),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          language ? content?.content ?? '' : 
          
          content?.contentTetun ?? '',style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSecurityImage() {
    return Image.network(content.image??'', height: 400,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
    
    );
  }
}

class Footer extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  final bool language;
  final List<LandingContentItem> footerMenuItems;
  const Footer({Key? key, required this.data, required this.language, required this.footerMenuItems})
    : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          color: Colors.black,
          child: Column(
            children: [
              if (isMobile) ...[
                _buildKakoakLogo(),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildKakoakCareMoreText(),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: _buildDownloadAppText(),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        // onTap: onPressed,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/google_play.png',
                                height: 30,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)

                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'GET IT ON',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'Google Play',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        // onTap: onPressed,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/app_store.png',
                                height: 30,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)

                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Download on the',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Text(
                                    'App Store',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                _buildFooterLinks(),
                const SizedBox(height: 15),
                _buildCopyRightText(),
              ] else ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildKakoakLogo(),
                        const SizedBox(height: 10),
                        _buildKakoakCareMoreText(),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildDownloadAppText(),
                        const SizedBox(height: 10),
                        _buildDownloadButtons(),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [_buildCopyRightText(), _buildFooterLinks()],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKakoakLogo() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(8),
          ),
          child:                Image.network(data['logo']?.image ?? '', height: 40,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
          
          ),

        ),
        const SizedBox(width: 8),
        
      ],
    );
  }

  Widget _buildKakoakCareMoreText() {
    return const Text(
      'KAKOAK – CARE MORE',
      style: TextStyle(color: Colors.white, fontSize: 14),
    );
  }

  Widget _buildDownloadAppText() {
    return const Text(
      'Download App now',
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white, fontSize: 14),
    );
  }

  Widget _buildDownloadButtons() {
    return Row(
      children: [
        InkWell(
          // onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/google_play.png', height: 30,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'GET IT ON',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'Google Play',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 10),
        InkWell(
          // onTap: onPressed,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/app_store.png', height: 30,
  filterQuality: FilterQuality.high, // chất lượng lọc cao
  isAntiAlias: true, // giúp làm mịn cạnh ảnh (nếu ảnh vector hoặc có bo góc)
                
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Download on the',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      'App Store',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final entry in footerMenuItems) ...[
      _footerLink(
        language
            ? entry.title ?? ''
            : entry.titleTetun ?? '',
      ),
      const SizedBox(width: 15),],

        
        _footerLink('Cookies'),
      ],
    );
  }

  Widget _buildCopyRightText() {
    // final language;
    return  Text(
      language ? data['footer_copyright']?.title ?? '' : data['footer_copyright']?.titleTetun ?? '',
      style: TextStyle(color: Colors.white, fontSize: 12),
    );
  }

  Widget _footerLink(String text) {
    return Text(
      
      text,
      style: const TextStyle(color: Colors.white, fontSize: 12),
    );
  }
}
