import 'package:atmakitchen_4_j_mobile/database/API/api_client.dart';
import 'package:atmakitchen_4_j_mobile/database/API/penarikan_data.dart';
import 'package:atmakitchen_4_j_mobile/view/Customer/historyPenarikan.dart';
import 'package:atmakitchen_4_j_mobile/view/Customer/penarikanPage.dart';
import 'package:atmakitchen_4_j_mobile/view/DaftarPesanan.dart';
import 'package:atmakitchen_4_j_mobile/view/historyView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:atmakitchen_4_j_mobile/database/API/penarikan_data.dart'; // Import PenarikanClient

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";
  String name = "";
  String noTelp = "";
  String image = "";
  int saldoCustomer = 0;
  int pointCustomer = 0;
  int idCustomer = 0;

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data dari SharedPreferences saat menginisialisasi state
    loadUserData();
    // Panggil fungsi untuk mengambil saldo dari backend
  }

  // Fungsi untuk mengambil data dari SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      // Isi variabel dengan data yang diambil dari SharedPreferences
      username = sharedPrefs.getString('username') ?? "";
      email = sharedPrefs.getString('email') ?? "";
      name = sharedPrefs.getString('name') ?? "";
      noTelp = sharedPrefs.getString('noTelp') ?? "";
      image = sharedPrefs.getString('image') ?? "";
      pointCustomer = sharedPrefs.getInt('point_customer') ?? 0;
      idCustomer = sharedPrefs.getInt('id_customer') ?? 0;
      loadSaldo();
    });
  }

  // Fungsi untuk mengambil saldo dari backend
  Future<void> loadSaldo() async {
    try {
      // Panggil fungsi getSaldo dari PenarikanClient
      int saldo = await PenarikanClient(ApiClient())
          .getSaldo(idCustomer); // Sesuaikan dengan ID customer yang sesuai
      setState(() {
        saldoCustomer = saldo; // Ubah saldo menjadi integer dan perbarui state
      });
    } catch (error) {
      print('Failed to load saldo: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height * 0.40;
    double appBarHeight = MediaQuery.of(context).size.height * 0.60;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 238, 107, 118),
                    Color.fromARGB(255, 254, 80, 94),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(image == ""
                            ? 'https://via.placeholder.com/150'
                            : "http://10.0.2.2:8000/storage/${image}"),
                      ),
                    ),
                    SizedBox(height: 10),
                    _buildUserData("Nama", name),
                    _buildUserData("Email", email),
                    _buildUserData("Username", username),
                    _buildUserData("No. Telepon", noTelp),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: bodyHeight,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              height: appBarHeight,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPage()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.history,
                                size: 50,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Histori",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HistoryPenarikanPage()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.history_edu,
                                size: 50,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "History Penarikan",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PesananPage()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 50,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Pesanan",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PenarikanPage()),
                        );
                      },
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.money,
                                size: 50,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Penarikan",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_right,
                            size: 50,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  // Tambahkan kode untuk menampilkan pesanan dan penarikan
                  // ...
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        _buildCustomerData("Saldo", saldoCustomer),
                        _buildCustomerData("Poin", pointCustomer),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserData(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label : ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerData(String label, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$label : ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Text(
            value.toString(),
            style: TextStyle(fontSize: 16)
            ,
          ),
        ],
      ),
    );
  }
}
