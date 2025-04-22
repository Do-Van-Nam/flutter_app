import 'package:flutter/material.dart';

class AppState with ChangeNotifier {
  int _selectedIndex = 0;
  bool _isExpanded = true;

  int get selectedIndex => _selectedIndex;
  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
  
  bool get isExpanded => _isExpanded;
  set isExpanded(bool expanded) {
    _isExpanded = expanded;
    notifyListeners();
  }
}