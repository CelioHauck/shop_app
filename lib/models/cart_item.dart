import 'dart:convert';

import 'package:flutter/material.dart';

class CartItem {
  final UniqueKey id;
  final String title;
  final int quantity;
  final double price;
  const CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    UniqueKey? id,
    String? title,
    int? quantity,
    double? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'CartItem(id: $id, title: $title, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.id == id &&
        other.title == title &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ quantity.hashCode ^ price.hashCode;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id.toString()});
    result.addAll({'title': title});
    result.addAll({'quantity': quantity});
    result.addAll({'price': price});

    return result;
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: UniqueKey(),
      title: map['title'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      price: map['price']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source));
}
