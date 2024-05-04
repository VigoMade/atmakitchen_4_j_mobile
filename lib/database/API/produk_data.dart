import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/produk.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class ProdukClient {
  ApiClient apiClient = ApiClient();

  ProdukClient(this.apiClient);

  Future<List<Produk>> getProdukList() async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/produk');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<Produk> produkList =
              jsonData.map((data) => Produk.fromJson(data)).toList();
          return produkList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<Produk> produkList = (jsonData['data'] as List)
              .map((data) => Produk.fromJson(data))
              .toList();
          return produkList;
        } else {
          throw ('Failed to load Produk list');
        }
      } else {
        throw ('Failed to load Produkk list');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
