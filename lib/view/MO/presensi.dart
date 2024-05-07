import 'package:atmakitchen_4_j_mobile/view/MO/presensiView.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/presensi.dart'; // Import model Presensi
import 'package:atmakitchen_4_j_mobile/database/API/presensi_data.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:flutter/widgets.dart';

class PresensiPage extends StatefulWidget {
  const PresensiPage({Key? key}) : super(key: key);

  @override
  State<PresensiPage> createState() => _PresensiPageState();
}

class _PresensiPageState extends State<PresensiPage> {
  ApiClient apiClient = ApiClient();
  List<Presensi> _presensiList = []; // List untuk menyimpan data presensi
  bool _isLoading = false; // Menandakan status proses pengambilan data
  DateTime? _selectedDate; // Tanggal yang dipilih

  @override
  void initState() {
    super.initState();
    _selectedDate =
        DateTime.now(); // Atur tanggal yang dipilih menjadi tanggal hari ini
    _fetchPresensi(); // Memanggil fungsi untuk mengambil data presensi saat widget pertama kali dibuat
  }

  // Fungsi untuk mengambil data presensi dari server berdasarkan tanggal yang dipilih
  Future<void> _fetchPresensi() async {
    setState(() {
      _isLoading =
          true; // Menandakan bahwa proses pengambilan data sedang berlangsung
    });

    try {
      // Membuat instance PresensiClient dengan baseUrl yang sesuai
      PresensiClient presensiClient = PresensiClient(ApiClient());

      // Memanggil metode getPresensiList untuk mengambil data presensi
      List<Presensi> presensiList =
          await presensiClient.getPresensiListByDate(_selectedDate!);

      setState(() {
        _presensiList =
            presensiList; // Memperbarui list presensi dengan data yang diperoleh dari server
        _isLoading =
            false; // Menandakan bahwa proses pengambilan data telah selesai
      });
    } catch (e) {
      setState(() {
        _isLoading =
            false; // Menandakan bahwa terjadi kesalahan saat mengambil data
      });
      // Menampilkan pesan kesalahan kepada pengguna
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to load presensi: $e'),
        ),
      );
    }
  }

  // Fungsi untuk menyimpan perubahan status presensi ke server
  Future<void> _savePresensiChanges() async {
    try {
      PresensiClient presensiClient = PresensiClient(ApiClient());

      // Mengirim pembaruan status presensi ke server
      await Future.wait(_presensiList
          .map((presensi) => presensiClient.updatePresensi(presensi)));

      // Menampilkan pesan sukses
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Changes saved successfully'),
        ),
      );
      Navigator.of(context).pop();
    } catch (e) {
      // Menampilkan pesan kesalahan jika gagal menyimpan perubahan
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save changes: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Atma Kitchen",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        backgroundColor: const Color(0xFFAD343E),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Tampilkan loading indicator jika proses pengambilan data sedang berlangsung
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Presensi',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: _savePresensiChanges,
                          child: Text('Simpan',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        'Tanggal: ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _selectedDate != null
                            ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            : 'Belum Dipilih',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:
                              _selectedDate != null ? Colors.black : Colors.red,
                        ),
                      ),
                      SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          _selectDate(context);
                        },
                        child: Text('Pilih Tanggal'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text('Nama Pegawai')),
                        DataColumn(label: Text('Presensi')),
                        DataColumn(label: Text('Ubah')),
                      ],
                      rows: _presensiList.map((presensi) {
                        return DataRow(cells: [
                          DataCell(Text(presensi.namapegawai!)),
                          DataCell(
                            presensi.statusPresensi == "Hadir"
                                ? Text(
                                    presensi.statusPresensi!,
                                    style: TextStyle(color: Colors.blue),
                                  )
                                : Text(
                                    presensi.statusPresensi!,
                                    style: TextStyle(color: Colors.red),
                                  ), // Atau bisa juga Text('Data tidak tersedia') tergantung kebutuhan Anda
                          ),
                          DataCell(
                            DropdownButton<String>(
                              value: presensi.statusPresensi ??
                                  'Alpha', // Nilai default adalah 'Alpha' jika statusPresensi null
                              items: ['Hadir', 'Alpha'].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: value == "Alpha"
                                      ? Text(
                                          value,
                                          style: TextStyle(color: Colors.red),
                                        )
                                      : Text(
                                          value,
                                          style: TextStyle(color: Colors.blue),
                                        ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  presensi.statusPresensi = newValue!;
                                  // Tidak perlu mengirim perubahan langsung ke server di sini, tunggu sampai tombol simpan ditekan
                                });
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // Fungsi untuk memilih tanggal
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked; // Memperbarui tanggal yang dipilih
        _fetchPresensi(); // Mengambil data presensi berdasarkan tanggal yang baru dipilih
      });
    }
  }
}
