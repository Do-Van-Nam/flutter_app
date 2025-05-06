import 'package:flutter_app/models/collection_item.dart';

class Collection {
  final int collectionId;
  final String collectionName;
  final List<CollectionItem> items;

  Collection({
    required this.collectionId,
    required this.collectionName,
    required this.items,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
  return Collection(
    collectionId: json['collectionId'] ?? 0,
    collectionName: json['collectionName'] ?? '',
    items: (json['items'] as List?)
            ?.map((item) => CollectionItem.fromJson(item))
            .toList() 
        ?? [],
  );
}
}

