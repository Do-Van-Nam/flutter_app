class Playlist {
  final int id;
  final String playlistName;
  final String avatar;
  final String description;
  final int isActive;
  final int numberOfSongs;
  final int totalListens;
  final int totalLiked;
  final int totalShared;
  final int totalComment;
  final int numberOfArtists;
  final String userId;
  final String updatedAt;

  Playlist({
    required this.id,
    required this.playlistName,
    required this.avatar,
    required this.description,
    required this.isActive,
    required this.numberOfSongs,
    required this.totalListens,
    required this.totalLiked,
    required this.totalShared,
    required this.totalComment,
    required this.numberOfArtists,
    required this.userId,
    required this.updatedAt,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      playlistName: json['playlistName'] ?? '',
      avatar: json['avatar'] ?? '',
      description: json['description'] ?? '',
      isActive: json['isActive'] ?? 0,
      numberOfSongs: json['numberOfSongs'] ?? 0,
      totalListens: json['totalListens'] ?? 0,
      totalLiked: json['totalLiked'] ?? 0,
      totalShared: json['totalShared'] ?? 0,
      totalComment: json['totalComment'] ?? 0,
      numberOfArtists: json['numberOfArtists'] ?? 0,
      userId: json['userId'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playlistName': playlistName,
      'avatar': avatar,
      'description': description,
      'isActive': isActive,
      'numberOfSongs': numberOfSongs,
      'totalListens': totalListens,
      'totalLiked': totalLiked,
      'totalShared': totalShared,
      'totalComment': totalComment,
      'numberOfArtists': numberOfArtists,
      'userId': userId,
      'updatedAt': updatedAt,
    };
  }
}
