import 'package:shop_app/models/auth_model.dart';

import '../models/base_model.dart';

abstract class IHttpService {
  AuthModel get auth;
  Future<Map<String, T>?> all<T>({
    String? path,
    String? queryParams,
    Map<String, String>? headers,
  });
  Future<Map<String, dynamic>> findById(dynamic id);
  Future<String> post<T extends BaseModel>(
    T entity, {
    String? path,
    Map<String, String>? headers,
  });
  Future<void> patch<T extends BaseModel>(
    dynamic id,
    T entity, {
    String? path,
    Map<String, String>? headers,
  });
  Future<void> put<T extends BaseModel>(
    dynamic id,
    T entity, {
    String? path,
    Map<String, String>? headers,
  });
  Future<void> delete(dynamic id);
  // TODO: Pode?
  // Future<A> post<T extends BaseModel, A>(T entity);
}
