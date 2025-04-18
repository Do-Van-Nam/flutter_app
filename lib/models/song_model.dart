class Song {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String coverUrl;
  final String url;
  final Duration duration;
  
  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.coverUrl,
    required this.url,
    required this.duration,
  });
  
  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      album: json['album'],
      coverUrl: json['coverUrl'],
      url: json['url'],
      duration: Duration(milliseconds: json['durationMs']),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'coverUrl': coverUrl,
      'url': url,
      'durationMs': duration.inMilliseconds,
    };
  }
}
