import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/models/order_item.dart';

class OrderRepository {
  final IHttpService<OrderItem> _client;

  const OrderRepository({required IHttpService<OrderItem> client})
      : _client = client;

  Future<String> post(OrderItem order) async {
    return await _client.post(order);
  }

  Future<Iterable<OrderItem>> all() async {
    final ordersMap = await _client.all();
    if (ordersMap != null) {
      final orders = ordersMap.entries.fold<List<OrderItem>>(
        [],
        (previousValue, element) {
          previousValue.add(OrderItem.fromMap(element.value));
          return previousValue;
        },
      );
      return orders;
    }
    return [];
  }
}
