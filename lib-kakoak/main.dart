import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'landing_content_model.dart';
import 'api_service.dart';
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
      theme: ThemeData(primarySwatch: Colors.deepOrange, fontFamily: 'Poppins'),
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
          final Map<String, LandingContentItem> mapData = {
  for (var item in items) item.key: item
};
          return  Scaffold(
      body: Stack(
        // children: [
        //   Padding(
        // padding: const EdgeInsets.only(top: 100),
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                // NavBar(),
                HeroSection(data: mapData),
DownloadSection(data: mapData),
AppFeaturesSection(data: mapData),
SecuritySection(data: mapData),
Footer(data: mapData),
              ],
            ),
          ),
          // ),
          Positioned(top: 20, left: 0, right: 0, child: NavBar(data: mapData, setLanguage: _changeLanguage,language: language,)),
        ],
      ),
    );
        }
      )
        
        
    );
  
  }
}

class NavBar extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  final Function setLanguage;
  bool language;
   NavBar({Key? key, required this.data, required this.setLanguage,required this.language}) : super(key: key);
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
              // Container(
              //   padding: const EdgeInsets.all(8),
              //   decoration: BoxDecoration(
              //     color: Colors.deepOrange,
              //     borderRadius: BorderRadius.circular(8),
              //   ),
                // child: Image.asset('assets/images/white_logo.png', height: 30),
                 Image.network( data['logo']?.image ?? '', height: 40),
              // ),
              const SizedBox(width: 8),
              // const Text(
              //   'Kakoak',
              //   style: TextStyle(
              //     color: Colors.deepOrange,
              //     fontWeight: FontWeight.bold,
              //     fontSize: 20,
              //   ),
              // ),
            ],
          ),

          // Menu (theo responsive)
          isMobile
              ? Row(
                  children: [
                    Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(onPressed: (){},  icon: const Icon(Icons.download),),
              ),
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.menu),
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem(value: 'home', child: Text('Home')),
                        const PopupMenuItem(
                            value: 'apps', child: Text('Kakoak Apps App')),
                        const PopupMenuItem(
                            value: 'security',
                            child: Text('Security by Default')),
                        const PopupMenuItem(
                            value: 'client', child: Text('What Our Client Say\'s')),
                      ],
                      onSelected: (value) {
                        // TODO: handle menu selection
                      },
                    ),
                  ],
                )
              : Row(
                  children: [
                    _navItem('Home'),
                    _navItem('Kakoak Apps App'),
                    _navItem('Security by Default'),
                    _navItem('What Our Client Say\'s'),
                  ],
                ),

          // Nút EN 
          if(!isMobile)
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'EN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
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
  const HeroSection({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: const EdgeInsets.only(top: 120, left: 40, right: 20, bottom: 40),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFF7A00), Color(0xFFFF5500)],
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
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 32,
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
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'KAKOAK – CARE MORE: Bonus 15% banihira sosa pakote internet husi Aplikasaun Kakoak Sosa Pakote internet tipu limitadu liu husi Aplikasaun Kakoak sei simu bonus too 15%. Validu ba laran 7 – FB2, PJ ina DY – Pakote DJ folin \$1 troka ba promosaun \$23 uza ba PUBG, AOV, YouTube, Whatsapp, validu laran 7 – Pakote FB2 folin \$0.5 troka ba promosaun \$23 uza Facebook no Whatsapp validu laran 7 – Pakote PJ folin \$1 troka ba validu laran 7 – Pakote DY folin \$0.5 troka ba promosaun \$23 hodi uza ba asesu YouTube. Validu laron7!',
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
                ),
                Expanded(
                  flex: 5,
                  child: Image.asset(
                    'assets/images/phones.png',
                    fit: BoxFit.contain,
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
                          TextSpan(text: 'KAKOAK – CARE MORE: ',style: TextStyle(color:Color(0xFFFFF012))),
                          TextSpan(
                            text: 'BUAT HOTU IHA APLIKASAUN IDA',
                            style: TextStyle(color:Color(0xFFFFF012)),
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
                        style: TextStyle(color: Color(0xFFFFF012), fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Image.asset(
                  'assets/images/phones.png',
                  fit: BoxFit.contain,
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
  const DownloadSection({Key? key, required this.data}) : super(key: key);
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
                    'Scan QR Code',
                    'assets/images/qr_android.png',
                    'assets/images/google_play.png',
                    'assets/images/woman1.png',
                    'GET IT ON',
                    'Google Play',
                  ),
                  const SizedBox(height: 20),
                  _buildDownloadCard(
                    'Scan QR Code',
                    'assets/images/qr_ios.png',
                    'assets/images/app_store.png',
                    'assets/images/woman2.png',
                    'Download on the',
                    'App Store',
                  ),
                ],
              )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildDownloadCard(
                      'Scan QR Code',
                      'assets/images/qr_android.png',
                      'assets/images/google_play.png',
                      'assets/images/woman1.png',
                      'GET IT ON',
                      'Google Play',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildDownloadCard(
                      'Scan QR Code',
                      'assets/images/qr_ios.png',
                      'assets/images/app_store.png',
                      'assets/images/woman2.png',
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
                Image.asset(qrImage, height: 120),
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
                              ? Colors.deepOrange
                              : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(storeImage, height: 30),
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
              child: Image.asset(personImage, fit: BoxFit.contain),
            ),
          ),
        ],
      ),
    );
  }
}

class AppFeaturesSection extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  const AppFeaturesSection({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 10: 160, vertical: 60),
      child: Column(
        children: [
          isMobile
              ? Column(
                children: [
                  _buildFeatureText(),
                  const SizedBox(height: 30),
                  Image.asset('assets/images/feature.png', height: 400),
                ],
              )
              : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: Image.asset(
                      'assets/images/feature.png',
                      height: 400,
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
                color: Colors.deepOrange.withOpacity(0.3),
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
        color: Colors.deepOrange,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }

  Widget _buildFeatureText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Kakoak Apps App',

          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D1E5F),
          ),
        ),
        const SizedBox(height: 40),

        Text(
          'Kakoak Apps nudar aplikasaun ida download gratis no kria ho negoisu klik ida ina hanoin. Kria catalogo ida nudar plataforma ba ita nia produtu no servisu sira. Konekta ho ita nia kliente sira ho fasil utiliza operatur automatiku, responde pergunta fasil no lais ba klientes.',
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
        SizedBox(height: 20),
        Text(
          'Aplikasaun Kakoak mós bele ajuda negosiadór média no grande fornese suporta kliente no entrega notifikasaun importante hotu ba klientes.',
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }
}

class SecuritySection extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  const SecuritySection({Key? key, required this.data}) : super(key: key);
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
          'Security by Default',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2D1E5F),
          ),
        ),
        const SizedBox(height: 40),
        Text(
          'Kakoak Apps ita nia momentu pesoal balun compartilha ina aplikasaun Kakoak, tamba ne\'e mak ami kria enkriptsaun husi rohan ba rohan iha versaun ikus liu. Enkuandu rohan ba rohan enkriptadu, ita nia mensajen no xamada seguru no uniku ema ne\'ebe imi komunika mak bele le\'e no rona, laiha tan ema seluk, nein aplikasaun Kakoak mós.',
          style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSecurityImage() {
    return Image.asset('assets/images/security_shield.png', height: 400);
  }
}

class Footer extends StatelessWidget {
  final Map<String, LandingContentItem> data;
  const Footer({Key? key, required this.data}) : super(key: key);
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
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/images/google_play.png', height: 30),
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
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset('assets/images/app_store.png', height: 30),
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
                  children: [
                    _buildCopyRightText(),
                    _buildFooterLinks(),
                  ],
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
            color: Colors.deepOrange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.asset(
            'assets/images/white_logo.png',
            height: 30,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          'Kakoak',
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
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
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/images/google_play.png', height: 30),
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
                Image.asset('assets/images/app_store.png', height: 30),
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
        _footerLink('Terms of Service'),
        const SizedBox(width: 15),
        _footerLink('Privacy Policy'),
        const SizedBox(width: 15),
        _footerLink('Cookies'),
      ],
    );
  }

  Widget _buildCopyRightText() {
    return const Text(
      'Copy right © 2024 Viettel Timor, Unipessoal, LDA. ALL RIGHTS RESERVED.',
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