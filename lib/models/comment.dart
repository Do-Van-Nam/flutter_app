class Comment {
  final String id;
  final String username;
  final String avatarUrl;
  final String content;
  final DateTime timestamp;
  int likes;

  Comment({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.content,
    required this.timestamp,
    required this.likes,
  });
}
