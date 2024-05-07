import 'package:atmakitchen_4_j_mobile/model/presensi.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class PresensiClient {
  ApiClient apiClient = ApiClient();

  PresensiClient(this.apiClient);

  Future<List<Presensi>> getPresensiList() async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/presensi');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<Presensi> presensiList =
              jsonData.map((data) => Presensi.fromJson(data)).toList();
          return presensiList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<Presensi> presensiList = (jsonData['data'] as List)
              .map((data) => Presensi.fromJson(data))
              .toList();
          return presensiList;
        } else {
          throw ('Failed to load presensi list');
        }
      } else {
        throw ('Failed to load presensi list');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<void> updatePresensi(Presensi presensi) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/presensi/${presensi.idPresensi}');

    try {
      var response = await client
          .put(
            uri,
            body: presensi.toJson(),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 200) {
        throw ('Failed to update presensi ${presensi.idPresensi}');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<List<Presensi>> getPresensiListByDate(DateTime selectedDate) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/presensi');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<Presensi> presensiList = jsonData
              .map((data) => Presensi.fromJson(data))
              .where((presensi) =>
                  presensi.tanggalPresensi!.year == selectedDate.year &&
                  presensi.tanggalPresensi!.month == selectedDate.month &&
                  presensi.tanggalPresensi!.day == selectedDate.day)
              .toList();
          return presensiList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<Presensi> presensiList = (jsonData['data'] as List)
              .map((data) => Presensi.fromJson(data))
              .where((presensi) =>
                  presensi.tanggalPresensi!.year == selectedDate.year &&
                  presensi.tanggalPresensi!.month == selectedDate.month &&
                  presensi.tanggalPresensi!.day == selectedDate.day)
              .toList();
          return presensiList;
        } else {
          throw ('Failed to load presensi list');
        }
      } else {
        throw ('Failed to load presensi list');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<void> createPresensi(Presensi presensi) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/presensi');

    try {
      var response = await client
          .post(
            uri,
            body: presensi.toJson(),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode != 201) {
        throw ('Failed to create new presensi');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
