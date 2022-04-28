import '../models/base_model.dart';

abstract class IHttpService<T extends BaseModel> {
  Future<Map<String, dynamic>?> all();
  Future<Map<String, dynamic>> findById(dynamic id);
  Future<String> post(T entity);
  Future<void> patch(dynamic id, T entity);
  Future<void> delete(dynamic id);
}
