import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/view/MO/presensiView.dart';
import 'package:atmakitchen_4_j_mobile/view/eksplore.dart';
import 'package:atmakitchen_4_j_mobile/view/laporan.dart';
import 'package:atmakitchen_4_j_mobile/profile.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key, required this.number}) : super(key: key);
  final int number;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _selectedIndex = 0; // Inisialisasi indeks default

  static const List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    LaporanPage(),
    presensiView(), // Mengubah presensiView() menjadi PresensiView()
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex =
        widget.number; // Atur nilai indeks dengan nilai dari properti widget
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              size: 24,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.description,
              size: 24,
            ),
            label: 'Laporan',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book,
              size: 24,
            ),
            label: 'Presensi',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 24,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(245, 136, 194, 0.482),
        onTap: _onItemTapped,
        selectedFontSize: 12, // Ukuran font yang lebih kecil
        unselectedFontSize: 12,
      ),
    );
  }
}
