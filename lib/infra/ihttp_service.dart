abstract class IHttpService<T> {
  Future<Iterable<T>> all();
  Future<T> findById(dynamic id);
  Future post(T entity);
}
