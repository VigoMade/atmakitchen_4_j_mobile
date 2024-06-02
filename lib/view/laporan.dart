import 'package:atmakitchen_4_j_mobile/view/Report/stockReportPage.dart';
import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/view/Report/pemakianReport.dart';
import 'package:atmakitchen_4_j_mobile/view/Report/ppReportPage.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({Key? key}) : super(key: key);

  @override
  State<LaporanPage> createState() => _LaporanPageState();
}

class _LaporanPageState extends State<LaporanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset(
          "images/logo.png",
          fit: BoxFit.cover,
          height: 40,
          width: 40,
        ),
        title: const Text(
          "Atma Kitchen",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: const Color.fromARGB(255, 201, 52, 64),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Laporan Page',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            _buildReportButton(
              context,
              label: 'Lihat Pemakaian',
              page: const PemakaianReportPage(),
              icon: Icons.assignment,
            ),
            const SizedBox(height: 20),
            _buildReportButton(
              context,
              label: 'Lihat PP Report',
              page: const PpReportPage(),
              icon: Icons.pie_chart,
            ),
            const SizedBox(height: 20),
            _buildReportButton(
              context,
              label: 'Lihat Stock Report',
              page: const StockReportPage(),
              icon: Icons.storage,
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _buildReportButton(BuildContext context,
      {required String label, required Widget page, required IconData icon}) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(icon, size: 24),
      label: Text(label, style: const TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        backgroundColor: const Color.fromARGB(255, 201, 52, 64),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
