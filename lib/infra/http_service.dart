import 'dart:convert';

import 'package:shop_app/infra/ihttp_service.dart';
import 'package:http/http.dart';

const env = "flutter-project-91c38-default-rtdb.firebaseio.com";

class HttpService<T> implements IHttpService<T> {
  final Client _client;
  final Uri _relativePath;

  HttpService({required Client client, required String relativePath})
      : _client = client,
        _relativePath = Uri.https(env, relativePath);

  @override
  Future<Iterable<T>> all() {
    // TODO: implement all
    throw UnimplementedError();
  }

  @override
  Future<T> findById(id) {
    // TODO: implement findById
    throw UnimplementedError();
  }

// N entendi o problema
  @override
  Future<Response> post<Response>(T entity) {
    final result = _client.post(
      _relativePath,
      body: const JsonEncoder().convert(entity),
    );
    return result as Future<Response>;
  }
}
