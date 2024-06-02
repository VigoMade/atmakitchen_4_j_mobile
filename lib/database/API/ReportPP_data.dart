import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/pemasukan.dart';
import 'package:atmakitchen_4_j_mobile/model/pengeluaran.dart'; // Assuming you have a PengeluaranLainnya model
import 'package:atmakitchen_4_j_mobile/database/api/api_client.dart';

class PpReportClient {
  ApiClient apiClient = ApiClient();

  PpReportClient(this.apiClient);

  Future<Map<String, dynamic>> getMonthlyReport(String month) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/report/$month');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          // Map<String, dynamic> reportData = {};
          Map<String, dynamic> reportData = {
            'pemasukan': Pemasukan.fromJson(jsonData['data']['pemasukan']),
            'pengeluaran': (jsonData['data']['pengeluaran'] as List)
                .map((data) => PengeluaranLainnya.fromJson(data))
                .toList(),
          };

          return reportData;
        } else {
          throw ('Failed to load monthly report: ${jsonData['message']}');
        }
      } else {
        throw ('Failed to load monthly report: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }

  Future<int> getBahanBaku(String month) async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/report/$month/bb');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData['success']) {
          return int.parse(jsonData['data']['total_bahan_baku'].toString());
        } else {
          throw ('Failed to load total raw material purchase: ${jsonData['message']}');
        }
      } else {
        throw ('Failed to load total raw material purchase: ${response.statusCode}');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
