import 'dart:convert';

import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/providers/product.dart';

class ProductRepository {
  final IHttpService<Product> _client;

  const ProductRepository({required IHttpService<Product> client})
      : _client = client;

  Future<Iterable<Product>> all() async {
    final productsMap = await _client.all();
    if (productsMap != null) {
      final products =
          productsMap.entries.fold<List<Product>>([], (previousValue, element) {
        previousValue
            .add(Product.fromMap(element.value).copyWith(id: element.key));
        return previousValue;
      });
      return products;
    }
    return [];
  }

  Future<String> post(Product entity) async {
    final key = await _client.post(entity);
    return Future.value(const JsonDecoder().convert(key)['name']);
  }

  Future<void> patch(String id, Product entity) async {
    await _client.patch(id, entity);
  }

  Future<void> delete(String id) async {
    await _client.delete(id);
  }

  Future<void> favoriteOrUnfavorite(String id, bool isFavorite) async {
    final old = Product.fromMap(await _client.findById(id));
    final newProduct = old.copyWith(isFavorite: isFavorite);
    await _client.patch(id, newProduct);
  }
}
