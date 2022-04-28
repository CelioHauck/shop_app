import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/infra/ihttp_service.dart';
import 'package:http/http.dart' show Client;
import 'package:shop_app/models/base_model.dart';

const env = "flutter-project-91c38-default-rtdb.firebaseio.com";

class HttpService<T extends BaseModel> implements IHttpService<T> {
  final Client _client;
  final Uri _basicUri;
  final String _relativePath;

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
  Future<String> post(T entity) async {
    try {
      final response = await _client.post(
        _basicUri,
        body: entity.toJson(),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ErrorDescription(response.body);
      }
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> patch(id, T entity) async {
    final url = _basicUri.replace(path: '$_relativePath/$id.json');
    final response = await _client.patch(url, body: entity.toJson());

    if (response.statusCode != 200) {
      throw ErrorDescription(response.body);
    }
  }

  @override
  Future<void> delete(id) async {
    if (id == null) {
      throw ErrorDescription('Informe o id');
    }

    try {
      final url = _basicUri.replace(path: '$_relativePath/$id');
      final response = await _client.delete(url);
      if (response.statusCode != 200) {
        throw ErrorDescription(response.body);
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> findById(id) async {
    if (id == null) {
      throw ErrorDescription('Informe o id');
    }

    try {
      final url = _basicUri.replace(path: '$_relativePath/$id.json');
      final response = await _client.get(url);
      if (response.statusCode != 200) {
        throw ErrorDescription(response.body);
      }

      final extractData = json.decode(response.body);
      return extractData;
    } catch (error) {
      rethrow;
    }
  }
}
