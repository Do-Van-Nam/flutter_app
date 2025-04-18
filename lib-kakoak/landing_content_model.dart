class LandingContentResponse {
  final int code;
  final List<LandingContentItem> data;

  LandingContentResponse({
    required this.code,
    required this.data,
  });

  factory LandingContentResponse.fromJson(Map<String, dynamic> json) {
    return LandingContentResponse(
      code: json['code'],
      data: (json['data'] as List)
          .map((item) => LandingContentItem.fromJson(item))
          .toList(),
    );
  }
}

class LandingContentItem {
  final String key;
  final String? image;
  final String? title;
  final String? titleTetun;
  final String? link;
  final String? content;
  final String? contentTetun;

  LandingContentItem({
    required this.key,
    this.image,
    this.title,
    this.titleTetun,
    this.link,
    this.content,
    this.contentTetun,
  });

  factory LandingContentItem.fromJson(Map<String, dynamic> json) {
    return LandingContentItem(
      key: json['key'],
      image: json['image'],
      title: json['title'],
      titleTetun: json['titleTetun'],
      link: json['link'],
      content: json['content'],
      contentTetun: json['contentTetun'],
    );
  }
}
