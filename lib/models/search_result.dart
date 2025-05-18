import 'package:flutter_app/models/album.dart';
import 'package:flutter_app/models/artist.dart';
import 'package:flutter_app/models/playlist.dart';
import 'package:flutter_app/models/song_item.dart';

class Item {
  final int id;
  final String itemName;
  final String avatar;
  final String itemType;
  final SongItem? songInfo;
  final Album? albumInfo;
  final Artist? artistInfo;
  final Playlist? playlistInfo;

  Item({
    required this.id,
    required this.itemName,
    required this.avatar,
    required this.itemType,
    required this.songInfo,
    required this.albumInfo,
    required this.artistInfo,
    required this.playlistInfo,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      itemName: json['itemName'],
      avatar: json['avatar'],
      itemType: json['itemType'],
      songInfo: json['songInfo'] != null ? SongItem.fromJson(json['songInfo']) : null,
      albumInfo: json['albumInfo'] != null ? Album.fromJson(json['albumInfo']) : null,
      artistInfo: json['artistInfo'] != null ? Artist.fromJson(json['artistInfo']) : null,
      playlistInfo: json['playlistInfo'] != null ? Playlist.fromJson(json['playlistInfo']) : null,
    );
  }
}

class Group {
  final String groupName;
  final String groupType;
  final List<Item> items;

  Group({
    required this.groupName,
    required this.groupType,
    required this.items,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupName: json['groupName'],
      groupType: json['groupType'],
      items: List<Item>.from(json['items'].map((i) => Item.fromJson(i))),
    );
  }
}

class SearchResponse {
  final List<Group> data;

  SearchResponse({required this.data});

  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    return SearchResponse(
      data: List<Group>.from(json['data'].map((g) => Group.fromJson(g))),
    );
  }
}