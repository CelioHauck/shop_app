import 'dart:convert';

import 'package:shop_app/infra/ihttp_service.dart';
import 'package:http/http.dart' show Client;

const env = "flutter-project-91c38-default-rtdb.firebaseio.com";

class HttpService<T> implements IHttpService<T> {
  final Client _client;
  final Uri _relativePath;

  HttpService({required Client client, required String relativePath})
      : _client = client,
        _relativePath = Uri.https(env, relativePath);

  @override
  Future<Map<String, dynamic>?> all() async {
    final response = await _client.get(_relativePath);
    final extractData = json.decode(response.body);
    return extractData;
  }

  @override
  Future<String> post(T entity) {
    return _client
        .post(
          _relativePath,
          body: const JsonEncoder().convert(entity),
        )
        .then(
          (value) => value.body,
        );
  }
}
