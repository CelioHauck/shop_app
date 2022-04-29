import '../models/base_model.dart';

abstract class IHttpService {
  Future<Map<String, dynamic>?> all();
  Future<Map<String, dynamic>> findById(dynamic id);
  Future<String> post<T extends BaseModel>(
    T entity, {
    String path,
    Map<String, String>? headers,
  });
  Future<void> patch<T extends BaseModel>(dynamic id, T entity);
  Future<void> delete(dynamic id);
  // TODO: Pode?
  // Future<A> post<T extends BaseModel, A>(T entity);
}
