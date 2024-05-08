import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/history.dart';
import 'package:atmakitchen_4_j_mobile/database/API/history_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class HistoryPage extends StatefulWidget {
  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  ApiClient apiClient = ApiClient();

  List<History> _historyList = [];
  List<History> _filteredHistoryList = [];

  void _fetchHistoryData() async {
    try {
      HistoryClient _historyClient = HistoryClient(apiClient);
      List<History> historyList = await _historyClient.getHistoryList();
      setState(() {
        _historyList = historyList;
        _filteredHistoryList = _historyList;
      });
    } catch (error) {
      print('Error fetching history data: $error');
    }
  }

  void _fetchHistorySearch(String query) async {
    try {
      HistoryClient _historyClient = HistoryClient(apiClient);
      List<History> historyList = await _historyClient.searchHistory(query);
      setState(() {
        _historyList = historyList;
        _filteredHistoryList = _historyList;
      });
    } catch (error) {
      print('Error fetching Search data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchHistoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
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
              ),
            ),
          ),
          Expanded(
            child: _buildHistoryTable(),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryTable() {
    return DataTable(
      columns: [
        DataColumn(label: Text('Product')),
        DataColumn(label: Text('Photo')),
        DataColumn(label: Text('Status')),
      ],
      rows: _filteredHistoryList.map((history) {
        return DataRow(cells: [
          DataCell(Text(history.namaProduk ?? '')),
          DataCell(
            history.fotoProduk == null
                ? Text('')
                : ClipRRect(
                    child: Image.network(
                      "http://10.0.2.2:8000/images/${history.fotoProduk}",
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
          DataCell(history.statusPesanan == "pending"
              ? Text(
                  history.statusPesanan!,
                  style: TextStyle(color: Color.fromARGB(255, 67, 65, 65)),
                )
              : Text(history.statusPesanan!,
                  style: TextStyle(color: Colors.blue))),
        ]);
      }).toList(),
    );
  }

  void _filterHistory(String query) {
    setState(() {
      _filteredHistoryList = _historyList
          .where((history) =>
              history.namaProduk!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
