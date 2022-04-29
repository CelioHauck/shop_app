import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shop_app/infra/ihttp_service.dart';
import 'package:http/http.dart' show Client;
import 'package:shop_app/models/base_model.dart';

const env = "https://flutter-project-91c38-default-rtdb.firebaseio.com";

class HttpService implements IHttpService {
  final Client _client;
  final Uri _basicUri;
  final String _relativePath;
  final String _fullPath;
  final String? _token;

  HttpService({
    required Client client,
    required String relativePath,
    String? fullPath,
    String? token,
  })  : _client = client,
        _relativePath = relativePath,
        _fullPath = fullPath ?? '',
        _token = token,
        // _basicUri = Uri.parse('https://identitytoolkit.googleapis.com/v1');
        _basicUri = Uri.parse(
            '${fullPath ?? env}$relativePath${fullPath != null ? '' : '.json'}');
  // _basicUri = Uri.parse(
  //     fullPath ?? env, '$relativePath${fullPath != null ? '' : '.json'}');

  String get isRealtimeDatabase {
    return _fullPath.isEmpty ? '.json$getToken' : '';
  }

  String? get getToken {
    if (_token != null && _token!.isNotEmpty) {
      return '?auth=$_token';
    }
    return null;
  }

  @override
  Future<Map<String, dynamic>?> all() async {
    final response = await _client.get(Uri.parse('$_basicUri$getToken'));
    final extractData = json.decode(response.body);
    return extractData;
  }

  @override
  Future<String> post<T extends BaseModel>(
    T entity, {
    String? path,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _client.post(
        path != null && path.isNotEmpty
            ? Uri.parse('$_basicUri$path')
            : _basicUri,
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
  Future<void> patch<T extends BaseModel>(id, T entity) async {
    final url = Uri.parse('$env/$_relativePath/$id$isRealtimeDatabase');
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
      final url = Uri.parse('$env$_relativePath/$id$isRealtimeDatabase');
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
      final url = Uri.parse('$env$_relativePath/$id$isRealtimeDatabase');
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
