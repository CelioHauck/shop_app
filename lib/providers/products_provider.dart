import 'package:flutter/material.dart';
import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/repository/product.repository.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final ProductRepository _service;

  Products({
    required IHttpService service,
    required List<Product> items,
  })  : _service = ProductRepository(
          client: service,
        ),
        _items = items;
  // _token = token;

  final List<Product> _items;

  // final String? _token;

  // var _showFavoritesOnly = false;

  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favorites {
    // if (_showFavoritesOnly) {
    //   return _items.where((element) => element.isFavorite).toList();
    // }
    return _items.where((element) => element.isFavorite).toList();
  }

  // void showFavoriteOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Product getItem(String id) {
    final product = _items.firstWhere((element) => element.id == id);
    return product.copyWith();
  }

  Future<void> fetchProducts() async {
    final products = await _service.all();
    _items.clear();
    _items.addAll(products);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final hasProduct = _items.any((element) => element.id == product.id);

    try {
      if (hasProduct) {
        final index = _items.indexWhere((element) => element.id == product.id);
        await _service.patch(product.id, product);
        _items[index] = product;
      } else {
        final newProduct = Product(
          id: DateTime.now().toString(),
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl,
        );

        final idServer = await _service.post(newProduct);
        _items.add(
          newProduct.copyWith(
            id: idServer,
          ),
        );
      }
    } catch (error) {
      print(error);
      rethrow;
    }
    notifyListeners();
  }

  Future<void> deleteProduct(String id) async {
    await _service.delete(id);
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  Future<void> toogleFavorite(String id, bool isFavorite) async {
    await _service.favoriteOrUnfavorite(id, isFavorite);
  }
}
