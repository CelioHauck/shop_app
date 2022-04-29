import 'package:shop_app/infra/ihttp_service.dart';
import 'package:shop_app/models/auth_model.dart';

const key = 'AIzaSyDmpcEjXPKkK7tOL6FHsli8WzN7iBoAX6I';

class AuthRepository {
  final IHttpService _client;

  const AuthRepository({required IHttpService client}) : _client = client;

  Future<void> _autenticate(
      String email, String password, String urlSegment) async {
    await _client.post(
      AuthRequest(email: email, password: password),
      path: '$urlSegment?key=$key',
    );
  }

  Future<void> signup(String email, String password) async {
    return _autenticate(email, password, 'signUp');
  }

  Future<void> sing(String email, String password) async {
    return _autenticate(email, password, 'signInWithPassword');
  }
}
