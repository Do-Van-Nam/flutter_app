class Artist {
  final int id;
  final String aliasName;
  final String realName;
  final String? avatar;
  final String? info;
  final int? isLike;
  final String? birthday;
  final String? gender;
  final String? slug;
  final String? updatedAt;
  final int? totalLiked;
  final String? countryName;
  final String? countryNameVn;
  final String? countryNameEn;
  final String? link;

  Artist({required this.id, required this.aliasName, required this.realName,
    this.avatar, this.info, this.isLike, this.birthday, this.gender, this.slug,
    this.updatedAt, this.totalLiked, this.countryName, this.countryNameVn,
    this.countryNameEn, this.link});

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'] ?? 0, // Default to 0 if null
      aliasName: json['aliasName'] ?? 'Unknown', // Default to 'Unknown' if null
      realName: json['realName'] ?? 'Unknown', // Default to 'Unknown' if null
      avatar: json['avatar'] ?? 'Unknown', // Default to 'Unknown' if null
      info: json['info'] ?? 'Unknown', // Default to 'Unknown' if null
      isLike: json['isLike'] ?? 0, // Default to 0 if null
      birthday: json['birthday'] ?? 'Unknown', // Default to 'Unknown' if null
      gender: json['gender'] ?? 'Unknown', // Default to 'Unknown' if null
      slug: json['slug'] ?? 'Unknown', // Default to 'Unknown' if null
      updatedAt: json['updatedAt'] ?? 'Unknown', // Default to 'Unknown' if null
      totalLiked: json['totalLiked'] ?? 0, // Default to 0 if null
      countryName: json['countryName'] ?? 'Unknown', // Default to 'Unknown' if null
      countryNameVn: json['countryNameVn'] ?? 'Unknown', // Default to 'Unknown' if null
      countryNameEn: json['countryNameEn'] ?? 'Unknown', // Default to 'Unknown' if null
      link: json['link'] ?? 'Unknown', // Default to 'Unknown' if null
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'aliasName': aliasName,
      'realName': realName,
      'avatar': avatar,
      'info': info,
      'isLike': isLike,
      'birthday': birthday,
      'gender': gender,
      'slug': slug,
      'updatedAt': updatedAt,
      'totalLiked': totalLiked,
      'countryName': countryName,
      'countryNameVn': countryNameVn,
      'countryNameEn': countryNameEn,
      'link': link,
    };
  }
}