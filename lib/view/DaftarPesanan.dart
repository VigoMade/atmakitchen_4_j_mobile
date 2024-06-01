import 'package:atmakitchen_4_j_mobile/model/pesanan.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/database/API/daftarPesanan_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PesananPage extends StatefulWidget {
  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int id_customer = 0;
  ApiClient apiClient = ApiClient();

  List<Pesanan> _pesananList = [];
  List<Pesanan> _filteredPesananList = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      id_customer = sharedPrefs.getInt('id_customer') ?? 0;
    });
    _fetchPesananData();
  }

  Future<void> _fetchPesananData() async {
    try {
      PesananClient _pesananClient = PesananClient(apiClient);
      List<Pesanan> pesananList =
          await _pesananClient.getPesananList(id_customer);
      setState(() {
        _pesananList = pesananList;
        _filteredPesananList = _pesananList;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching Pesanan data: $error';
        _isLoading = false;
      });
    }
  }

  void _filterPesanan(String query) {
    setState(() {
      _filteredPesananList = _pesananList
          .where((history) =>
              history.namaProduk?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  Future<void> _updatePesananStatus(String id_transaksi) async {
    try {
      PesananClient _pesananClient = PesananClient(apiClient);
      bool success = await _pesananClient.updatePesananStatus(id_transaksi);
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Pesanan berhasil diperbarui menjadi selesai'),
            backgroundColor: const Color.fromARGB(
                255, 27, 130, 215), // Set the background color to blue
          ),
        );
        _fetchPesananData(); // Refresh the data
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating Pesanan status: $error'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan'),
        backgroundColor: const Color(0xFFAD343E),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterPesanan,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage.isNotEmpty
                    ? Center(child: Text(_errorMessage))
                    : _buildPesananList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPesananList() {
    return SingleChildScrollView(
      child: Column(
        children: _filteredPesananList.map((pesanan) {
          return Card(
            margin: EdgeInsets.all(8.0),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: ListTile(
              contentPadding: EdgeInsets.all(10.0),
              leading: pesanan.fotoProduk == null
                  ? Icon(Icons.image_not_supported)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: Image.network(
                        "http://10.0.2.2:8000/storage/${pesanan.fotoProduk}",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                      ),
                    ),
              title: Text(pesanan.namaProduk ?? ''),
              subtitle: Text(
                pesanan.statusPesanan ?? '',
                style: TextStyle(
                  color: pesanan.statusPesanan == "Sudah dipickup"
                      ? Color.fromARGB(255, 33, 97, 208)
                      : Color.fromARGB(255, 47, 158, 55),
                ),
              ),
              trailing: pesanan.statusPesanan == "Sudah dipickup"
                  ? TextButton(
                      onPressed: () =>
                          _updatePesananStatus(pesanan.idTransaksi!),
                      child: Text(
                        'Pesanan Diterima',
                        style: TextStyle(color: Colors.green),
                      ),
                    )
                  : null,
            ),
          );
        }).toList(),
      ),
    );
  }
}
