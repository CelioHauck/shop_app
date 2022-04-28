import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../models/base_model.dart';

class Product with ChangeNotifier implements BaseModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      imageUrl: map['imageUrl'] ?? '',
      isFavorite: map['isFavorite'] ?? false,
    );
  }

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return json.encode(toMap());
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'description': description});
    result.addAll({'price': price});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'isFavorite': isFavorite});

    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        isFavorite.hashCode;
  }
}
