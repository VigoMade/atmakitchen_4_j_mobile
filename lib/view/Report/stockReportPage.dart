import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:atmakitchen_4_j_mobile/model/bahan_baku.dart';
import 'package:atmakitchen_4_j_mobile/database/API/bahanBaku_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class StockReportPage extends StatefulWidget {
  const StockReportPage({super.key});

  @override
  State<StockReportPage> createState() => _StockReportPageState();
}

class _StockReportPageState extends State<StockReportPage> {
  List<BahanBaku> _reportData = [];
  final BahanBakuClient _bahanBakuClient = BahanBakuClient(ApiClient());

  @override
  void initState() {
    super.initState();
    _fetchReportData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Stock Bahan Baku',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        backgroundColor: const Color(0xFFAD343E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              _reportData.isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Atma Kitchen',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Jl. Centralpark No. 10 Yogyakarta',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'LAPORAN Stock Bahan Baku',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Tanggal Cetak : ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                                  style: TextStyle(
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          DataTable(
                            dataRowHeight: 30,
                            columnSpacing: 71,
                            border: TableBorder(
                                left: BorderSide.none,
                                right: BorderSide.none,
                                verticalInside: BorderSide(width: 1.0),
                                horizontalInside: BorderSide(width: 1.0),
                                top: BorderSide(width: 1.0)),
                            columns: const [
                              DataColumn(label: Text('Nama Bahan Baku')),
                              DataColumn(label: Text('Satuan')),
                              DataColumn(label: Text('Stock       ')),
                            ],
                            rows: _reportData
                                .map(
                                  (bahanaBaku) => DataRow(cells: [
                                    DataCell(
                                      Text(
                                        bahanaBaku.nama,
                                      ),
                                    ),
                                    DataCell(
                                      Text(bahanaBaku.satuan),
                                    ),
                                    DataCell(
                                      Text(
                                        NumberFormat.decimalPattern()
                                            .format(bahanaBaku.takaran)
                                            .replaceAll(',', '.'),
                                      ),
                                    ),
                                  ]),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text('Laporan pada periode ini tidak ada'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchReportData() async {
    try {
      List<BahanBaku> fetchedData = await _bahanBakuClient.getBahanBakuList();
      print(fetchedData);
      setState(() {
        _reportData = fetchedData;
      });
    } catch (error) {
      // Tangani kesalahan di sini
      print('Error fetching data: $error');
      // Tampilkan pesan kesalahan kepada pengguna jika diperlukan
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch Bahan Baku data: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
