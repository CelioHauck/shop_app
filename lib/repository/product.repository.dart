import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/providers/product.dart';

class ProductRepository implements IHttpService<Product> {
  final IHttpService<Product> _client;

  const ProductRepository({required IHttpService<Product> client})
      : _client = client;

  @override
  Future<Iterable<Product>> all() {
    return _client.all();
  }

  @override
  Future<Product> findById(id) {
    return _client.findById(id);
  }

  @override
  Future post(Product entity) {
    return _client.post(entity);
  }
}
