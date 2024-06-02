import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:atmakitchen_4_j_mobile/model/pemakaian.dart'; // Import the Pemakaian model
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart'; // Import the ApiClient

class PemakaianClient {
  ApiClient apiClient;

  PemakaianClient(this.apiClient);

  Future<List<Pemakaian>> getPemakaianList(
      DateTime startDate, DateTime endDate) async {
    // Extract date part from startDate and endDate
    String startDateStr =
        '${startDate.year}-${startDate.month}-${startDate.day}';
    String endDateStr = '${endDate.year}-${endDate.month}-${endDate.day}';

    var client = http.Client();
    Uri uri = Uri.parse(
        '${apiClient.baseUrl}/pemakaianBB/${startDateStr}/${endDateStr}');

    try {
      var response = await client.get(uri).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          // Jika respons adalah List, maka langsung parse ke Presensi
          List<Pemakaian> pemakaianList =
              jsonData.map((data) => Pemakaian.fromJson(data)).toList();
          return pemakaianList;
        } else if (jsonData is Map && jsonData.containsKey('data')) {
          // Jika respons adalah Map dan memiliki kunci 'data', maka ambil data dari 'data'
          if (jsonData['data'] == null) {
            return []; // Return empty list if jsonData is empty
          }
          List<Pemakaian> pemakaianList = (jsonData['data'] as List)
              .map((data) => Pemakaian.fromJson(data))
              .toList();
          return pemakaianList;
        } else {
          throw ('Failed to load Pemakaian list ${response.statusCode}');
        }
      } else {
        return []; // Return empty list if no data is available
      }
    } on TimeoutException catch (_) {
      throw ('Take too long, please check your connection');
    } finally {
      client.close();
    }
  }
}
