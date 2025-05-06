import 'package:flutter/material.dart';
import 'package:flutter_app/models/collection.dart';
import 'package:flutter_app/models/song_item.dart';

class AppState with ChangeNotifier {
  int _selectedIndex = 0;
  bool _isExpanded = true;
  List<Collection> _collections =[];
  List<SongItem> _songs = [];

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

  set collections(List<Collection> collections) {
    _collections = collections;
    notifyListeners();
  }
  void setCollections(List<Collection> value) {
    _collections = value;
    notifyListeners(); 
  }
  List<SongItem> get songs => _songs;
  set songs(List<SongItem> songs) {
    _songs = songs;
    notifyListeners();
  }
  List<Collection> get collections => _collections;
  void setSongs(List<SongItem> value) {
    _songs = value;
    notifyListeners(); 
  }
}