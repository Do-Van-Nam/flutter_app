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