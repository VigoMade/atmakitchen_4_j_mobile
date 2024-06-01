import 'package:atmakitchen_4_j_mobile/model/pesanan.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class PesananClient {
  ApiClient apiClient = ApiClient();

  PesananClient(this.apiClient);

  Future<List<Pesanan>> getPesananList(int id_customer) async {
    var client = http.Client();
    Uri uri = Uri.parse('http://10.0.2.2:8000/api/pesanan/${id_customer}');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Pesanan
          List<Pesanan> pesananList =
              jsonData.map((data) => Pesanan.fromJson(data)).toList();
          return pesananList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<Pesanan> pesananList = (jsonData['data'] as List)
              .map((data) => Pesanan.fromJson(data))
              .toList();
          return pesananList;
        } else {
          throw ('Failed to load Pesanan list ${response.statusCode}');
        }
      } else {
        return [];
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  // Tambahkan metode untuk mengupdate status pesanan
  Future<bool> updatePesananStatus(String id_transaksi) async {
    var client = http.Client();
    Uri uri =
        Uri.parse('http://10.0.2.2:8000/api/pesanan/$id_transaksi/selesai');

    try {
      var response = await client.put(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return true; // Berhasil mengupdate status
      } else {
        throw ('Failed to update Pesanan status');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
