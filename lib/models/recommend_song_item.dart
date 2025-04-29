class RecommendSongItem {
  final int id;
  String? countryCode;
  final String songName;
  final String avatar;
  final String mediaPath;
  final int bitRate;
  final int duration;
  final int totalListens;
  final int totalDownload;
  final int totalLiked;
  final int totalShared;
  final int totalComment;
  final int isLike;
  final int numberOfArtists;
  final List<Artist> artists;
  final String link;

  RecommendSongItem({
    required this.id,
    this.countryCode,
    required this.songName,
    required this.avatar,
    required this.mediaPath,
    required this.bitRate,
    required this.duration,
    required this.totalListens,
    required this.totalDownload,
    required this.totalLiked,
    required this.totalShared,
    required this.totalComment,
    required this.isLike,
    required this.numberOfArtists,
    required this.artists,
    required this.link,
  });

  factory RecommendSongItem.fromJson(Map<String, dynamic> json) {
    return RecommendSongItem(
      id: json['id'] ?? 0, // Default to 0 if null
      songName: json['songName'] ?? 'Unknown', // Default to 'Unknown' if null
      avatar: json['avatar'] ?? '', // Default to empty string if null
      mediaPath: json['mediaPath'] ?? '',
      bitRate: json['bitRate'] ?? 0, // Default to 0 if null
      duration: json['duration'] ?? 0, // Default to 0 if null
      totalListens: json['totalListens'] ?? 0, // Default to 0 if null
      totalDownload: json['totalDownload'] ?? 0, // Default to 0 if null
      totalLiked: json['totalLiked'] ?? 0, // Default to 0 if null
      totalShared: json['totalShared'] ?? 0, // Default to 0 if null
      totalComment: json['totalComment'] ?? 0, // Default to 0 if null
      isLike: json['isLike'] ?? 0, // Default to 0 if null
      numberOfArtists: json['numberOfArtists'] ?? 0, // Default to 0 if null
      artists: (json['artists'] as List<dynamic>?)
              ?.map((artistJson) => Artist.fromJson(artistJson))
              .toList() ??
          [], // Handle null artists list
      link: json['link'] ?? '', // Default to empty string if null
      countryCode: json['countryCode'], // Optional field, can be null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'songName': songName,
      'avatar': avatar,
      'mediaPath': mediaPath,
      'bitRate': bitRate,
      'duration': duration,
      'totalListens': totalListens,
      'totalDownload': totalDownload,
      'totalLiked': totalLiked,
      'totalShared': totalShared,
      'totalComment': totalComment,
      'isLike': isLike,
      'numberOfArtists': numberOfArtists,
      'artists': artists.map((artist) => artist.toJson()).toList(),
      'link': link,
      'countryCode': countryCode,
    };
  }
}

class Artist {
  final int id;
  final String aliasName;
  final String realName;

  Artist({required this.id, required this.aliasName, required this.realName});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] ?? 0, // Default to 0 if null
      aliasName: json['aliasName'] ?? 'Unknown', // Default to 'Unknown' if null
      realName: json['realName'] ?? 'Unknown', // Default to 'Unknown' if null
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'aliasName': aliasName, 'realName': realName};
  }
}
