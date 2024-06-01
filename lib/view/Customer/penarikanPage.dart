import 'package:atmakitchen_4_j_mobile/view/index_customer.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/model/rekening.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/database/API/penarikan_data.dart';

class PenarikanPage extends StatefulWidget {
  const PenarikanPage({Key? key}) : super(key: key);

  @override
  _PenarikanPageState createState() => _PenarikanPageState();
}

class _PenarikanPageState extends State<PenarikanPage> {
  Rekening? selectedRekening;
  double? totalPenarikan;
  String username = "";
  String email = "";
  String name = "";
  String noTelp = "";
  String image = "";
  int idCustomer = 0;
  List<Rekening> rekeningList = [];

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      idCustomer = sharedPrefs.getInt('id_customer') ?? 0;
      username = sharedPrefs.getString('username') ?? "";
      email = sharedPrefs.getString('email') ?? "";
      name = sharedPrefs.getString('name') ?? "";
      noTelp = sharedPrefs.getString('noTelp') ?? "";
      image = sharedPrefs.getString('image') ?? "";
      loadRekeningData();
    });
  }

  Future<void> loadRekeningData() async {
    try {
      List<Rekening> fetchedRekeningList =
          await PenarikanClient(ApiClient()).getRekeningList(idCustomer);
      setState(() {
        rekeningList = fetchedRekeningList;
      });
    } catch (error) {
      print('Failed to load rekening data: $error');
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penarikan Saldo'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              DropdownButtonFormField<Rekening>(
                value: selectedRekening,
                onChanged: (newValue) {
                  setState(() {
                    selectedRekening = newValue;
                  });
                },
                items: rekeningList.map((Rekening rekening) {
                  return DropdownMenuItem<Rekening>(
                    value: rekening,
                    child:
                        Text("${rekening.nomorRekening} ${rekening.namaBank}"),
                  );
                }).toList(),
                decoration: InputDecoration(
                  labelText: 'Pilih Rekening',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Pilih salah satu rekening';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Total Penarikan',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    totalPenarikan = double.tryParse(value);
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Masukkan total penarikan';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Masukkan angka yang valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (selectedRekening == null || totalPenarikan == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Pilih rekening dan masukkan total penarikan'),
                        duration: Duration(seconds: 2),
                      ));
                      return;
                    }

                    final data = {
                      'id_rekening': selectedRekening!.idRekening,
                      'total_penarikan': totalPenarikan,
                    };

                    try {
                      await PenarikanClient(ApiClient())
                          .createPenarikanSaldo(idCustomer, data);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('Permintaan penarikan saldo berhasil dibuat'),
                        duration: Duration(seconds: 2),
                      ));
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerPage()));
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Gagal membuat permintaan penarikan saldo: $error'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  }
                },
                child: Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
