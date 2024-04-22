import 'package:flutter/material.dart';
import 'package:atmakitchen_4_j_mobile/eksplore.dart';
import 'package:atmakitchen_4_j_mobile/booking.dart';
import 'package:atmakitchen_4_j_mobile/profile.dart';

class indexPage extends StatefulWidget {
  const indexPage({super.key});

  @override
  State<indexPage> createState() => _indexPageState();
}

class _indexPageState extends State<indexPage> {
  int _selectedIndex = 0; // Indeks halaman saat ini

  static const List<Widget> _widgetOptions = <Widget>[
    ExplorePage(),
    bookingPage(),
    profile(), // Use ProfilePage widget here
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Image.asset("images/logo.png"),
        title: const Text(
          "Atma Kitchen",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 40,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: const Color(0xFFAD343E),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              size: 30,
            ),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bed,
              size: 30,
            ),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(245, 136, 194, 0.482),
        onTap: _onItemTapped,
      ),
    );
  }
}
