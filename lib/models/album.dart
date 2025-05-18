class Album {
  final int id;
  final String albumName;
  final String avatar;
  final String description;
  final int numberOfSongs;
  final String slug;
  final int totalListens;
  final int totalDownload;
  final int totalLiked;
  final int totalShared;
  final int totalComment;
  final int numberOfArtists;
  final String updatedAt;
  final String countryNameVn;
  final String countryNameEn;

  Album({
    required this.id,
    required this.albumName,
    required this.avatar,
    required this.description,
    required this.numberOfSongs,
    required this.slug,
    required this.totalListens,
    required this.totalDownload,
    required this.totalLiked,
    required this.totalShared,
    required this.totalComment,
    required this.numberOfArtists,
    required this.updatedAt,
    required this.countryNameVn,
    required this.countryNameEn,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      albumName: json['albumName'],
      avatar: json['avatar'],
      description: json['description'],
      numberOfSongs: json['numberOfSongs'],
      slug: json['slug'],
      totalListens: json['totalListens'],
      totalDownload: json['totalDownload'],
      totalLiked: json['totalLiked'],
      totalShared: json['totalShared'],
      totalComment: json['totalComment'],
      numberOfArtists: json['numberOfArtists'],
      updatedAt: json['updatedAt'],
      countryNameVn: json['countryNameVn'],
      countryNameEn: json['countryNameEn'],
    );
  }
}
