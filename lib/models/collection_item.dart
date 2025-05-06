class CollectionItem {
  final int id;
  final String itemName;
  final String? itemNameVi;
  final String? itemNameEn;
  final String? itemNameLa;
  final String avatar;
  final String itemType;
  final String link;
  final int isLike;
  final String? slug;

  CollectionItem({
    required this.id,
    required this.itemName,
    this.itemNameVi,
    this.itemNameEn,
    this.itemNameLa,
    required this.avatar,
    required this.itemType,
    required this.link,
    required this.isLike,
    this.slug,
  });

  factory CollectionItem.fromJson(Map<String, dynamic> json) {
    return CollectionItem(
      id: json['id'] ?? 0, // Nếu 'id' là null, trả về 0
      itemName:
          json['itemName'] ?? '', // Nếu 'itemName' là null, trả về chuỗi rỗng
      itemNameVi:
          json['itemNameVi'] ??
          '', // Nếu 'itemNameVi' là null, trả về chuỗi rỗng
      itemNameEn:
          json['itemNameEn'] ??
          '', // Nếu 'itemNameEn' là null, trả về chuỗi rỗng
      itemNameLa:
          json['itemNameLa'] ??
          '', // Nếu 'itemNameLa' là null, trả về chuỗi rỗng
      avatar: json['avatar'] ?? '', // Nếu 'avatar' là null, trả về chuỗi rỗng
      itemType:
          json['itemType'] ?? '', // Nếu 'itemType' là null, trả về chuỗi rỗng
      link: json['link'] ?? '', // Nếu 'link' là null, trả về chuỗi rỗng
      isLike: json['isLike'] ?? false,
      slug: json['slug'] ?? '',
    );
  }
}
