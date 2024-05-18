import 'package:atmakitchen_4_j_mobile/model/pegawai.dart';
import 'package:atmakitchen_4_j_mobile/view/index_Mo.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/presensi.dart';
import 'package:atmakitchen_4_j_mobile/database/API/presensi_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/pegawai_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';

class CreatePresensiPage extends StatefulWidget {
  @override
  _CreatePresensiPageState createState() => _CreatePresensiPageState();
}

class _CreatePresensiPageState extends State<CreatePresensiPage> {
  late TextEditingController _statusController;
  late DateTime _selectedDate;
  String? _selectedEmployeeName; // Diganti dengan nama pegawai
  String? _selectedStatus;
  List<Presensi> _employees = [];
  List<Pegawai> _pegawai = [];

  @override
  void initState() {
    super.initState();
    _statusController = TextEditingController();
    _selectedDate = DateTime.now();
    _fetchEmployees();
    _fetchPegawai();
  }

  @override
  void dispose() {
    _statusController.dispose();
    super.dispose();
  }

  Future<void> _fetchEmployees() async {
    PresensiClient presensiClient = PresensiClient(ApiClient());
    try {
      List<Presensi> presensiList = await presensiClient.getPresensiList();
      setState(() {
        _employees = presensiList;
        // _selectedEmployeeName =
        //     _employees.isNotEmpty ? _employees[0].namapegawai : null;
      });
    } catch (e) {
      showSnackBar('Gagal mengambil daftar pegawai: $e');
    }
  }

  Future<void> _fetchPegawai() async {
    PegawaiClient pegawaiClient = PegawaiClient(ApiClient());
    try {
      List<Pegawai> pegawaiList = await pegawaiClient.getPegawaiList();
      setState(() {
        _pegawai = pegawaiList;
        _selectedEmployeeName =
            _pegawai.isNotEmpty ? _pegawai[0].namapegawai : null;
      });
    } catch (e) {
      showSnackBar('Gagal mengambil daftar pegawai: $e');
    }
  }

  Future<void> _createPresensi() async {
    if (_selectedEmployeeName != null &&
        _selectedStatus != null &&
        _selectedDate != null) {
      // Cari ID pegawai berdasarkan nama pegawai
      int? selectedEmployeeId = _pegawai
          .firstWhere((pegawai) => pegawai.namapegawai == _selectedEmployeeName)
          .idPegawai;

      Presensi newPresensi = Presensi(
        statusPresensi: _selectedStatus!,
        tanggalPresensi: _selectedDate,
        idPegawai: selectedEmployeeId,
      );

      PresensiClient presensiClient = PresensiClient(ApiClient());
      try {
        await presensiClient.createPresensi(newPresensi);
        showSnackBar('Presensi berhasil dibuat!');
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => IndexPage(number: 2)));
      } catch (e) {
        showSnackBar(
            'Gagal membuat presensi $_selectedEmployeeName $_selectedDate $_selectedStatus: $e');
      }
    } else {
      showSnackBar(
          'Pilih pegawai, isi status presensi, dan pilih tanggal presensi');
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate)
      setState(() {
        _selectedDate = pickedDate;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Presensi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedEmployeeName ??
                  (_pegawai.isNotEmpty ? _pegawai[0].namapegawai : null),
              onChanged: (value) {
                setState(() {
                  _selectedEmployeeName = value;
                });
              },
              items: _pegawai.map((pegawai) {
                return DropdownMenuItem<String>(
                  value: pegawai.namapegawai!,
                  child: Text(pegawai.namapegawai!),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Nama Pegawai',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              value: _selectedStatus ?? 'Hadir',
              onChanged: (value) {
                setState(() {
                  _selectedStatus = value;
                });
              },
              items: ['Hadir', 'Alpha'].map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(status),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Status Presensi',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ListTile(
              title: Text("Tanggal Presensi"),
              subtitle: Text("${_selectedDate.toLocal()}".split(' ')[0]),
              onTap: () {
                _selectDate(context);
              },
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _createPresensi,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
