import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';

class Cart with ChangeNotifier {
  final Map<String, CartIem> _items = {};

  Map<String, CartIem>? get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (value) => CartIem(
          id: value.id,
          title: value.title,
          quantity: value.quantity + 1,
          price: value.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartIem(
          id: UniqueKey(),
          title: title,
          quantity: 1,
          price: price,
        ),
      );
    }
    notifyListeners();
  }
}
