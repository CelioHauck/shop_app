abstract class IHttpService<T> {
  Future<Map<String, dynamic>?> all();
  Future<String> post(T entity);
}
