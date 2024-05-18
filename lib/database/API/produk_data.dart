import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/produk.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class ProdukClient {
  ApiClient apiClient = ApiClient();

  ProdukClient(this.apiClient);

  Future<List<Produk>> getProdukList(String title) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/produk/${title}');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Produk> produkList = [];

        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Produk
          produkList = jsonData.map((data) => Produk.fromJson(data)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          produkList = (jsonData['data'] as List)
              .map((data) => Produk.fromJson(data))
              .toList();
        } else {
          throw ('Failed to load Produk list');
        }

        return produkList;
      } else {
        throw ('Failed to load Produk list error');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<List<Produk>> getProdukSpecial() async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/produks');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Produk> produkList = [];

        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Produk
          produkList = jsonData.map((data) => Produk.fromJson(data)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          produkList = (jsonData['data'] as List)
              .map((data) => Produk.fromJson(data))
              .toList();
        } else {
          throw ('Failed to load Produk list');
        }

        return produkList;
      } else {
        throw ('Failed to load Produk list error tes');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
