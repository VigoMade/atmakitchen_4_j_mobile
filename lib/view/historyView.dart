import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/history.dart';
import 'package:atmakitchen_4_j_mobile/database/API/history_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int id_customer = 0;
  ApiClient apiClient = ApiClient();

  List<History> _historyList = [];
  List<History> _filteredHistoryList = [];
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
    _fetchHistoryData();
  }

  Future<void> _fetchHistoryData() async {
    try {
      HistoryClient _historyClient = HistoryClient(apiClient);
      List<History> historyList =
          await _historyClient.getHistoryList(id_customer);
      setState(() {
        _historyList = historyList;
        _filteredHistoryList = _historyList;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'Error fetching history data: $error';
        _isLoading = false;
      });
    }
  }

  void _filterHistory(String query) {
    setState(() {
      _filteredHistoryList = _historyList
          .where((history) =>
              history.namaProduk?.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: const Color(0xFFAD343E),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterHistory,
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
                    : _buildHistoryList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList() {
    return ListView.builder(
      itemCount: _filteredHistoryList.length,
      itemBuilder: (context, index) {
        final history = _filteredHistoryList[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.all(10.0),
            leading: history.fotoProduk == null
                ? Icon(Icons.image_not_supported)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(4.0),
                    child: Image.network(
                      "http://10.0.2.2:8000/images/${history.fotoProduk}",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.error),
                    ),
                  ),
            title: Text(history.namaProduk ?? ''),
            subtitle: Text(
              history.statusPesanan ?? '',
              style: TextStyle(
                color: history.statusPesanan == "pending"
                    ? Colors.grey
                    : Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }
}
