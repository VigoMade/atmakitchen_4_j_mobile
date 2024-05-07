import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/history.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class HistoryClient {
  ApiClient apiClient = ApiClient();

  HistoryClient(this.apiClient);

  Future<List<History>> getHistoryList() async {
    var client = http.Client();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/history');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<History> historyList =
              jsonData.map((data) => History.fromJson(data)).toList();
          return historyList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<History> historyList = (jsonData['data'] as List)
              .map((data) => History.fromJson(data))
              .toList();
          return historyList;
        } else {
          throw ('Failed to load History list');
        }
      } else {
        throw ('Failed to load History list');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<List<History>> searchHistory(String query) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/history/${query}');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<History> historyList =
              jsonData.map((data) => History.fromJson(data)).toList();
          return historyList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<History> historyList = (jsonData['data'] as List)
              .map((data) => History.fromJson(data))
              .toList();
          return historyList;
        } else {
          throw ('Failed to search History');
        }
      } else {
        throw ('Failed to search History');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
