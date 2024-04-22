import 'package:atmakitchen_4_j_mobile/model/user.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class AuthClient {
  ApiClient apiClient = ApiClient();

  Future<User> loginUser(String username, String password) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/login');

    try {
      var response = await client.post(
        uri,
        body: {
          'username': username,
          'password': password,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var json = response.body;
        var jsonData = jsonDecode(json);

        var userJson = jsonData['customer'];
        String token = jsonData['access_token'];
        User user = User.fromJson(userJson);
        user.token = token;
        return user;
      } else {
        var json = response.body;
        var jsonData = jsonDecode(json);
        throw (jsonData['error'] ?? 'Login Failed');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future forgotPassword(String email) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/reset');

    try {
      var response = await client.post(
        uri,
        body: {
          'email': email,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var json = response.body;
        var jsonData = jsonDecode(json);
        return jsonData['message'];
      } else {
        var json = response.body;
        var jsonData = jsonDecode(json);
        throw (jsonData['error'] ?? 'Email Invalid ');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
