// import 'package:flutter/material.dart';
// import 'package: flutter/services.dart';
// import 'package:flutter_app/main.dart';
// import 'package:url_launcher/url_launcher.dart';

// void main() {
//   runApp(const MyApp());
// }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Kakoak',
//       theme: ThemeData(
//         primarySwatch: Colors.deepOrange,
//       ),
//       home: const KakoakHomePage(),
//     );
//   }
// }

// class KakoakHomePage extends StatelessWidget {
//   const KakoakHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Kakoak'),
//       ),
//       body: Center(
//         child: Column(
//           children: const [
//             NavBar(),
//             HeroSection(),
//             DownloadSection(),
//             AppFeaturesSection(),  
//             SecuritySection(),
//             Footer(),
//           ],
//         ),
//       ),
//     );
//   }

// }

// class NavBar extends StatelessWidget {
//   const NavBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       color: Colors.deepOrange,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const Text(
//             'Kakoak',
//             style: TextStyle(
//               fontSize: 24.0,
//               color: Colors.white,
//             ),
//           ),
//           Row(
//             children: [
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Home',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Features',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: const Text(
//                   'Download',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
