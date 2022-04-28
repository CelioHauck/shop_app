import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/models/order_item.dart';

class OrderRepository {
  final IHttpService<OrderItem> _client;

  const OrderRepository({required IHttpService<OrderItem> client})
      : _client = client;

  Future<String> post(OrderItem order) {
    return _client.post(order);
  }
}
