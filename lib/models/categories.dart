class Categorie {
  final int id;
  final String cateName;


  Categorie({required this.id, required this.cateName,});

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'] ?? 0, // Default to 0 if null
      cateName: json['cateName'] ?? 'Unknown', // Default to 'Unknown' if null
      
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'cateName': cateName,};
  }
}