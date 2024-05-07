import 'package:atmakitchen_4_j_mobile/view/historyView.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  void initState() {
    super.initState();
    // Panggil fungsi untuk mengambil data dari SharedPreferences saat inisialisasi state
    loadUserData();
  }

  // Fungsi untuk mengambil data dari SharedPreferences
  Future<void> loadUserData() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    setState(() {
      // Mengisi variabel dengan data yang diambil dari SharedPreferences
      username = sharedPrefs.getString('username') ?? "";
      email = sharedPrefs.getString('email') ?? "";
      name = sharedPrefs.getString('name') ?? "";
      noTelp = sharedPrefs.getString('noTelp') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.30),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 206, 83, 93),
                  Color.fromARGB(255, 128, 0, 128),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0), // Add margin at top
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // Placeholder image
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
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // No shadow
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
                // Navigator code here
              },
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0), // No elevation
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.history), // Icon
                  SizedBox(width: 5), // Spacing
                  Text("Histori"), // Text
                ],
              ),
            ),
          ),
          Divider(
            // Divider
            height: 1,
            thickness: 1,
            color: Colors.grey,
            indent: 20,
            endIndent: 20,
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
}
