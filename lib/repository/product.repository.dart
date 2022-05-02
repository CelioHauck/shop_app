import 'dart:convert';

import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/providers/product.dart';

class ProductRepository {
  final IHttpService _client;

  const ProductRepository({required IHttpService client}) : _client = client;

  Future<Iterable<Product>> all([bool filterByUser = false]) async {
    final productsMap = await _client.all(
      queryParams: filterByUser
          ? 'orderBy="creatorId"&equalTo="${_client.auth.id}"'
          : '',
    );
    if (productsMap != null) {
      final products = productsMap.entries.fold<List<Product>>(
        [],
        (previousValue, element) {
          previousValue
              .add(Product.fromMap(element.value).copyWith(id: element.key));
          return previousValue;
        },
      );
      return products;
    }
    return [];
  }

  Future<String> post(Product entity) async {
    final key = await _client.post(entity.copyWith(creatorId: _client.auth.id));
    return Future.value(const JsonDecoder().convert(key)['name']);
  }

  Future<void> patch(String id, Product entity) async {
    await _client.patch(id, entity);
  }

  Future<void> delete(String id) async {
    await _client.delete(id);
  }
}
