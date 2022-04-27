abstract class IHttpService<T> {
  Future<Iterable<T>> all();
  Future<T> findById(dynamic id);
  Future<A> post<A>(T entity);
}
