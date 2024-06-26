import 'package:atmakitchen_4_j_mobile/firebase_options.dart';
import 'package:atmakitchen_4_j_mobile/model/user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class AuthClient {
  ApiClient apiClient = ApiClient();

  Future<User> loginUser(String username, String password) async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final String? token = await FirebaseMessaging.instance.getToken();
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/login');

    try {
      var response = await client.post(
        uri,
        body: {
          'username': username,
          'password': password,
          'device_key': token, // Include the device key in the request body
        },
      ).timeout(const Duration(seconds: 20));

      if (response.statusCode == 200) {
        var json = response.body;
        var jsonData = jsonDecode(json);

        if (jsonData.containsKey('user') &&
            jsonData.containsKey('role') &&
            jsonData.containsKey('token')) {
          var userJson = jsonData['user'];
          String role = jsonData['role'];
          int customer = jsonData['id_customer'];
          String token = jsonData['token'];
          String email = jsonData['email'];
          String noTelpon = jsonData['noTelpon'];
          String nama = jsonData['nama'];
          String image = jsonData['image'];

          if (userJson != null) {
            User user = User.fromJson(userJson);

            user.idCustomer = customer;
            user.role = role;
            user.token = token;
            user.email = email;
            user.noTelpon = noTelpon;
            user.nama = nama;
            user.image = image;

            return user;
          } else {
            throw ('Data pengguna tidak valid');
          }
        } else {
          throw ('Struktur respons tidak valid');
        }
      } else {
        var json = response.body;
        var jsonData = jsonDecode(json);
        throw (jsonData['error'] ?? 'Login Gagal');
      }
    } on TimeoutException catch (_) {
      throw ('Waktu terlalu lama, harap periksa koneksi Anda');
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
        throw (jsonData['error'] ?? 'Email Invalid');
      }
    } on TimeoutException catch (_) {
      throw ('Waktu terlalu lama, harap periksa koneksi Anda');
    } finally {
      client.close();
    }
  }
}
