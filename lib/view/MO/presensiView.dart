import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl di sini
import 'package:atmakitchen_4_j_mobile/model/presensi.dart';
import 'package:atmakitchen_4_j_mobile/view/MO/presensi.dart';
import 'package:atmakitchen_4_j_mobile/view/MO/createPresensi.dart';
import 'package:atmakitchen_4_j_mobile/database/API/presensi_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class presensiView extends StatefulWidget {
  const presensiView({Key? key}) : super(key: key);

  @override
  State<presensiView> createState() => _presensiViewState();
}

class _presensiViewState extends State<presensiView> {
  ApiClient apiClient = ApiClient();
  List<Presensi> _presensiList = [];
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _fetchPresensi();
  }

  Future<void> _fetchPresensi() async {
    try {
      PresensiClient presensiClient = PresensiClient(apiClient);
      List<Presensi> presensiList = await presensiClient.getPresensiList();
      setState(() {
        // Mengurutkan tanggal dari yang terkecil
        _presensiList = presensiList
          ..sort((a, b) => a.tanggalPresensi!.compareTo(b.tanggalPresensi!));
      });
    } catch (e) {
      // Menampilkan pesan kesalahan jika gagal mengambil data presensi
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load presensi: $e'),
        ),
      );
    }
  }

  List<DataColumn> _buildDateColumns(List<DateTime?> uniqueDates) {
    List<DateTime> validDates = uniqueDates.whereType<DateTime>().toList();
    return validDates
        .map((date) =>
            DataColumn(label: Text(_formatDate(date!)))) // Memformat tanggal
        .toList();
  }

  List<DataCell> _buildDateCells(
      List<DateTime?> uniqueDates, Presensi presensi) {
    List<DateTime> validDates = uniqueDates.whereType<DateTime>().toList();
    List<DataCell> cells = [];
    for (var date in validDates) {
      // Mencari presensi sesuai dengan tanggal yang cocok
      var presensiItem = _presensiList.firstWhere(
        (item) =>
            item.namapegawai == presensi.namapegawai &&
            item.tanggalPresensi == date,
        orElse: () => Presensi(
            namapegawai: presensi.namapegawai,
            tanggalPresensi: date,
            statusPresensi: ''),
      );
      cells.add(
        DataCell(
          Text(
            presensiItem
                .statusPresensi!, // Gunakan status presensi jika sudah ada
            style: TextStyle(
              color: presensiItem.statusPresensi == 'Hadir'
                  ? Colors.blue
                  : Colors.red,
            ),
          ),
        ),
      );
    }
    return cells;
  }

  String _formatDate(DateTime date) {
    // Menggunakan DateFormat untuk memformat tanggal tanpa jam
    return DateFormat('dd-MM-yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    // Membuat daftar tanggal unik
    var uniqueDates = _presensiList
        .map((presensi) => presensi.tanggalPresensi)
        .toSet()
        .toList();

    // Membuat daftar nama pegawai unik
    var uniqueEmployees =
        _presensiList.map((presensi) => presensi.namapegawai).toSet().toList();

    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: Center(
              child: Text(
                'Presensi',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal, // Mengizinkan scroll horizontal
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Nama Pegawai',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ..._buildDateColumns(
                    uniqueDates), // Membuat kolom untuk setiap tanggal
              ],
              rows: uniqueEmployees.map((employee) {
                // Membuat baris untuk setiap nama pegawai
                var presensiForEmployee = _presensiList
                    .where((presensi) => presensi.namapegawai == employee)
                    .toList();
                return DataRow(cells: [
                  DataCell(Text(employee!)),
                  ..._buildDateCells(uniqueDates, presensiForEmployee.first),
                ]);
              }).toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PresensiPage()),
                  );
                },
                child: Text('Update Presensi'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreatePresensiPage()),
                  );
                },
                child: Text('Create Presensi'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
