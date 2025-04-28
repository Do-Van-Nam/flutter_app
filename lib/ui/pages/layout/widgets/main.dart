import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("Wrap - spaceAround Example")),
        body: const Padding(
          padding: EdgeInsets.all(16),
          child: WrapExample(),
        ),
      ),
    );
  }
}

class WrapExample extends StatelessWidget {
  const WrapExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      child: Wrap(
        alignment: WrapAlignment.center, // 👈 Căn đều và chừa khoảng hai bên
        spacing: 16, // Khoảng cách giữa các phần tử cùng dòng
        runSpacing: 16, // Khoảng cách giữa các dòng
        children: List.generate(10, (index) {
          return Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Box ${index + 1}',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          );
        }),
      ),
    );
  }
}
