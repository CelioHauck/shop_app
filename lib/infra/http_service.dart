import 'dart:convert';
import 'dart:math';

import 'package:shop_app/infra/ihttp_service.dart';
import 'package:http/http.dart' as http;

const env = "flutter-project-91c38-default-rtdb.firebaseio.com";

class HttpService<T> implements IHttpService<T> {
  final http.Client _client;
  final Uri _relativePath;

  HttpService({required http.Client client, required String relativePath})
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

  @override
  Future<void> post(T entity) {
    return _client.post(
      _relativePath,
      body: const JsonEncoder().convert(entity),
    );
  }
}
