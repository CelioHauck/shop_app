import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/models/auth_model.dart';
import 'package:shop_app/repository/auth.repository.dart';

import '../infra/ihttp_service.dart';

class AuthProvider with ChangeNotifier {
  AuthModel? _auth;
  Timer? _authTimer;

  final AuthRepository _service;

  bool get isAuth {
    return _auth != null && _auth!.isAuth;
  }

  String? get token {
    if (isAuth) {
      return _auth?.token;
    }
    return null;
  }

  AuthModel? get authInfo {
    if (_auth != null) return _auth!.copyWith();
    return null;
  }

  AuthProvider({required IHttpService service})
      : _service = AuthRepository(client: service);

  Future<void> _saveAuth(AuthResponse response) async {
    _auth = AuthModel(
      token: response.idToken,
      expiryDate: DateTime.now().add(
        Duration(
          seconds: int.parse(response.expiresIn),
        ),
      ),
      userId: response.localId,
    );
    _autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('userData', _auth!.toJson());
  }

  Future<void> signup(String email, String password) async {
    final response = await _service.signup(email, password);
    await _saveAuth(response);
  }

  Future<void> sing(String email, String password) async {
    final response = await _service.sing(email, password);
    await _saveAuth(response);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = AuthModel.fromJson(prefs.getString('userData')!);

    if (!extractedUserData.isAuth) {
      return false;
    }
    _auth = extractedUserData.copyWith();
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _auth = null;
    if (_authTimer != null) {
      _authTimer?.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer?.cancel();
    }
    _authTimer = Timer(
      Duration(seconds: _auth!.timeToExpiry),
      () => logout(),
    );
  }
}
