class BannerItem {
  final int id;
  final String key;
  final String file;
  final String titleEn;
  final String titleVi;
  final String titleLa;
  final String link;
  final int position;
  final int status;
  final int createdBy;
  final String createdAt;
  final String updatedAt;
  final int updatedBy;

  BannerItem({
    required this.id,
    required this.key,
    required this.file,
    required this.titleEn,
    required this.titleVi,
    required this.titleLa,
    required this.link,
    required this.position,
    required this.status,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.updatedBy,
  });

  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
      id: json['id'],
      key: json['key'],
      file: json['file'],
      titleEn: json['title_en'],
      titleVi: json['title_vi'],
      titleLa: json['title_la'],
      link: json['link'],
      position: json['position'],
      status: json['status'],
      createdBy: json['created_by'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      updatedBy: json['updated_by'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'key': key,
      'file': file,
      'title_en': titleEn,
      'title_vi': titleVi,
      'title_la': titleLa,
      'link': link,
      'position': position,
      'status': status,
      'created_by': createdBy,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'updated_by': updatedBy,
    };
  }
}
