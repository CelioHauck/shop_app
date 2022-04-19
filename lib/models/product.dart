import 'dart:convert';

class Product {
  final String id;
  final String title;
  final String descriptionl;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.descriptionl,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  Product copyWith({
    String? id,
    String? title,
    String? descriptionl,
    double? price,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      descriptionl: descriptionl ?? this.descriptionl,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'descriptionl': descriptionl});
    result.addAll({'price': price});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'isFavorite': isFavorite});

    return result;
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      descriptionl: map['descriptionl'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(id: $id, title: $title, descriptionl: $descriptionl, price: $price, imageUrl: $imageUrl, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.descriptionl == descriptionl &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        descriptionl.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        isFavorite.hashCode;
  }
}
