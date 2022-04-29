import 'dart:convert';

import 'package:shop_app/models/base_model.dart';

class AuthModel implements BaseModel {
  final String _token;
  final DateTime _expiryDate;
  final String _userId;

  const AuthModel({
    required String token,
    required DateTime expiryDate,
    required String userId,
  })  : _expiryDate = expiryDate,
        _token = token,
        _userId = userId;

  AuthModel copyWith({
    String? token,
    DateTime? expiryDate,
    String? userId,
  }) {
    return AuthModel(
      token: token ?? _token,
      expiryDate: expiryDate ?? _expiryDate,
      userId: userId ?? _userId,
    );
  }

  bool get isAuth {
    return _expiryDate.isAfter(DateTime.now());
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'_token': _token});
    result.addAll({'_expiryDate': _expiryDate.millisecondsSinceEpoch});
    result.addAll({'_userId': _userId});

    return result;
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      token: map['_token'] ?? '',
      expiryDate: DateTime.fromMillisecondsSinceEpoch(map['_expiryDate']),
      userId: map['_userId'] ?? '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthModel(_token: $_token, _expiryDate: $_expiryDate, _userId: $_userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthModel &&
        other._token == _token &&
        other._expiryDate == _expiryDate &&
        other._userId == _userId;
  }

  @override
  int get hashCode => _token.hashCode ^ _expiryDate.hashCode ^ _userId.hashCode;
}

class AuthRequest implements BaseModel {
  final String _email;
  final String _password;
  final bool _returnSecureToken;
  AuthRequest({
    required String email,
    required String password,
    bool? returnSecureToken,
  })  : _email = email,
        _password = password,
        _returnSecureToken =
            returnSecureToken != null ? returnSecureToken : true;

  AuthRequest copyWith({
    String? email,
    String? password,
    bool? returnSecureToken,
  }) {
    return AuthRequest(
      email: email ?? _email,
      password: password ?? _password,
      returnSecureToken: returnSecureToken ?? returnSecureToken,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'email': _email});
    result.addAll({'password': _password});
    result.addAll({'returnSecureToken': _returnSecureToken});

    return result;
  }

  factory AuthRequest.fromMap(Map<String, dynamic> map) {
    return AuthRequest(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      returnSecureToken: map['returnSecureToken'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AuthRequest.fromJson(String source) =>
      AuthRequest.fromMap(json.decode(source));

  @override
  String toString() =>
      'AuthRequest(_email: $_email, _password: $_password, _returnSecureToken: $_returnSecureToken)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthRequest &&
        other._email == _email &&
        other._password == _password &&
        other._returnSecureToken == _returnSecureToken;
  }

  @override
  int get hashCode =>
      _email.hashCode ^ _password.hashCode ^ _returnSecureToken.hashCode;
}
