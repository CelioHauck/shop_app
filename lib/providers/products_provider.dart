import 'package:flutter/material.dart';
import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/repository/product.repository.dart';

import 'product.dart';

class Products with ChangeNotifier {
  final ProductRepository _service;

  Products({required IHttpService<Product> service})
      : _service = ProductRepository(client: service);

  final List<Product> _items = [];

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
    _items.addAll(products);
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final hasProduct = _items.any((element) => element.id == product.id);
    if (hasProduct) {
      final index = _items.indexWhere((element) => element.id == product.id);
      _items[index] = product;
    } else {
      final newProduct = Product(
        id: DateTime.now().toString(),
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      try {
        final idServer = await _service.post(newProduct);
        _items.add(
          newProduct.copyWith(
            id: idServer,
          ),
        );
        notifyListeners();
      } catch (error) {
        print(error);
        rethrow;
      }
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
