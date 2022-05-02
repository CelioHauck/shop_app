import 'package:flutter/material.dart';
import 'package:shop_app/repository/order.repository.dart';

import '../infra/ihttp_service.dart';
import '../models/cart_item.dart';
import '../models/order_item.dart';

class Orders with ChangeNotifier {
  Orders({
    required IHttpService service,
    required List<OrderItem> orders,
  })  : _service = OrderRepository(client: service),
        _orders = orders;

  final List<OrderItem> _orders;
  final OrderRepository _service;

  List<OrderItem> get orders {
    return [..._orders.reversed];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final newOrder = OrderItem(
      id: UniqueKey(),
      amount: total,
      products: cartProducts,
      dateTime: DateTime.now(),
    );
    _orders.insert(0, newOrder);
    notifyListeners();

    try {
      await _service.post(newOrder);
    } catch (e) {
      _orders.removeAt(0);
      notifyListeners();
      rethrow;
    }
  }

  Future<void> fetchOrders() async {
    final newOrders = await _service.all();
    _orders.clear();
    _orders.addAll(newOrders);
    notifyListeners();
  }
}
