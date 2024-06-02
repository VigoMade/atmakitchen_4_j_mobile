import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/bahan_baku.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class BahanBakuClient {
  ApiClient apiClient = ApiClient();

  BahanBakuClient(this.apiClient);

  Future<List<BahanBaku>> getBahanBakuList() async {
    var client = http.Client();
    Uri uri = Uri.parse('${apiClient.baseUrl}/stock');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);
        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<BahanBaku> bahanBakuList =
              jsonData.map((data) => BahanBaku.fromJson(data)).toList();
          return bahanBakuList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          List<BahanBaku> bahanBakuList = (jsonData['data'] as List)
              .map((data) => BahanBaku.fromJson(data))
              .toList();
          return bahanBakuList;
        } else {
          throw ('Failed to load BahanBaku list');
        }
      } else {
        throw ('Failed to load BahanBaku list');
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
