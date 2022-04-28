import '../models/base_model.dart';

abstract class IHttpService<T extends BaseModel> {
  Future<Map<String, dynamic>?> all();
  Future<String> post(T entity);
  Future<void> patch(dynamic id, T entity);
}
