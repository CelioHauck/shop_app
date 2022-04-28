import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/infra/ihttp_service.dart';
import 'package:http/http.dart' show Client;

const env = "flutter-project-91c38-default-rtdb.firebaseio.com";

class HttpService<T> implements IHttpService<T> {
  final Client _client;
  final Uri _basicUri;
  final String _relativePath;
  final JsonEncoder _encoder = const JsonEncoder();

  HttpService({required Client client, required String relativePath})
      : _client = client,
        _relativePath = relativePath,
        _basicUri = Uri.https(env, '$relativePath.json');

  @override
  Future<Map<String, dynamic>?> all() async {
    final response = await _client.get(_basicUri);
    final extractData = json.decode(response.body);
    return extractData;
  }

  @override
  Future<String> post(T entity) {
    return _client
        .post(
          _basicUri,
          body: entity.toString(),
        )
        .then(
          (value) => value.body,
        );
  }

  @override
  Future<void> patch(id, T entity) async {
    final url = _basicUri.replace(path: '$_relativePath/$id.json');
    final response = await _client.patch(url, body: entity.toString());

    if (response.statusCode != 200) {
      throw ErrorDescription(response.body);
    }
  }
}
