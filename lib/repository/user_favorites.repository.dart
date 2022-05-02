import 'package:shop_app/models/base_model.dart';

import '../infra/ihttp_service.dart';
import '../providers/product.dart';

class _UserModel extends BaseModel {
  final bool isFavorite;
  _UserModel({
    required this.isFavorite,
  });

  _UserModel copyWith({
    bool? isFavorite,
  }) {
    return _UserModel(
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'isFavorite': isFavorite});

    return result;
  }

  @override
  String toJson() => '$isFavorite';
}

class UserFavoritesRepository {
  final IHttpService _client;

  const UserFavoritesRepository({required IHttpService client})
      : _client = client;

  Future<Iterable<Product>> allFavoritesProductsForUser(
      List<Product> products) async {
    final result = await _client.all(path: _client.auth.id);
    if (result != null) {
      final newProducts =
          products.fold<List<Product>>([], (previousValue, element) {
        final teste = result[element.id];
        if (teste != null) {
          final newProduct = element.copyWith(isFavorite: teste);
          previousValue.add(newProduct);
          return previousValue;
        }
        previousValue.add(element);
        return previousValue;
      });
      return newProducts;
    }
    return products;
  }

  Future<void> favoriteOrUnfavorite(String id, bool isFavorite) async {
    await _client.put<_UserModel>(
      id,
      _UserModel(isFavorite: isFavorite),
      path: _client.auth.id,
    );
  }
}
