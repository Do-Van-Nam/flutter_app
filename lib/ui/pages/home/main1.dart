import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_screen.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UMusic',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

Widget buildContent() {
  return Column(
    children: [
      Text('hello'),
      SizedBox(height: 20),
      Text('world'),
      SizedBox(height: 20),
      Text('world'),
      SizedBox(height: 20),
      GestureDetector(
        onTap: () {
          // Handle tap event
          print('Tapped!');
        },
        child: Container(
          color: Colors.blue,
          width: 100,
          height: 100,
          child: const Center(child: Text('Tap me')),
        ),
      ), 

    ],
  );
}
