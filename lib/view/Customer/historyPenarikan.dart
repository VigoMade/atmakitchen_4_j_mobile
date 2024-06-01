import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atmakitchen_4_j_mobile/model/penarikan.dart';
import 'package:atmakitchen_4_j_mobile/database/API/penarikan_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class HistoryPenarikanPage extends StatefulWidget {
  @override
  _HistoryPenarikanPageState createState() => _HistoryPenarikanPageState();
}

class _HistoryPenarikanPageState extends State<HistoryPenarikanPage> {
  int idCustomer = 0;
  ApiClient apiClient = ApiClient();
  List<Penarikan> _penarikanList = [];
  List<Penarikan> _filteredPenarikanList = [];
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
      idCustomer = sharedPrefs.getInt('id_customer') ?? 0;
    });
    _fetchPenarikanData();
  }

  Future<void> _fetchPenarikanData() async {
    try {
      PenarikanClient penarikanClient = PenarikanClient(apiClient);
      List<Penarikan> penarikanList =
          await penarikanClient.getHistoryPenarikanList(idCustomer);
      setState(() {
        _penarikanList = penarikanList;
        _filteredPenarikanList = _penarikanList;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching penarikan data: $error';
        _isLoading = false;
      });
    }
  }

  void _filterPenarikan(String query) {
    setState(() {
      _filteredPenarikanList = _penarikanList.where((penarikan) {
        return penarikan.namaCustomer
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History Penarikan'),
        backgroundColor: const Color(0xFFAD343E),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterPenarikan,
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
                    : _buildPenarikanList(),
          ),
        ],
      ),
    );
  }

  Widget _buildPenarikanList() {
    return ListView.builder(
      itemCount: _filteredPenarikanList.length,
      itemBuilder: (context, index) {
        final penarikan = _filteredPenarikanList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(10.0),
            leading: Icon(Icons.account_balance_wallet),
            title: Text(penarikan.namaCustomer),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bank: ${penarikan.namaBank}'),
                Text('Account No: ${penarikan.nomorRekening}'),
                Text('Amount: ${penarikan.totalPenarikan}'),
                Text('Status: ${penarikan.status}'),
                Text('Date: ${penarikan.tanggal}'),
              ],
            ),
          ),
        );
      },
    );
  }
}
