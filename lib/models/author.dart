class Author {
  final int id;
  final String aliasName;
  final String realName;
  final int isLike;

  Author({required this.id, required this.aliasName, required this.realName, this.isLike = 0});

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      id: json['id'] ?? 0, // Default to 0 if null
      aliasName: json['aliasName'] ?? 'Unknown', // Default to 'Unknown' if null
      realName: json['realName'] ?? 'Unknown', // Default to 'Unknown' if null
      isLike: json['isLike'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'aliasName': aliasName, 'realName': realName, 'isLike': isLike};
  }
}