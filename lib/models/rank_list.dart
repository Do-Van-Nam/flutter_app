import 'song_item.dart';

class RankList {
  final int id;
  final String cateName;
  final List<SongItem> items;

  RankList({
    required this.id,
    required this.cateName,
    required this.items,
  });

  factory RankList.fromJson(Map<String, dynamic> json) {
    return RankList(
      id: json['id'] ?? 0,
      cateName: json['cateName'] ?? '',
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => SongItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cateName': cateName,
      'items': items.map((song) => song.toJson()).toList(),
    };
  }
}
