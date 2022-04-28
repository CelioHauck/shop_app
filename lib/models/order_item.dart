import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/models/base_model.dart';

import 'cart_item.dart';

class OrderItem implements BaseModel {
  final UniqueKey id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });

  OrderItem copyWith({
    UniqueKey? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
  }) {
    return OrderItem(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      products: products ?? this.products,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  factory OrderItem.fromMap(Map<String, dynamic> map) {
    return OrderItem(
      id: UniqueKey(),
      amount: map['amount']?.toDouble() ?? 0.0,
      products:
          List<CartItem>.from(map['products']?.map((x) => CartItem.fromMap(x))),
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime']),
    );
  }

  factory OrderItem.fromJson(String source) =>
      OrderItem.fromMap(json.decode(source));

  @override
  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'OrderItem(id: $id, amount: $amount, products: $products, dateTime: $dateTime)';
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id.toString()});
    result.addAll({'amount': amount});
    result.addAll({'products': products.map((x) => x.toMap()).toList()});
    result.addAll({'dateTime': dateTime.millisecondsSinceEpoch});

    return result;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderItem &&
        other.id == id &&
        other.amount == amount &&
        listEquals(other.products, products) &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        products.hashCode ^
        dateTime.hashCode;
  }
}
