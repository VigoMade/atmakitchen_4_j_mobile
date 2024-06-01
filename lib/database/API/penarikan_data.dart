import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/penarikan.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/model/rekening.dart';

class PenarikanClient {
  ApiClient apiClient = ApiClient();

  PenarikanClient(this.apiClient);

  Future<List<Penarikan>> getHistoryPenarikanList(int id_customer) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/penarikan/$id_customer');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Penarikan
          List<Penarikan> penarikanList =
              jsonData.map((data) => Penarikan.fromJson(data)).toList();
          return penarikanList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<Penarikan> penarikanList = (jsonData['data'] as List)
              .map((data) => Penarikan.fromJson(data))
              .toList();
          return penarikanList;
        } else {
          throw ('Failed to load Penarikan list ${response.statusCode}');
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

  Future<List<Rekening>> getRekeningList(int id_customer) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/penarikan/${id_customer}/create');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        List<Rekening> rekeningList = [];

        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Produk
          rekeningList =
              jsonData.map((data) => Rekening.fromJson(data)).toList();
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          rekeningList = (jsonData['data'] as List)
              .map((data) => Rekening.fromJson(data))
              .toList();
        } else {
          throw ('Failed to load Rekening list');
        }

        return rekeningList;
      } else {
        throw ('Failed to load Rekening list error');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<bool> createPenarikanSaldo(
      int idCustomer, Map<String, dynamic> data) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/penarikan/$idCustomer/store');

    try {
      var response = await client
          .post(
            uri,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode(data),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return true; // Berhasil membuat permintaan penarikan saldo
      } else {
        throw ('Failed to create Penarikan Saldo');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<int> getSaldo(int idCustomer) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/penarikan/$idCustomer/saldo');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        int saldo = jsonData[
            'saldo']; // Anggap 'saldo' adalah nama properti untuk saldo dalam respons JSON
        return saldo;
      } else {
        throw ('Failed to get saldo');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
