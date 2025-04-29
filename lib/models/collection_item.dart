
class CollectionItem {
  final int id;
  final String itemName;
  final String itemNameVi;
  final String itemNameEn;
  final String itemNameLa;
  final String avatar;
  final String itemType;
  final String link;
  final int isLike;

  CollectionItem({
    required this.id,
    required this.itemName,
    required this.itemNameVi,
    required this.itemNameEn,
    required this.itemNameLa,
    required this.avatar,
    required this.itemType,
    required this.link,
    required this.isLike,
  });

  factory CollectionItem.fromJson(Map<String, dynamic> json) {
    return CollectionItem(
      id: json['id'],
      itemName: json['itemName'],
      itemNameVi: json['itemNameVi'],
      itemNameEn: json['itemNameEn'],
      itemNameLa: json['itemNameLa'],
      avatar: json['avatar'],
      itemType: json['itemType'],
      link: json['link'],
      isLike: json['isLike'],
    );
  }
}