import 'package:atmakitchen_4_j_mobile/database/API/auth_client.dart';

import '../model/user.dart';

class FailedLogin implements Exception {
  String errorMessage() {
    return "Login Failed";
  }
}

class LoginRepository {
  AuthClient authClient = AuthClient();

  Future<User> login(String username, String password) async {
    try {
      User userData = await authClient.loginUser(username, password);
      return userData;
    } catch (e) {
      rethrow;
    }
  }
}
