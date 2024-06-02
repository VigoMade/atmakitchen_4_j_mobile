import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:atmakitchen_4_j_mobile/model/pemakaian.dart';
import 'package:atmakitchen_4_j_mobile/database/API/pemakaian_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class PemakaianReportPage extends StatefulWidget {
  const PemakaianReportPage({Key? key}) : super(key: key);

  @override
  State<PemakaianReportPage> createState() => _PemakaianReportPageState();
}

class _PemakaianReportPageState extends State<PemakaianReportPage> {
  late DateTime _startDate;
  late DateTime _endDate;
  List<Pemakaian> _reportData = [];
  final PemakaianClient _pemakaianClient = PemakaianClient(ApiClient());

  @override
  void initState() {
    super.initState();
    _startDate = DateTime.now();
    _endDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Laporan Penggunaan Bahan Baku',
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
                  const Text('Periode Awal:'),
                  TextButton(
                    onPressed: () {
                      _selectStartDate(context);
                    },
                    child:
                        Text('${DateFormat('yyyy-MM-dd').format(_startDate)}'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Periode Akhir:'),
                  TextButton(
                    onPressed: () {
                      _selectEndDate(context);
                    },
                    child: Text('${DateFormat('yyyy-MM-dd').format(_endDate)}'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _fetchReportData();
                },
                child: const Text('Tampilkan Report'),
              ),
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
                                  'LAPORAN Penggunaan Bahan Baku',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Periode: ${DateFormat('yyyy-MM-dd').format(_startDate)} - ${DateFormat('yyyy-MM-dd').format(_endDate)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                  ),
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
                            border: TableBorder(
                                left: BorderSide.none,
                                right: BorderSide.none,
                                verticalInside: BorderSide(width: 1.0),
                                horizontalInside: BorderSide(width: 1.0),
                                top: BorderSide(width: 1.0)),
                            columns: const [
                              DataColumn(label: Text('Nama Bahan Baku')),
                              DataColumn(label: Text('Satuan')),
                              DataColumn(label: Text('Digunakan       ')),
                            ],
                            rows: _reportData
                                .map(
                                  (pemakaian) => DataRow(cells: [
                                    DataCell(
                                      Text(
                                        pemakaian.namaBahanBaku ?? '',
                                      ),
                                    ),
                                    DataCell(
                                      Text(pemakaian.satuan ?? ''),
                                    ),
                                    DataCell(
                                      Text(
                                        NumberFormat.decimalPattern()
                                            .format(
                                                pemakaian.totalPemakaian ?? 0)
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

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: DateTime(2015),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  Future<void> _fetchReportData() async {
    List<Pemakaian> fetchedData = await _pemakaianClient.getPemakaianList(
      _startDate,
      _endDate,
    );

    setState(() {
      _reportData = fetchedData;
    });

    if (_reportData.isEmpty) {
      // Menampilkan teks "Laporan pada periode ini tidak ada" jika data laporan kosong
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Info'),
            content: Text('Laporan pada periode ini tidak ada'),
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
