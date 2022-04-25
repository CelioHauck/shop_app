import 'dart:convert';

import 'package:flutter/material.dart';

class CartIem {
  final UniqueKey id;
  final String title;
  final int quantity;
  final double price;

  CartIem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });

  CartIem copyWith({
    UniqueKey? id,
    String? title,
    int? quantity,
    double? price,
  }) {
    return CartIem(
      id: id ?? this.id,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'CartIem(id: $id, title: $title, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartIem &&
        other.id == id &&
        other.title == title &&
        other.quantity == quantity &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ quantity.hashCode ^ price.hashCode;
  }
}
