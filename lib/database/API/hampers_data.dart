import 'package:atmakitchen_4_j_mobile/model/hampers.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class HampersClient {
  ApiClient apiClient = ApiClient();

  HampersClient(this.apiClient);

  Future<List<Hampers>> getHampersList() async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/hampers');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Hampers> hampersList = [];

        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Hampers
          hampersList = jsonData.map((data) => Hampers.fromJson(data)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          hampersList = (jsonData['data'] as List)
              .map((data) => Hampers.fromJson(data))
              .toList();
        } else {
          throw ('Failed to load Hampers list');
        }

        return hampersList;
      } else {
        throw ('Failed to load Hampers list error');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
