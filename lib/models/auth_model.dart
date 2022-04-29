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

  String? get token {
    if (isAuth) return _token;
    return null;
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

class AuthResponse implements BaseModel {
  final String kind;
  final String idToken;
  final String email;
  final String refreshToken;
  final String expiresIn;
  final String localId;
  final bool registered;

  AuthResponse({
    required this.kind,
    required this.idToken,
    required this.email,
    required this.refreshToken,
    required this.expiresIn,
    required this.localId,
    required this.registered,
  });

  AuthResponse copyWith({
    String? kind,
    String? idToken,
    String? email,
    String? refreshToken,
    String? expiresIn,
    String? localId,
    bool? registered,
  }) {
    return AuthResponse(
      kind: kind ?? this.kind,
      idToken: idToken ?? this.idToken,
      email: email ?? this.email,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
      localId: localId ?? this.localId,
      registered: registered ?? this.registered,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'kind': kind});
    result.addAll({'idToken': idToken});
    result.addAll({'email': email});
    result.addAll({'refreshToken': refreshToken});
    result.addAll({'expiresIn': expiresIn});
    result.addAll({'localId': localId});
    result.addAll({'registered': registered});

    return result;
  }

  factory AuthResponse.fromMap(Map<String, dynamic> map) {
    return AuthResponse(
      kind: map['kind'] ?? '',
      idToken: map['idToken'] ?? '',
      email: map['email'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn'] ?? '',
      localId: map['localId'] ?? '',
      registered: map['registered'] ?? false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory AuthResponse.fromJson(String source) =>
      AuthResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'AuthResponse(kind: $kind, idToken: $idToken, email: $email, refreshToken: $refreshToken, expiresIn: $expiresIn, localId: $localId, registered: $registered)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthResponse &&
        other.kind == kind &&
        other.idToken == idToken &&
        other.email == email &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn &&
        other.localId == localId &&
        other.registered == registered;
  }

  @override
  int get hashCode {
    return kind.hashCode ^
        idToken.hashCode ^
        email.hashCode ^
        refreshToken.hashCode ^
        expiresIn.hashCode ^
        localId.hashCode ^
        registered.hashCode;
  }
}
