import 'package:flutter/material.dart';
import 'widgets/main_content.dart';
import 'package:flutter_app/ui/pages/layout/main_layout.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(content: MainContent());
  }
}
