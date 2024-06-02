import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:atmakitchen_4_j_mobile/model/pemasukan.dart';
import 'package:atmakitchen_4_j_mobile/model/pengeluaran.dart';
import 'package:atmakitchen_4_j_mobile/database/api/ReportPP_data.dart';
import 'package:atmakitchen_4_j_mobile/database/api/api_client.dart';

class PpReportPage extends StatefulWidget {
  const PpReportPage({Key? key}) : super(key: key);

  @override
  _PpReportPageState createState() => _PpReportPageState();
}

class _PpReportPageState extends State<PpReportPage> {
  @override
  void initState() {
    super.initState();
  }

  String bulan = DateFormat('MMMM').format(DateTime.now());
  Map<String, dynamic> _reportData = {};
  final PpReportClient _ppReportClient = PpReportClient(ApiClient());

  int totalPemasukan = 0;
  int totalPengeluaran = 0;
  int totalBahanBaku = 0;

  final NumberFormat currencyFormat = NumberFormat('#,##0', 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Pemasukan dan Pengeluaran',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Bulan:'),
                  DropdownButton<String>(
                    value: bulan,
                    onChanged: (String? newValue) {
                      setState(() {
                        bulan = newValue!;
                      });
                    },
                    items: <String>[
                      'January',
                      'February',
                      'March',
                      'April',
                      'May',
                      'June',
                      'July',
                      'August',
                      'September',
                      'October',
                      'November',
                      'December'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _fetchReportData(bulan);
                },
                child: const Text('Tampilkan Report'),
              ),
              SizedBox(height: 16),
              _buildDataRows().isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(
                            color: const Color.fromARGB(255, 0, 0, 0)),
                      ),
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
                                  style: TextStyle(fontSize: 15),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  'LAPORAN PEMASUKAN dan PENGELUARAN',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Bulan: $bulan',
                                  style: TextStyle(fontSize: 15),
                                ),
                                Text(
                                  'Tanggal Cetak : ${DateFormat('dd MMMM yyyy').format(DateTime.now())}',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          DataTable(
                            dataRowHeight: 70,
                            border: TableBorder(
                                left: BorderSide.none,
                                right: BorderSide.none,
                                verticalInside: BorderSide(width: 1.0),
                                horizontalInside: BorderSide(width: 1.0),
                                top: BorderSide(width: 1.0),
                                bottom: BorderSide(width: 1.0)),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: SizedBox(
                                  width: 80,
                                  child: Text(
                                    'Nama Bahan',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Pemasukan',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Pengeluaran',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                            rows: _buildDataRows(),
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text('Laporan pada bulan ini tidak ada'),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _fetchReportData(String bulan) async {
    Map<String, dynamic> reportData =
        await _ppReportClient.getMonthlyReport(bulan);
    setState(() {
      _reportData = reportData;
      totalPemasukan = _calculateTotalPemasukan(_reportData['pemasukan']);
      totalPengeluaran = _calculateTotalPengeluaran(_reportData['pengeluaran']);
    });
    totalBahanBaku = await _ppReportClient.getBahanBaku(bulan);
  }

  List<DataRow> _buildDataRows() {
    List<DataRow> rows = [];

    if (_reportData['pemasukan'] is Pemasukan &&
        (_reportData['pemasukan'] as Pemasukan).totalPemasukan != 0) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text("Penjualan")),
          DataCell(Text(currencyFormat
              .format((_reportData['pemasukan'] as Pemasukan).totalPemasukan))),
          DataCell(Text('0')),
        ],
      ));
    }
    if (_reportData['pemasukan'] is Pemasukan &&
        (_reportData['pemasukan'] as Pemasukan).tip != 0) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text("Tip")),
          DataCell(Text(currencyFormat
              .format((_reportData['pemasukan'] as Pemasukan).tip))),
          DataCell(Text('0')),
        ],
      ));
    }

    if (_reportData['pengeluaran'] is List<PengeluaranLainnya>) {
      rows.addAll((_reportData['pengeluaran'] as List<PengeluaranLainnya>)
          .map((pengeluaran) {
        return DataRow(
          cells: <DataCell>[
            DataCell(Text(pengeluaran.namaPengeluaran)),
            DataCell(Text('0')),
            DataCell(Text(currencyFormat.format(pengeluaran.biayaPengeluaran))),
          ],
        );
      }).toList());
    }

    if (totalBahanBaku != 0) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text('Bahan Baku')),
          DataCell(Text('0')),
          DataCell(Text(currencyFormat.format(totalBahanBaku))),
        ],
      ));
    }

    if (totalPemasukan != 0 || totalPengeluaran != 0) {
      rows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          DataCell(Text(currencyFormat.format(totalPemasukan),
              style: TextStyle(fontWeight: FontWeight.bold))),
          DataCell(Text(currencyFormat.format(totalPengeluaran),
              style: TextStyle(fontWeight: FontWeight.bold))),
        ],
      ));
    }

    return rows;
  }

  int _calculateTotalPemasukan(dynamic pemasukanData) {
    if (pemasukanData is List<Pemasukan>) {
      int total = 0;
      for (var pemasukan in pemasukanData) {
        total = pemasukan.totalPemasukan + pemasukan.tip;
      }
      return total;
    } else if (pemasukanData is Pemasukan) {
      return pemasukanData.totalPemasukan + pemasukanData.tip;
    } else {
      return 0;
    }
  }

  int _calculateTotalPengeluaran(dynamic pengeluaranData) {
    if (pengeluaranData is List<PengeluaranLainnya>) {
      int total = 0;
      for (var pengeluaran in pengeluaranData) {
        total += pengeluaran.biayaPengeluaran;
      }
      return total;
    } else {
      return 0;
    }
  }
}
